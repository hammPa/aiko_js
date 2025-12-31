const path = require('path');
const generateLiteral = require('./expressions/generateLiteral');
const generateBinaryOp = require('./expressions/generateBinaryOp');
const generateIdentifier = require('./expressions/generateIdentifier');
const handlePrint = require('./statements/handlePrint');
const handleVarDecl = require('./statements/handleVarDecl');
const handleIf = require('./statements/handleIf');
const handleFor = require('./statements/handleFor');
const handleAssign = require('./statements/handleAssign');
const handleFunCall = require('./statements/handleFunCall');
const handleFunDecl = require('./statements/handleFunDecl');

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
                value
                isParam = false is default
                */
            }
        ];
        this.checkEbxTypeLabelCounter = 0;

        this.functionNames = [
            /*{
                name: name,
                paramCount: params ? params.length : 0,
                paramNames: params ? params.map(p => p.name) : []
            }*/
        ];

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

    newLabel(prefix) {
        this.checkEbxTypeLabelCounter++;
        return `${prefix}_${this.checkEbxTypeLabelCounter}`;
    };

    generateStatement(stmt){
        if(stmt.type === 'Print'){
            handlePrint(this, stmt);
        }
        else if(stmt.type === 'VarDecl'){ // lanjut untuk ini
            handleVarDecl(this, stmt);
        }
        else if(stmt.type === 'Assign'){
            handleAssign(this, stmt);
        }
        else if(stmt.type === 'If'){
            handleIf(this, stmt);
        }
        else if(stmt.type === 'For'){
            handleFor(this, stmt);
        }
        else if(stmt.type === 'FunctionDecl'){
            handleFunDecl(this, stmt);
        }
        else if(stmt.type === 'FunctionCall'){
            handleFunCall(this, stmt);
        }
        else if(stmt.type === 'Return'){
            const result = this.generateExpression(stmt.value);
            const value = result.value;

            // console.log({result});
            const size = this.getSizeFromType(typeof(value));
            
            const ty = typeof value;
            
            if(ty === 'string'){ // karna di generateLiteral hanya sampai pembuatan string global, maka pindahkan itu ke eax
                this.textSection.push(`\tmov eax, ${value}\n`);
            }
            
            if(ty === 'object'){
                console.log({ty}, {value});
                this.textSection.push(`\tmov ebx, ${typeof value.value === 'number' ? 0 : 1}\n`);
            }
            else {
                this.textSection.push(`\tmov ebx, ${ty === 'number' ? 0 : 1}\n`);
            }

            

        }
        else {
            console.log("stmt lain:", stmt);
        }
    }

    getSizeFromType(type){
        if(type === 'number') return 4;
        if(type === 'string') return 4; // pointer ke string ukuran 4 byte karna 32 bit
        if(type === 'boolean') return 1;
        return 4;
    }


    generateExpression(expr, mode = "write"){
        // console.log(expr)
        if(expr.type === 'Literal'){
            return generateLiteral(this, expr);
        }
        else if(expr.type === 'BinaryOp'){
            return generateBinaryOp(this, expr);
        }
        else if(expr.type === 'Identifier'){
            return generateIdentifier(this, expr, mode);
        }
        else if(expr.type === 'FunctionCall'){
            return handleFunCall(this, expr);
        }
        else {
            console.log(expr);   
        }
    }

    generate(){
        for(const statement of this.ast_tree.statements){
            this.generateStatement(statement);
        }

        // console.log(this.functiontSection);
        
        // console.log("variable setelah semua statement berakir:\n", this.variables);

        

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