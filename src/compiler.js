const path = require('path');
const generateLiteral = require('./expressions/generateLiteral');
const generateBinaryOp = require('./expressions/generateBinaryOp');
const generateIdentifier = require('./expressions/generateIdentifier');
const handlePrint = require('./statements/handlePrint');
const handleVarDecl = require('./statements/handleVarDecl');
const handleIf = require('./statements/handleIf');
const handleFor = require('./statements/handleFor');

class Compiler {
    constructor(ast_tree){
        this.ast_tree = ast_tree;
        this.position = 0;
        this.current = this.ast_tree[this.position];

        this.dataSection = [];
        this.bssSection = [];
        this.textSection = [];  // text section adalah bagian currentSection
        this.functiontSection = [];

        this.variables = [
            {
                /*
                offset
                type
                size
                */
            }
        ];

        this.functionNames = [];

        this.global = { /* name: name */};

        this.currentOffset = 0;



        this.stringLiteralCounter = 0;
        this.ifCounter = 0;
        this.forCounter = 0;
    }


    enterScope(){
        this.variables.push({});
    }

    exitScope(){
        this.variables.pop();
    }

    generateStatement(stmt){
        if(stmt.type === 'Print'){
            handlePrint(this, stmt);
        }
        else if(stmt.type === 'VarDecl'){ // lanjut untuk ini
            handleVarDecl(this, stmt);
        }
        else if(stmt.type === 'If'){
            handleIf(this, stmt);
        }
        else if(stmt.type === 'For'){
            handleFor(this, stmt);
        }
        else if(stmt.type === 'FunctionDecl'){
            const { name, params, body } = stmt;
        
            if(params){
                console.log(params);
                
            }

            const oldSection = this.textSection; // current section sekarang adalah function body
        
            // arahkan semua statement fungsi ke funcBody
            this.textSection = [];

            this.enterScope();
            this.textSection.push(
                `\tpush ebp    ; buat stack frame baru\n`,
        	    `\tmov ebp, esp\n`
            );
            for(const innerStmt of body){
                this.generateStatement(innerStmt);
            }
            this.textSection.push(
        	    `\tmov esp, ebp    ; bersihkan stack frame saat fungsi selesai\n`,
                `\tpop ebp\n`
            );
            this.exitScope();
        
            // baru tulis definisi fungsi
            this.functiontSection.push(`${name}:\n`);
            this.functiontSection.push(...this.textSection);
            this.functiontSection.push(`\tret\n\n`);
            
            // balik lagi ke section lama (_start)
            this.textSection = oldSection;

            this.functionNames.push(name);
        }
        else if(stmt.type === 'FunctionCall'){
            const { name, args } = stmt;
            const identifier = this.generateExpression(name).value;

            this.textSection.push(
                `\tcall ${identifier}\n`
            );
        }
        else if(stmt.type === 'Return'){
            const value = this.generateExpression(stmt.value).value;
            const size = this.getSizeFromType(typeof(value));
            // this.textSection.push(`\tmov eax, ${value}\n`);
        }
        else {
            console.log(stmt);
        }
    }

    getSizeFromType(type){
        if(type === 'number') return 4;
        if(type === 'string') return 4; // pointer ke string ukuran 4 byte karna 32 bit
        if(type === 'boolean') return 1;
        return 4;
    }


    generateExpression(expr){
        // console.log(expr)
        if(expr.type === 'Literal'){
            return generateLiteral(this, expr);
        }
        else if(expr.type === 'BinaryOp'){
            return generateBinaryOp(this, expr);
        }
        else if(expr.type === 'Identifier'){
            return generateIdentifier(this, expr);
        }
        else {
            console.log(expr);   
        }
    }

    generate(){
        for(const statement of this.ast_tree.statements){
            this.generateStatement(statement);
        }

        console.log("variable setelah semua statement berakir:\n", this.variables);

        

        return [
            `%include "${path.join(__dirname, "..",  "/helper/stdio.asm")}"\n`,
            'section .data\n',

            ...this.dataSection,

            '\nsection .bss\n\n',
            'section .text\n',
            '\tglobal _start\n\n',
            '_start:\n',
            '\tpush ebp\n',
            '\tmov ebp, esp\n\n',

            ...this.textSection,

            '\n\tmov esp, ebp\n',
            '\tpop ebp\n\n',
            `\tmov eax, 1\n`,
            '\txor ebx, ebx\n',
            '\tint 0x80\n\n',
            ...this.functiontSection,
        ].join('');
    }
};

module.exports = Compiler;