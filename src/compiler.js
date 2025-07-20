const path = require('path');

const {
    handleLiteralPrint,
    handleIdentifierPrint,
    handleFunctionCallPrint,
    handleArrayAccessPrint,
    handleTypeofPrint
} = require('../helper/handlePrint');

const {
    generateIf,
    generateFor
} = require('../helper/handleControl');

const {
    generateReturn,
    generateFun
} = require('../helper/handleFunction');

const {
    allocateStack,
    allocateHeap,
    initStackValue
} = require('../helper/allocate');

class Compiler {
    /**
     * Membuat instance baru dari Compiler
     * @param {Object} ast_tree - AST dari program sumber
     */
    constructor(ast_tree){
        this.ast_tree = ast_tree;
        this.position = 0;
        this.current = this.ast_tree[this.position];

        this.textSection = [];
        
        this.symbolTable = {};
        this.currentStackOffset = 0;
        
        this.subroutineSection = [];
        this.currentFunction = null;
        
        this.dataSection = [];
        this.bssSection = [];
        // this.variablesType = {};


        this.predefinedTypes = {
            number: 'type_number',
            string: 'type_string',
            boolean: 'type_boolean',
            unknown: 'type_unknown'
        };
        

        this.returnEncountered = false;


        this.index_for = 0;
        this.condition_index = 0;
        this.tempStrVarIndex = 0;
        
        /** @type {Object<string, Function>} */
        this.generators = {
            'VarDecl': this.generateVarDecl.bind(this),
            'Print': this.generatePrint.bind(this),
            'If': obj => generateIf(obj, this),
            'For': obj => generateFor(obj, this),
            'FunctionDecl': obj => generateFun(obj, this),
            'Return': obj => generateReturn(obj, this),
            'FunctionCall': obj => handleFunctionCallPrint(obj, this),
        };
    }

    isStringOperand(node) {
        if (node.type === 'Literal') {
            return typeof node.value === 'string';
        }
    
        if (node.type === 'Typeof') {
            return true; // typeof selalu menghasilkan string
        }
    
        if (node.type === 'Identifier') {
            const info = this.symbolTable[node.name];
            if (!info) return false;
            if (info.type === 'string') return true;
    
            // handle identifikasi label seperti type_number, type_string, dsb
            const label = this.predefinedTypes[info.type];
            return label !== undefined;
        }
    
        return false;
    }
    
    

    /**
     * Meng-generate deklarasi variabel
     * @param {Object} obj - AST node dari deklarasi variabel
     */
    generateVarDecl(obj){
        // console.log(obj);
        const { name, initializer } = obj;
        switch(initializer.type){
            case 'Literal':
                if(typeof initializer.value === 'number'){
                    allocateStack(this, name, initializer, 4);
                    initStackValue(this, name, initializer);
                }
                else if(typeof initializer.value === 'string'){
                    allocateStack(this, name, initializer, initializer.value.length);
                    initStackValue(this, name, initializer);
                }
                else if(typeof initializer.value === 'boolean'){
                    allocateStack(this, name, initializer, 1);
                    initStackValue(this, name, initializer);
                }
                
            break;
            case 'ArrayLiteral':
                const { elements } = initializer;                
                const elementSize = 4;
                const totalSize = elementSize * elements.length;
                
                // console.log(initializer);
                allocateStack(this, name, initializer, totalSize);
                initStackValue(this, name, initializer);
            break;
            case 'BinaryOp':
                // simpan hasil ekspresi ke variabel, misal a = 10 + 5
                this.textSection.push(`\t\n`);
                allocateStack(this, name, {type: 'Literal', value: 0}, 4);

                // generate kode aritmatika
                this.generateBinaryOp(initializer);

                // simpan hasil generate ke variabel
                initStackValue(this, name, {type: 'Literal', value: 'binaryOp'});
            break;
        }
    }

