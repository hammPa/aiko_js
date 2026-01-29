const Lexer = require('../src/lexer/lexer.js');
const Parser = require('../src/parser/parser.js');
const Compiler = require('../src/compiler/compiler.js');
const fs = require('fs');
const path = require('path');

// console.log(process.argv[2])
// const code = fs.readFileSync(path.join(__dirname, `../src/main.ak`), 'utf8');


const inputFile = process.argv[2];

if (!inputFile) {
    console.error("Usage: node test_compiler.js <source_file>.ak");
    process.exit(1);
}

try {
    // Baca file
    const code = fs.readFileSync(path.join(__dirname, `../${inputFile}`), 'utf8');

    // Lexing
    const lexer = new Lexer(code);
    const tokens = lexer.tokenize();

    // Parsing
    const parser = new Parser(tokens);
    const ast_tree = parser.parse();

    // Compile
    const compiler = new Compiler(ast_tree);
    const {asm, map, offset} = compiler.generate();

    // Tulis output
    fs.writeFileSync(path.join(__dirname, `../out/main.asm`), asm);

    const debugData = {
        sourceMap: map,
        headerOffset: offset
    };
    
    fs.writeFileSync(
        path.join(__dirname, `../out/main.debug.json`), 
        JSON.stringify(debugData, null, 2) // null, 2 agar json rapi terbaca
    );

    // console.log("Compilation successful!");
    // console.log("- Assembly: out/main.asm");
    // console.log("- Source Map: out/main.debug.json"); // File baru

} catch (error) {
    console.error("Compilation failed:");
    if (error.message) console.error(error.message);
    if (error.stack) console.error(error.stack.split('\n')[1]); // stack singkat
    process.exit(1);
}