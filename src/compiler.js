const path = require('path');

const {
    handleLiteralPrint,
    handleIdentifierPrint,
    handleFunctionCallPrint,
    handleArrayAccessPrint,
} = require('../helper/handlePrint');

const {
    generateIf,
    generateFor
} = require('../helper/handleControl');

const {
    generateReturn,
    generateFun
} = require('../helper/handleFunction');

class Compiler {
    constructor(ast_tree){
        this.ast_tree = ast_tree;
        this.position = 0;
        this.current = this.ast_tree[this.position];

        this.dataSection = [];
        this.bssSection = [];
        this.textSection = []

        this.subroutineSection = [];
        this.currentFunction = null;

        this.variablesType = {};
        this.index_for = 0;
        this.condition_index = 0;
        this.tempStrVarIndex = 0;
        
        this.generatros = {
            'VarDecl': this.generateVarDecl.bind(this),
            'Print': this.generatePrint.bind(this),
            'If': obj => generateIf(obj, this),
            'For': obj => generateFor(obj, this),
            'FunctionDecl': obj => generateFun(obj, this),
            'Return': obj => generateReturn(obj, this)
        };
    }

    generateVarDecl(obj){
        // console.log(obj);
        const { name, initializer } = obj;
        switch(initializer.type){
            case 'Literal':
                if(typeof initializer.value === 'number'){
                    this.dataSection.push(
                        `\t${name} dd ${initializer.value}\n`
                    );
                    this.variablesType[name] = 'number';
                }
                else if(typeof initializer.value === 'string'){
                    this.dataSection.push(
                        `\t${name} db "${initializer.value}", 0\n`
                    );
                    this.variablesType[name] = 'string';
                }
            break;
            case 'ArrayLiteral':
                const { elements } = initializer;
                const array = elements.map(el => el.value); // simpan semua nilai jadi array
                let decl;

                if(typeof array[0] === 'number'){
                    decl = `\t${name} dd ${array.join(', ')}\n`;
                    this.variablesType[name] = ['number', array.length];
                }
                // else if(typeof array[0] === 'string'){
                //     decl = `\t${name} db \n`;
                //     this.variablesType[name] = ['string', array.length];
                // }
                this.dataSection.push(decl);
                // console.log(elements);
            break;
            case 'BinaryOp':
                // simpan hasil ekspresi ke variabel, misal a = 10 + 5
                this.dataSection.push(`\t${name} dd 0\n`);
                this.variablesType[name] = 'number';

                // generate kode aritmatika
                this.generateBinaryOp(initializer);

                // simpan hasil generate ke variabel
                this.textSection.push(`\tmov [${name}], eax\n\n`);
            break;
        }
    }

    generateOperand(operand){
        if (operand.type === 'Literal') {
            return `\tmov eax, ${operand.value}\n`;
        } else if (operand.type === 'Identifier') {
            return `\tmov eax, [${operand.name}]\n`;
        } else if (operand.type === 'BinaryOp') {
            return this.generateBinaryOp(operand);
        }
        throw new Error(`Unsupported operand type: ${operand.type}`);
    }

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
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push('\tsete al\n');
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
            case '!=': 
                this.textSection.push('\tcmp ecx, eax\n');
                this.textSection.push('\tsetne al\n');
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
            handleFunctionCallPrint(expression, this);
        }
    }

    generateStatement(statement){
        const generator = this.generatros[statement.type];
        if(generator){
            // console.log(generator);
            return generator(statement);
        }
    }

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
            ...this.dataSection,
            '\n',
            'section .bss\n',
            ...this.bssSection,
            '\n',
            'section .text\n',
            '\tglobal _start\n\n',
            '\n',
            '_start:\n',
            ...this.textSection,
            '\n',
            `\tmov eax, 1\n`,
            '\txor ebx, ebx\n',
            '\tint 0x80\n',
            ...this.subroutineSection
        ].join('');
    }
};

module.exports = Compiler;


// matikan command di print