    /**
     * Generate operand literal, identifier, atau binary expression
     * @param {Object} operand - AST node operand
     * @returns {string} instruksi assembly
     */
    generateOperand(operand){
        if (operand.type === 'Literal') {            
            if (typeof operand.value === 'string') {
                // Buat label unik di section .data
                const labelName = `str_${this.tempStrVarIndex++}`;
                this.dataSection.push(`${labelName} db "${operand.value}", 0\n`);
                return `\tmov eax, ${labelName}\n`;
            }
            else if (typeof operand.value === 'boolean') {
                return `\tmov eax, ${operand.value ? 1 : 0}\n`;
            }
            else { // untuk angka
                return `\tmov eax, ${operand.value}\n`;
            }
        }
        else if (operand.type === 'Identifier') { // contoh: a < 5
            const variableData = this.symbolTable[operand.name];
            const offset = variableData.offset;
            if (offset >= 0) {
                return `\tmov eax, [ebp + ${offset}]\n`; // parameter fungsi
            } else {
                return `\tmov eax, [ebp - ${Math.abs(offset)}]\n`; // variabel lokal
            }
        }
        else if (operand.type === 'BinaryOp') {
            return this.generateBinaryOp(operand);
        }
        else if (operand.type === 'Typeof') {
            const expr = operand.expression;
        
            let typeStr = 'unknown';
            if (expr.type === 'Identifier') {
                const varInfo = this.symbolTable[expr.name];
                typeStr = varInfo?.type || 'unknown';
            } else if (expr.type === 'Literal') {
                const jsType = typeof expr.value;
                if (jsType === 'number' || jsType === 'string' || jsType === 'boolean') {
                    typeStr = jsType;
                }
            }
        
            const label = this.predefinedTypes[typeStr] || this.predefinedTypes['unknown'];
            return `\tmov eax, ${label}\n`;
        }
        throw new Error(`Unsupported operand type: ${operand.type}`);
    }

    /**
     * Generate operasi aritmatika biner (BinaryOp) ke dalam instruksi assembly
     * @param {Object} expr - AST node binary expression
     */
    generateBinaryOp(expr){
        const { left, op: operator, right } = expr;
        
        // handle operand kiri
        if(left.type === 'BinaryOP'){
            this.generateBinaryOp(left);
        }
        else {
            const leftCode = this.generateOperand(left);
            this.textSection.push(leftCode);
        }
        this.textSection.push('\tpush eax\n');


        // handle operand kanan
        if (right.type === 'BinaryOp') {
            this.generateBinaryOp(right);
        } else {
            const rightCode = this.generateOperand(right);
            this.textSection.push(rightCode);
        }
        this.textSection.push('\tpop ecx\n');
    
        // cek apakah string matching
        const leftIsString = this.isStringOperand(left);
        const rightIsString = this.isStringOperand(right);
        const isStringComparison = (leftIsString && rightIsString);

        // sekarang operasi, kiri di stack, kanan di eax
        switch(operator) {
            case '+':
                this.textSection.push('\tadd eax, ecx\n');
                break;
            case '-':
                this.textSection.push('\tsub ecx, eax\n');
                this.textSection.push('\tmov eax, ecx\n');
                break;
            case '*':
                this.textSection.push('\timul eax, ecx\n');
                break;
            case '/':
                this.textSection.push('\txchg eax, ecx\n');
                this.textSection.push('\tcdq\n');
                // CDQ digunakan agar pembagian bilangan bertanda (signed division) dengan IDIV bisa berjalan benar.
                // Cara kerja:
                // Jika EAX bernilai positif, maka EDX diisi 0.
                // Jika EAX bernilai negatif, maka EDX diisi 0xFFFFFFFF (semua bit 1, artinya -1 dalam signed 32-bit).
                // Ini menciptakan nilai 64-bit di EDX:EAX yang merupakan sign-extended dari EAX.
                this.textSection.push('\tidiv ecx\n');
                break;
            case '<': 
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push('\tsetl al\n');
                this.textSection.push('\tmovzx eax, al\n');
                break;
            case '>': 
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push('\tsetg al\n');
                this.textSection.push('\tmovzx eax, al\n');
                break;
            case '==':
            case '!=':
                if (isStringComparison) {
                    this.textSection.push('\tpush ecx\n'); // left string
                    this.textSection.push('\tpush eax\n'); // right string
                    this.textSection.push('\tcall string_equal\n');
                    this.textSection.push('\tadd esp, 8\n'); // bersihkan argumen
        
                    if (operator === '==') {
                        this.textSection.push('\tcmp eax, 1\n');
                        this.textSection.push('\tsete al\n');
                        this.textSection.push('\tmovzx eax, al\n');
                    }
                    else {
                        this.textSection.push('\tcmp eax, 1\n');
                        this.textSection.push('\tsetne al\n');
                        this.textSection.push('\tmovzx eax, al\n');
                    }
                    break;
                }
        
                // fallback ke perbandingan angka
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push(operator === '==' ? '\tsete al\n' : '\tsetne al\n');
                this.textSection.push('\tmovzx eax, al\n');
                break;        
            case '<=': 
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push('\tsetle al\n');
                this.textSection.push('\tmovzx eax, al\n');
                break;
            case '>=': 
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push('\tsetge al\n');
                this.textSection.push('\tmovzx eax, al\n');
                break;
            // case '!': 
            //     this.textSection.push('\tcmp eax, 0\n');    // if 0 return 1 else 0
            //     this.textSection.push('\tsete al\n');
            //     this.textSection.push('\tmovzx eax, al\n');
            //     break;
            default: throw new Error('Operator not supported');
        }
    }

