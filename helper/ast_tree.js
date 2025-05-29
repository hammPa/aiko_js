class ProgramStmt {
    constructor(statements){
        this.type = 'Program';
        this.statements = statements;
    }
}

// variabel
class VarDeclStmt {
    constructor(name, initializer){
        this.type = 'VarDecl';
        this.name = name;
        this.initializer = initializer;
    }
};


// print
class PrintStmt {
    constructor(expression){
        this.type = 'Print';
        this.expression = expression;
    }
};


// if elif else
class IfStmt {
    constructor(condition, then_block, elifs, else_block){
        this.type = 'If';
        this.condition = condition;
        this.then_block = then_block;
        this.elifs = elifs;             // list of else
        this.else_block = else_block;
    }
};

class ElifStmt {
    constructor(condition, block){
        this.type = 'Elif';
        this.condition = condition;
        this.block = block;
    }
};


// for loop
class ForStmt {
    constructor(var_name, start, end, step, block){
        this.type = 'For';
        this.var_name = var_name;
        this.start = start;
        this.end = end;
        this.step = step;
        this.block = block;
    }
};


// array
class ArrayLiteralStmt {
    constructor(elements){
        this.type = 'ArrayLiteral';
        this.elements = elements;
    }
};

class ArrayAccessStmt {
    constructor(array_name, index){
        this.type = 'ArrayAccess';
        this.array_name = array_name;
        this.index = index;
    }
};


// fungsi
class FunctionDeclStmt {
    constructor(name, params, body){
        this.type = 'FunctionDecl';
        this.name = name;
        this.params = params;
        this.body = body;
    }
};

class ReturnStmt {
    constructor(value){
        this.type = 'Return';
        this.value = value;
    }
};


// ekspresi
class BinaryOpStmt {
    constructor(left, op, right){
        this.type = 'BinaryOp';
        this.left = left;
        this.op = op;
        this.right = right;
    }
};

class LiteralStmt {
    constructor(value){
        this.type = 'Literal';
        this.value = value;
    }
};

class IdentifierStmt {
    constructor(name){
        this.type = 'Identifier';
        this.name = name;
    } 
};

class FunctionCallStmt {
    constructor(name, args){
        this.type = 'FunctionCall';
        this.name = name;
        this.args = args;
    }
};


module.exports = {
    ProgramStmt,
    VarDeclStmt,
    PrintStmt,
    IfStmt,
    ElifStmt,
    ForStmt,
    ArrayLiteralStmt,
    ArrayAccessStmt,
    FunctionDeclStmt,
    ReturnStmt,
    BinaryOpStmt,
    LiteralStmt,
    IdentifierStmt,
    FunctionCallStmt
};