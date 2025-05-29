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
}

function handleIdentifierPrint(expression, self){
    const { name } = expression;
    // console.log("handle identifier: ", expression);
    const type = self.variablesType[name];
    // console.log("apalah dia apalah: ", type);

    if(type === 'number'){
        self.textSection.push(
            `\n\tmov eax, [${name}]\n`,
            '\tpush eax\n',
            '\tcall print_int\n',
            '\tadd esp, 4\n',
            '\tcall newline\n\n'
        );
    }
    else if(type === 'string'){
        self.textSection.push(
            `\n\tmov ecx, ${name}\n`,
            '\tcall print_str\n',
            '\tcall newline\n\n'
        );
    }
    else if(Array.isArray(type) && typeof type[0] === 'string'){
        // console.log("oi ini array")
        const loopVariabel = `loop_array_${self.index_for++}`;

        // buat variabel di bss
        self.bssSection.push(`\t${loopVariabel} resd 1\n`);
        self.variablesType[loopVariabel] = 'number';

        // buat kode array dalam asm
        self.textSection.push(
            `\txor esi, esi\n` +
            `\tmov [${loopVariabel}], dword 0\n` +
            `\tmov esi, [${loopVariabel}]\n\n` +
            `.${loopVariabel}_start:\n` +
            `\tcmp esi, ${type[1]}\n` +
            `\tjge .${loopVariabel}_end\n\n` +
            

            // Print array element
            `\tmov eax, [${name} + 4 * esi]\n` +
            '\tpush eax\n' +
            '\tcall print_int\n' +
            '\tadd esp, 4\n\n' +
            
            // Print space except for last element
            `\tcmp esi, ${type[1] - 1}\n` +
            `\tjge .no_space_${loopVariabel}\n` +
            '\tmov ecx, space\n' +
            '\tcall print_str\n\n' +
            `.no_space_${loopVariabel}:\n` +
            
            // Loop control
            `\tinc esi\n` +
            `\tjmp .${loopVariabel}_start\n` +
            `.${loopVariabel}_end:\n` +
            `\tmov dword [${loopVariabel}], esi\n` +

            // Newline after array
            '\tcall newline\n\n'
        );
    }
    
}

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
        code += `\tmov ecx, [${index.name}]\n`; // Ambil nilai dari variabel
    }
    else {
        throw new Error(`Unsupported index type: ${index.type}`);
    }
    code += 
        `\tmov eax, [${array_name.name} + 4 * ecx]\n` +
        '\tpush eax\n' +
        '\tcall print_int\n' +
        '\tadd esp, 4\n' +
        '\tcall newline\n\n';
    self.textSection.push(code);      
}

function handleFunctionCallPrint(expression, self) {
    const { name, args } = expression;
    const funcName = name.name;
    
    // Push argumen ke stack (dalam urutan terbalik)
    args.reverse().forEach(arg => {
        if (arg.type === 'Literal') {
            self.textSection.push(`\tpush ${arg.value}\n`);
        } else if (arg.type === 'Identifier') {
            self.textSection.push(`\tpush dword [${arg.name}]\n`);
        } else if (arg.type === 'BinaryOp') {
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
    self.textSection.push('\tpush eax\n');
    self.textSection.push('\tcall print_int\n');
    self.textSection.push('\tadd esp, 4\n');
    self.textSection.push('\tcall newline\n');
}

module.exports = {
    handleLiteralPrint,
    handleIdentifierPrint,
    handleFunctionCallPrint,
    handleArrayAccessPrint
};