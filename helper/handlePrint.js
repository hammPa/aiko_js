/**
 * Menangani pencetakan literal ke kode assembly.
 * Bisa menangani number, string, dan boolean.
 * 
 * @param {{ type: string, value: number|string|boolean }} expression - Literal yang ingin dicetak.
 * @param {object} self - Instance dari Compiler yang memuat context saat ini (seperti textSection, dataSection, dsb).
 */
function handleLiteralPrint(expression, self){
    // console.log("literal cuy");
    // console.log(expression)

    // cek tipedata
    if(typeof expression.value === 'number'){
        self.textSection.push(
            `\tmov eax, ${expression.value}\n`,
            '\tpush eax\n',
            '\tcall print_int\n',
            '\tadd esp, 4\n',
            '\tcall newline\n\n',
        );
    }
    else if(typeof expression.value === 'string'){
        // console.log("ini string literal cihuy")
        const name = `tmpvar_${self.tempStrVarIndex++}`;
        self.dataSection.push(`\t${name} db "${expression.value}", 0\n`);
        self.textSection.push(
            `\tmov ecx, ${name}\n`,
            '\tcall print_str\n',
            '\tcall newline\n\n\n'
        );
    }
    else if(typeof expression.value === 'boolean'){
        // console.log("ini string literal cihuy")
        const name = `tmpvar_${self.tempStrVarIndex++}`;
        self.dataSection.push(`\t${name} db "${expression.value}", 0\n`);
        self.textSection.push(
            `\tmov ecx, ${name}\n`,
            '\tcall print_str\n',
            '\tcall newline\n\n\n'
        );
    }
}

/**
 * Menangani pencetakan identifier (variabel).
 * Bisa berupa number, string, atau array.
 * 
 * @param {{ type: string, name: string }} expression - Ekspresi identifier.
 * @param {object} self - Instance dari Compiler.
 */
function handleIdentifierPrint(expression, self){
    const { name } = expression;
    // console.log("handle identifier: ", expression); // --------------------> handle identifier:  IdentifierStmt { type: 'Identifier', name: 'a' }
    const variableData = self.symbolTable[name];
    

    const offset = Math.abs(variableData.offset);
    if(variableData.type === 'number'){
        self.textSection.push(
            `\n\tmov eax, [ebp - ${offset}]\n`,
            '\tpush eax\n',
            '\tcall print_int\n',
            '\tadd esp, 4\n',
            '\tcall newline\n\n'
        );
    }
    else if(variableData.type === 'string'){
        self.textSection.push(
            `\n\tlea ecx, [ebp - ${offset}]\n`,
            '\tcall print_str\n',
            '\tcall newline\n\n'
        );
    }
    else if(variableData.type === 'boolean'){
        self.textSection.push(
            `\n\tlea ecx, [ebp - ${offset}]\n`,
            `\tcall print_boolean\n`,
            `\tcall newline\n\n`
        );
    }
    else if(variableData.type === 'array' && variableData.location === 'stack'){
        const loopVariabel = `loop_array_${self.index_for++}`;
        const offset = -variableData.offset; // offset harus positif dulu
    
        self.bssSection.push(`\t${loopVariabel} resd 1\n`);
    
        const elementCount = variableData.size / 4;
    
        self.textSection.push(
            `\txor esi, esi\n` +
            `\tmov [${loopVariabel}], dword 0\n` +
            `\tmov esi, [${loopVariabel}]\n\n` +
    
            `.${loopVariabel}_start:\n` +
            `\tcmp esi, ${elementCount}\n` +
            `\tjge .${loopVariabel}_end\n\n` +
    
            // Ambil dari stack: [ebp - (offset - 4 * esi)]
            `\tmov eax, [ebp - ${offset} + esi * 4]\n` +
            `\tpush eax\n` +
            `\tcall print_int\n` +
            `\tadd esp, 4\n\n` +
    
            // Print spasi kecuali terakhir
            `\tcmp esi, ${elementCount - 1}\n` +
            `\tjge .no_space_${loopVariabel}\n` +
            `\tmov ecx, space\n` +
            `\tcall print_str\n\n` +
            `.no_space_${loopVariabel}:\n` +
    
            `\tinc esi\n` +
            `\tjmp .${loopVariabel}_start\n` +
    
            `.${loopVariabel}_end:\n` +
            `\tmov dword [${loopVariabel}], esi\n` +
            `\tcall newline\n\n`
        );
    }    
}

