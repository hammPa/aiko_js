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
        this.textSection = [];
        this.functiontSection = [];

        this.variables = {
            /*
            offset
            type
            size
            */
        };

        this.global = { /* name: name */};

        this.currentOffset = 0;



        this.stringLiteralCounter = 0;
        this.ifCounter = 0;
        this.forCounter = 0;
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
    }

    generate(){
        for(const statement of this.ast_tree.statements){
            this.generateStatement(statement);
        }

        console.log(this.variables);

        

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
        ].join('');
    }
};

module.exports = Compiler;