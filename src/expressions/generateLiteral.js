function generateLiteral(self, expr){
    const { value } = expr;
    
    if(typeof value === 'number'){
        self.textSection.push(
            `\tmov eax, ${value}    ; masukkan nilai ${value} ke register eax\n`
        );
        return {register: 'eax', value};
    }
    else if(typeof value === 'string'){
        const name = `strLiteralCounter${self.stringLiteralCounter++}`;
        self.dataSection.push(
            `\t${name} db "${value}", 0    ; buat variabel string global bernama ${name} dengan tipe byte\n`
        );

        // self.global[name] = name; // simpan nama variabel global keknya ga jadi deh
        
        return {register: 'ecx', value: name};
    }
    else if(typeof value === 'boolean'){
        self.textSection.push(
            `\tmov eax, ${value === true ? 1 : 0}    ; masukkan nilai ${value ? 'true' : 'false'} dengan angka berupa ${value ? 1 : 0} ke eax\n`
        );

        return {register: 'eax', value: value === true ? 1 : 0};
    }
    throw new Error("literal doesnt exist");
}

module.exports = generateLiteral;