/**
 * Menangani pencetakan elemen array berdasarkan indeks.
 * 
 * @param {{ array_name: { name: string }, index: object }} expression - Ekspresi akses array.
 * @param {object} self - Instance dari Compiler.
 */
function handleArrayAccessPrint(expression, self){
    const { array_name, index } = expression;
    // const length = self.variablesType[array_name.name][1];
    // console.log(index)
    // console.log("index:" ,index);
    // console.log(index + "  " + length);
    // if(index >= length) throw new Error('Index out of bound');
    let code = '';
    if (index.type === 'Literal') {
        code += `\tmov ecx, ${index.value}\n`;
    }
    else if (index.type === 'Identifier') {
        const offset = Math.abs(self.symbolTable[index.name].offset);
        code += `\tmov ecx, [ebp - ${offset}]\n`; // Ambil nilai dari variabel
    }
    else {
        throw new Error(`Unsupported index type: ${index.type}`);
    }
    const variableData = self.symbolTable[array_name.name];
    const offset = Math.abs(variableData.offset);

    code += 
        `\tmov eax, [ebp - ${offset} + 4 * ecx]\n` +
        '\tpush eax\n' +
        '\tcall print_int\n' +
        '\tadd esp, 4\n' +
        '\tcall newline\n\n';
    self.textSection.push(code);      
}

/**
 * Menangani pemanggilan fungsi dan mencetak hasilnya.
 * 
 * @param {{ name: { name: string }, args: Array<object> }} expression - Pemanggilan fungsi.
 * @param {object} self - Instance dari Compiler.
 */
function handleFunctionCallPrint(expression, self, options = {}) {
    const { name, args } = expression;
    const funcName = name.name;
    const shouldPrint = options.shouldPrint ?? false;
    
    // Push argumen ke stack (dalam urutan terbalik)
    args.reverse().forEach(arg => {
        // console.log(arg)
        if (arg.type === 'Literal') {
            self.textSection.push(`\tpush ${arg.value}\n`);
        }
        else if (arg.type === 'Identifier') {
            const offset = Math.abs(self.symbolTable[arg.name].offset);
            self.textSection.push(`\tpush dword [ebp - ${offset}]\n`);
        }
        else if (arg.type === 'BinaryOp') {
            self.generateBinaryOp(arg);
            self.textSection.push('\tpush eax\n');
        }
    });
    
    // Panggil fungsi
    self.textSection.push(`\tcall ${funcName}\n`);
    
    // Bersihkan stack (4 bytes per argumen)
    if (args.length > 0) {
        self.textSection.push(`\tadd esp, ${4 * args.length}\n`);
    }
    
    // Cetak hasil return (di eax), hanya handle int ini
    if(shouldPrint){
        self.textSection.push('\tpush eax\n');
        self.textSection.push('\tcall print_int\n');
        self.textSection.push('\tadd esp, 4\n');
        self.textSection.push('\tcall newline\n');
    }
}


/**
 * Menangani pencetakan typeof ekspresi.
 * Misalnya typeof x → "number"
 */
function handleTypeofPrint(expression, self) {
    // Kalau expression itu TypeofStmt, ambil expression-nya
    if (expression.type === 'Typeof') {
        expression = expression.expression;
    }

    if (expression.type === 'Identifier') {
        const varInfo = self.symbolTable[expression.name];
        const typeStr = varInfo?.type || 'unknown';

        const name = `tmpvar_${self.tempStrVarIndex++}`;
        self.dataSection.push(`\t${name} db "${typeStr}", 0\n`);
        self.textSection.push(
            `\tmov ecx, ${name}\n`,
            `\tcall print_str\n`,
            `\tcall newline\n\n`
        );
    }

    else if (expression.type === 'Literal') {
        let typeStr = typeof expression.value;

        if (typeStr === 'boolean') typeStr = 'boolean';
        else if (typeStr === 'number') typeStr = 'number';
        else if (typeStr === 'string') typeStr = 'string';
        else typeStr = 'unknown';

        const name = `tmpvar_${self.tempStrVarIndex++}`;
        self.dataSection.push(`\t${name} db "${typeStr}", 0\n`);
        self.textSection.push(
            `\tmov ecx, ${name}\n`,
            `\tcall print_str\n`,
            `\tcall newline\n\n`
        );
    }

    else {
        throw new Error(`Unsupported typeof operand: ${expression.type}`);
    }
}



module.exports = {
    handleLiteralPrint,
    handleIdentifierPrint,
    handleFunctionCallPrint,
    handleArrayAccessPrint,
    handleTypeofPrint
};