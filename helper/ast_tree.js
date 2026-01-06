class ProgramStmt {
    constructor(statements){
        this.type = 'Program';
        this.statements = statements;
    }
}

// variabel
class VarDeclStmt {
    constructor(name, initializer, line){
        this.type = 'VarDecl';
        this.line = line;
        this.name = name;
        this.initializer = initializer;
    }
};


// assign
class AssignmentStmt {
    constructor(variable, initializer, line){
        this.type = 'Assign';
        this.line = line;
        this.variable = variable;
        this.initializer = initializer;
    }
};


// print
class PrintStmt {
    constructor(expression, line){
        this.type = 'Print';
        this.line = line;
        this.expression = expression;
    }
};


// if elif else
class IfStmt {
    constructor(condition, then_block, elifs, else_block, line){
        this.type = 'If';
        this.line = line;
        this.condition = condition;
        this.then_block = then_block;
        this.elifs = elifs;             // list of else
        this.else_block = else_block;
    }
};

class ElifStmt {
    constructor(condition, block, line){
        this.type = 'Elif';
        this.line = line;
        this.condition = condition;
        this.block = block;
    }
};


// for loop
class ForStmt {
    constructor(iterator, endExpr, step, block, line){
        this.type = 'For';
        this.line = line;
        this.iterator = iterator;
        this.endExpr = endExpr;
        this.step = step;
        this.block = block;
    }
}

// array
class ArrayLiteralStmt {
    constructor(elements, line){
        this.type = 'ArrayLiteral';
        this.line = line;
        this.elements = elements;
    }
};

class ArrayAccessStmt {
    constructor(array_name, index, line){
        this.type = 'ArrayAccess';
        this.line = line;
        this.array_name = array_name;
        this.index = index;
    }
};


// fungsi
class FunctionDeclStmt {
    constructor(name, params, body, line){
        this.type = 'FunctionDecl';
        this.line = line;
        this.name = name;
        this.params = params;
        this.body = body;
    }
};

class ReturnStmt {
    constructor(value, line){
        this.type = 'Return';
        this.line = line;
        this.value = value;
    }
};


// ekspresi
class BinaryOpStmt {
    constructor(left, op, right, line){
        this.type = 'BinaryOp';
        this.line = line;
        this.left = left;
        this.op = op;
        this.right = right;
    }
};

class UnaryOpStmt {
    constructor(op, operand, line){
        this.type = 'UnaryOp';
        this.line = line;
        this.op = op;
        this.operand = operand;
    }
}

class LiteralStmt {
    constructor(value, line){
        this.type = 'Literal';
        this.line = line;
        this.value = value;
    }
};

class IdentifierStmt {
    constructor(name, line){
        this.type = 'Identifier';
        this.line = line;
        this.name = name;
    } 
};

class FunctionCallStmt {
    constructor(name, args, line){
        this.type = 'FunctionCall';
        this.line = line;
        this.name = name;
        this.args = args;
    }
};

class TypeofStmt {
    constructor(expression, line){
        this.type = 'Typeof';
        this.line = line;
        this.expression = expression;
    }
}

class InputStmt {
    constructor(line){
        this.type = 'Input';
        this.line = line;
    }
}

class UseStmt {
    constructor(module, alias = null, line){
        this.type = 'Use';
        this.line = line;
        this.module = module;
        this.alias = alias;
    }
}

module.exports = {
    ProgramStmt,
    VarDeclStmt,
    AssignmentStmt,
    PrintStmt,
    IfStmt,
    ElifStmt,
    ForStmt,
    ArrayLiteralStmt,
    ArrayAccessStmt,
    FunctionDeclStmt,
    ReturnStmt,
    BinaryOpStmt,
    UnaryOpStmt,
    LiteralStmt,
    IdentifierStmt,
    FunctionCallStmt,
    TypeofStmt,
    InputStmt,
    UseStmt
};