const Lexer = require('../src/lexer.js');
const Parser = require('../src/parser.js');
const Compiler = require('../src/compiler.js');
const fs = require('fs');
const path = require('path');

console.log(process.argv[2])
// const code = fs.readFileSync(path.join(__dirname, `../src/main.ak`), 'utf8');
const code = fs.readFileSync(path.join(__dirname, `../${process.argv[2]}`), 'utf8');
const lexer = new Lexer(code);
const tokens = lexer.tokenize();

const parser = new Parser(tokens);
const ast_tree = parser.parse();

const compiler = new Compiler(ast_tree);
const code_gen = compiler.generate();
// console.log(code_gen);

fs.writeFileSync(path.join(__dirname, `../out/main.asm`), code_gen)