    /**
     * Generate instruksi untuk statement Print
     * @param {Object} obj - AST node Print
     */
    generatePrint(obj){
        const { expression } = obj;
        // console.log(expression);
        if(expression.type === 'Identifier'){
            handleIdentifierPrint(expression, this);
        }
        else if(expression.type === 'Literal'){
            handleLiteralPrint(expression, this);
        }
        else if(expression.type === 'BinaryOp'){
            // generate kode aritmatika
            this.generateBinaryOp(expression);
            
            // cetak hasil
            this.textSection.push(
                `\tpush eax\n` +
                `\tcall print_int\n` + 
                `\tadd esp, 4\n` + 
                `\tcall newline\n\n`
            );
        }
        else if(expression.type === 'ArrayAccess'){
            handleArrayAccessPrint(expression, this);
        }
        else if(expression.type === 'FunctionCall'){
            handleFunctionCallPrint(expression, this, { shouldPrint: true });
        }
        else if (expression.type === 'Typeof') {
            handleTypeofPrint(expression, this);
        }
    }

    /**
     * Panggil generator untuk statement sesuai tipenya
     * @param {Object} statement - AST statement
     */
    generateStatement(statement){
        const generator = this.generators[statement.type];
        if(generator){
            // console.log(generator);
            return generator(statement);
        }
    }

    /**
     * Entry point untuk generate seluruh kode dari AST
     * @returns {string} Kode assembly yang digabung jadi satu string
     */
    generate(){
        for (const statement of this.ast_tree.statements){
            // console.dir(statement, {depth: null});
            this.generateStatement(statement);
            // console.log(this.variablesType);
        }
        return [
            `%include "${path.join(__dirname, "..",  "/helper/stdio.asm")}"\n`,
            'section .data\n',
            '\tspace db " ", 0\n',
            '\ttrue_txt db "true", 0\n',
            '\tfalse_txt db "false", 0\n',
            `\ttype_number  db "number", 0\n`,
            `\ttype_string  db "string", 0\n`,
            `\ttype_boolean db "boolean", 0\n`,
            `\ttype_unknown db "unknown", 0\n`,
            ...this.dataSection,
            '\n',
            'section .bss\n',
            ...this.bssSection,
            '\n',
            'section .text\n',
            '\tglobal _start\n\n',
            '\n',
            '_start:\n',
            '\tpush ebp\n',
            '\tmov ebp, esp\n\n',
            ...this.textSection,
            '\n\tmov esp, ebp\n',
            '\tpop ebp\n',
            `\tmov eax, 1\n`,
            '\txor ebx, ebx\n',
            '\tint 0x80\n\n',
            ...this.subroutineSection,

            // sementara saja
            `\n\n\nprint_boolean:\n`,
            `\tcmp byte [ecx], 1\n`,
            `\tje .print_true\n`,
            '\tjne .print_false\n',
            '\n',
            `.print_true:\n`,
            `\tmov ecx, true_txt\n`,
            `\tje .prnt\n`,
            '\n',
            `.print_false:\n`,
            `\tmov ecx, false_txt\n`,
            '\n',
            `.prnt:\n`,
            `\tcall print_str\n`,
            `\tret\n`
        ].join('');
    }
};

module.exports = Compiler;


// matikan command di print