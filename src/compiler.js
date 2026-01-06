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
const generateUnaryOp = require('./expressions/generateUnaryOp');

class Compiler {
  constructor(ast_tree) {
    this.ast_tree = ast_tree;

    // Sections
    this.dataSection = [];
    this.bssSection = [];
    this.textSection = [];        // current active section (default: _start)
    this.functiontSection = [];   // emitted function bodies

    // Scope stack (each scope: { varName: meta })
    this.variables = [Object.create(null)];

    // Function registry
    // { name, paramCount, paramNames }
    this.functionNames = [];

    // Counters / labels
    this.labelCounter = 0;
    this.stringLiteralCounter = 0;
    this.ifCounter = 0;
    this.forCounter = 0;

    // Local stack allocation tracking (if you use stack locals)
    this.currentOffset = 0;

    this.indentLevel = 1;

    this.module = [];

    // Optional: globals registry if you want to track it
    this.global = Object.create(null);
  }

  // -----------------------------
  // Scope helpers
  // -----------------------------
  enterScope() {
    this.indentLevel++;
    this.variables.push(Object.create(null));
  }

  exitScope() {
    if (this.variables.length <= 1) {
      throw new Error('Cannot exit global scope');
    }
    this.indentLevel--;
    const scope = this.variables.pop();
    
    this.emit(`push eax`);
    let localStackSize = 0; // hanya ebp - x

    // free heap
    for(const name in scope){
      const v = scope[name];
      this.emit(`; free alamat heap variabel ${name}`);
      
      if(v.kind === 'param'){
        this.emit(`mov eax, [ebp + ${v.offset}]`);  
      }
      else {
        this.emit(`mov eax, [ebp - ${v.offset}]`);
        localStackSize += 4;
      }
      
      this.emit(`push 8`);
      this.emit(`push eax`);
      this.emit(`call dealloc`);
      this.emit(`add esp, 8`);
    
    }
    this.emit(`pop eax`);
    // free stack
    if (localStackSize > 0) {
      this.emit(`add esp, ${localStackSize}`);
      this.currentOffset -= localStackSize;
    }
  }

  // untuk menggantikan push ke text section manual agar tidak hardcode indent
  emit(line = "") {
      const indent = "    ".repeat(this.indentLevel);
      this.textSection.push(indent + line + "\n");
  }

  blank(n = 1) {
      for (let i = 0; i < n; i++) {
          this.textSection.push("\n");
      }
  }


  // mencari variabel dari scope terdalam hingga ke global
  resolveVar(name) {
    for (let i = this.variables.length - 1; i >= 0; i--) {
      if (Object.prototype.hasOwnProperty.call(this.variables[i], name)) {
        return this.variables[i][name];
      }
    }
    return null;
  }

  // mendaftarkan variabel ke scope aktif
  defineVar(name, meta) {
    const scope = this.variables[this.variables.length - 1];
    if (Object.prototype.hasOwnProperty.call(scope, name)) {
      throw new Error(`Variable "${name}" already declared in this scope`);
    }
    scope[name] = meta;
    return meta;
  }

  // membuat label unik
  newLabel(prefix = 'L') {
    this.labelCounter += 1;
    return `${prefix}_${this.labelCounter}`;
  }

  // menyimpan metadata fungsi deklarasi
  registerFunction({ name, paramCount = 0, paramNames = [] }) {
    const existing = this.functionNames.find(fn => fn.name === name);
    if (existing) {
      // You can decide to allow redeclare or not
      throw new Error(`Function "${name}" already defined`);
    }
    this.functionNames.push({ name, paramCount, paramNames });
  }

  // memvalidasi funtion call
  resolveFunction(name) {
    return this.functionNames.find(fn => fn.name === name) || null;
  }


  generateStatement(stmt) {
    switch (stmt.type) {
      case 'Print':
        return handlePrint(this, stmt);

      case 'VarDecl':
        return handleVarDecl(this, stmt);

      case 'Assign':
        return handleAssign(this, stmt);

      case 'If':
        return handleIf(this, stmt);

      case 'For':
        return handleFor(this, stmt);

      case 'FunctionDecl':
        return handleFunDecl(this, stmt);

      case 'FunctionCall':
        return handleFunCall(this, stmt);

      case 'Return': {
        const { value } = stmt;

        const { box } = this.generateExpression(value);

        return { box: false, val: null };
      }

      default:
        console.log('Unknown statement:', stmt);
        return;
    }
  }


  generateExpression(expr, mode = 'non-condition') {
    // console.log(expr.type, ' : mode dalam expr: ', mode);
    
    if (!expr || !expr.type) {
      throw new Error(`Invalid expression: ${JSON.stringify(expr)}`);
    }

    switch (expr.type) {
      case 'Literal':
        return generateLiteral(this, expr, mode);

      case 'BinaryOp':
        return generateBinaryOp(this, expr, mode);

      case 'UnaryOp':
        return generateUnaryOp(this, expr);

      case 'Identifier':
        return generateIdentifier(this, expr);

      case 'FunctionCall':
        return handleFunCall(this, expr);

      default:
        console.log('Unknown expression:', expr);
        return null;
    }
  }


  generate() {
    if (!this.ast_tree || !this.ast_tree.statements) {
      throw new Error('AST tree is missing "statements"');
    }

    for (const statement of this.ast_tree.statements) {
      this.generateStatement(statement);
    }

    // Build final asm
    return [
      `%include "${path.join(__dirname, '..', '/helper/stdio.asm')}"\n`,
      'section .data\n',
      ...this.dataSection,

      '\nsection .bss\n',
      ...this.bssSection,

      '\nsection .text\n',
      '\tglobal _start\n\n',
      '_start:\n',
      '\tpush ebp\n',
      '\tmov ebp, esp\n\n',

      ...this.textSection,

      '\n\tmov esp, ebp\n',
      '\tpop ebp\n\n',
      '\tmov eax, 1\n',
      '\txor ebx, ebx\n',
      '\tint 0x80\n\n',

      ...this.functiontSection,
    ].join('');
  }
}

module.exports = Compiler;
