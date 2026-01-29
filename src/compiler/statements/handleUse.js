const fs = require('fs');
const path = require('path');
// Sesuaikan path ke Parser kamu
const Lexer = require('../../lexer/lexer'); 
const Parser = require('../../parser/parser'); 

function handleUse(self, stmt) {
    // FIX: stmt.module adalah Array ['std', 'io'], jadi pakai join('/')
    // Hasilnya menjadi string "std/io"
    const modulePath = stmt.module.join('/');
    
    // Resolusi path ke file: /path/to/project/stdlib/std/io.aiko
    const fullPath = path.join(process.cwd(), 'stdlib', modulePath + '.ak');

    // Cek keberadaan file
    if (!fs.existsSync(fullPath)) {
        throw new Error(`Module not found: ${stmt.module.join('.')} (looked at ${fullPath})`);
    }

    // Hindari circular dependency / import berulang
    if (self.importedModules && self.importedModules.has(fullPath)) {
        return; 
    }
    if (!self.importedModules) self.importedModules = new Set();
    self.importedModules.add(fullPath);

    console.log(`Importing: ${fullPath}`);
    const code = fs.readFileSync(fullPath, 'utf-8');

    // Compile module tersebut
    const tokens = new Lexer(code).tokenize();
    const parser = new Parser(tokens);
    const ast = parser.parse();
    // console.log(ast);
    

    // Inject kode dari module ke compiler saat ini
    for (const statement of ast.statements) {
        self.generateStatement(statement);
    }
}

module.exports = handleUse;