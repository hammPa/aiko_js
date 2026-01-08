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
        this.name = name;
        this.initializer = initializer;
        this.line = line;
    }
};


// assign
class AssignmentStmt {
    constructor(variable, initializer, line){
        this.type = 'Assign';
        this.variable = variable;
        this.initializer = initializer;
        this.line = line;
    }
};


// print
class PrintStmt {
    constructor(expression, line){
        this.type = 'Print';
        this.expression = expression;
        this.line = line;
    }
};


// if elif else
class IfStmt {
    constructor(condition, then_block, elifs, else_block, line){
        this.type = 'If';
        this.condition = condition;
        this.then_block = then_block;
        this.elifs = elifs;             // list of else
        this.else_block = else_block;
        this.line = line;
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
        this.iterator = iterator;
        this.endExpr = endExpr;
        this.step = step;
        this.block = block;
        this.line = line;
    }
}

// array
class ArrayLiteralStmt {
    constructor(elements, line){
        this.type = 'ArrayLiteral';
        this.elements = elements;
        this.line = line;
    }
};

class ArrayAccessStmt {
    constructor(array_name, index, line){
        this.type = 'ArrayAccess';
        this.array_name = array_name;
        this.index = index;
        this.line = line;
    }
};


// fungsi
class FunctionDeclStmt {
    constructor(name, params, body, line){
        this.type = 'FunctionDecl';
        this.name = name;
        this.params = params;
        this.body = body;
        this.line = line;
    }
};

class ReturnStmt {
    constructor(value, line){
        this.type = 'Return';
        this.value = value;
        this.line = line;
    }
};


// ekspresi
class BinaryOpStmt {
    constructor(left, op, right, line){
        this.type = 'BinaryOp';
        this.left = left;
        this.op = op;
        this.right = right;
        this.line = line;
    }
};

class UnaryOpStmt {
    constructor(op, operand, line){
        this.type = 'UnaryOp';
        this.op = op;
        this.operand = operand;
        this.line = line;
    }
}

class LiteralStmt {
    constructor(value, line){
        this.type = 'Literal';
        this.value = value;
        this.line = line;
    }
};

class IdentifierStmt {
    constructor(name, line){
        this.type = 'Identifier';
        this.name = name;
        this.line = line;
    } 
};

class FunctionCallStmt {
    constructor(name, args, line){
        this.type = 'FunctionCall';
        this.name = name;
        this.args = args;
        this.line = line;
    }
};

class TypeofStmt {
    constructor(expression, line){
        this.type = 'Typeof';
        this.expression = expression;
        this.line = line;
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
        this.module = module;
        this.alias = alias;
        this.line = line;
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