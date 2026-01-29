const path = require('path');

const expressionHandlers = require('./expressions/index');
const statementHandlers = require('./statements/index');

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
		
  	  	// loop stack: untuk label loop break dan continue [ { startL '', end: '' } ]
  	  	this.loopStack = [];
		
  	  	// Function registry
  	  	// { name, paramCount, paramNames }
  	  	this.functionNames = [];
  	  	this.currentFunction = null;
		
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
		
		
  	  	// untuk souce map => fitur highlight
  	  	this.sourceMap = [];
  	  	this.functionSourceMap = []; // Penampung map khusus fungsi
  	  	this.currentSourceLocation = null;
  	}

  	updateLocation(node) {
  	  	// Cek apakah node ada dan memiliki properti lineStart
  	  	if (node && node.lineStart !== undefined) {
  	  	    this.currentSourceLocation = {
  	  	        start: node.lineStart,
  	  	        end: node.lineEnd || node.lineStart // Fallback jika lineEnd undefined
  	  	    };
  	  	}
  	}

  	findVarNameByOffset(targetOffset) {
  	  	// Kita iterasi dari scope paling dalam (index terakhir) ke luar
  	  	// agar memprioritaskan local scope saat ini.
  	  	for (let i = this.variables.length - 1; i >= 0; i--) {
  	  	  	const scope = this.variables[i];

  	  	  	// Loop setiap variabel dalam scope ini
  	  	  	for (const [name, meta] of Object.entries(scope)) {
  	  	  	  	// Cek apakah offset cocok DAN pastikan penyimpanannya di stack
  	  	  	  	if (meta.storage === 'stack' && meta.offset === targetOffset) {
  	  	  	  		return name;
  	  	  	  	}
  	  	  	}
  	  	}

    	return null; // Tidak ditemukan
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
  	  	  		continue;
  	  	  		// this.emit(`mov eax, [ebp + ${v.offset}]`);  
  	  	  	}
  	  	  	else {
  	  	  		this.emit(`mov eax, [ebp - ${v.offset}]`);
  	  	  		localStackSize += 4;
  	  	  	}
		  
  	  	  	this.emit(`push 8`);
  	  	  	this.emit(`push eax`);
  	  	  	this.emit(`call dealloc`);
  	  	  	this.emit(`add esp, 8`);
  	  	  	console.log(`Free scope at level ${this.variables.length + 1} on size ${localStackSize}`);
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
  	  	this.textSection.push(indent + line);
  	  	this.sourceMap.push(this.currentSourceLocation);
  	}

  	blank(n = 1) {
  	    for (let i = 0; i < n; i++) {
  	        this.textSection.push("\n");
  	        this.sourceMap.push(this.currentSourceLocation);
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

  	allocBox(length = 1){
  	  	this.emit(`push ${8 * length}    ; ------------------------------ alokasi untuk ${length} element ------------------------------`);
  	  	this.emit(`call alloc`);
  	  	this.emit(`add esp, 4`);
  	}

  	generateStatement(stmt) {
  	  	const prevLocation = this.currentSourceLocation;
  	  	// Update lokasi ke statement saat ini
  	  	this.updateLocation(stmt);
  	  	try {
            const handler = statementHandlers[stmt.type];

            if (handler) {
                // Eksekusi handler
                handler(this, stmt);
            } else {
                console.warn('Unknown statement:', stmt);
            }
        }
		finally {
            // KEMBALIKAN lokasi Parent (menggunakan finally agar aman jika terjadi error)
            this.currentSourceLocation = prevLocation;
        }
  	}


  	generateExpression(expr, mode = 'non-condition') {
  	  	// console.log(expr.type, ' : mode dalam expr: ', mode);
		
  	  	if (!expr || !expr.type) {
  	  		throw new Error(`Invalid expression: ${JSON.stringify(expr)}`);
  	  	}
	  
  	  	// Simpan lokasi sebelum masuk expression
  	  	const prevLocation = this.currentSourceLocation;
  	  	this.updateLocation(expr);
	  
		try {
            // Cek apakah handler tersedia untuk tipe ini
            const handler = expressionHandlers[expr.type];

            if (handler) {
                // Eksekusi handler
                return handler(this, expr, mode);
            } else {
                console.warn('Unknown expression type:', expr.type);
                return null; // Atau throw error jika ingin strict
            }
        }
		finally {
            // Restore lokasi (menggunakan try/finally agar tetap jalan meski ada error)
            this.currentSourceLocation = prevLocation;
        }	  
  	}


  	generate() {
  	  	if (!this.ast_tree || !this.ast_tree.statements) {
  	  		throw new Error('AST tree is missing "statements"');
  	  	}

  	  	for (const statement of this.ast_tree.statements) {
  			// console.dir(statement, { depth: null, colors: true });
  			this.generateStatement(statement);
  	  	}
	

		// 1. Susun Header
    	const headerParts = [
    	  	`%include "${path.join(__dirname, '..', '..', '/helper/stdio.asm')}"`, // hapus \n manual di array ini biar rapi saat join
    	  	'section .data',
    	  	...this.dataSection, 
    	  	'', // spacer
    	  	'section .bss',
    	  	...this.bssSection,
    	  	'', // spacer
    	  	'section .text',
    	  	'    global _start',
    	  	'',
    	  	'_start:',
    	  	'    push ebp',
    	  	'    mov ebp, esp',
    	  	'' 
    	];

    	// Gunakan join('\n') agar konsisten
    	const headerString = headerParts.join('\n');
    
    	// Hitung offset berdasarkan jumlah baris di headerString
    	// Jika headerString diakhiri \n, split akan menghasilkan string kosong di akhir, jadi length-1 sudah benar.
    	// Tapi karena kita join manual, kita hitung splitnya saja.
    	const headerOffset = headerString.split('\n').length; 

    	// 2. Susun Body
    	// FIX 4: Gunakan join('\n') karena di emit kita sudah hapus \n nya.
    	// Ini menghilangkan masalah double newline.
    	const bodyString = this.textSection.join('\n'); 

    	// ... bagian header & body string sudah benar ...

    	// 3. Pisahkan Static Footer (Kode Exit standar)
    	const staticFooterParts = [
    	  	'',
    	  	'    mov esp, ebp',
    	  	'    pop ebp',
    	  	'',
    	  	'    mov eax, 1',
    	  	'    xor ebx, ebx',
    	  	'    int 0x80',
    	  	'' 
    	];
    	// Gabungkan jadi string
    	const staticFooterString = staticFooterParts.join('\n');
	
    	// HITUNG JUMLAH BARISNYA (Penting!)
    	// Kita pakai split('\n').length agar akurat sesuai hasil join
    	const staticFooterLineCount = staticFooterString.split('\n').length;
    
    	// Buat Spacer Map (Isinya 0 atau line terakhir, cuma buat ngisi tempat)
    	const staticFooterMap = new Array(staticFooterLineCount).fill(null);

    	// 4. Susun Final ASM
    	// Urutan: Header -> Body -> Static Footer -> Function Bodies
    	const functionBodyString = this.functiontSection.join('\n');
		
    	const finalAsm = headerString + '\n' + 
    	                 bodyString + '\n' + 
    	                 staticFooterString + '\n' + 
    	                 functionBodyString;

    	// 5. Susun Final Map
    	// Urutan: SourceMap -> Spacer (Static Footer) -> FunctionSourceMap
    	const finalMap = [
    	    ...this.sourceMap, 
    	    ...staticFooterMap, // <--- INI YANG HILANG SEBELUMNYA
    	    ...this.functionSourceMap
    	];

    	return {
    	    asm: finalAsm,
    	    map: finalMap,
    	    offset: headerOffset 
    	};
  	}
}

module.exports = Compiler;
