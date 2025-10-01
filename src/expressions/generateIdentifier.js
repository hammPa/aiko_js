function generateIdentifier(self, expr){
    let variable;

    // cari variabel dari scope paling dalam ke paling luar
    for(let i = self.variables.length - 1; i >= 0; i--){
        if(expr.name in self.variables[i]){
            variable = self.variables[i][expr.name];
            break;
        }
    }

    // jika tidak ditemukan, cek apakah nama fungsi
    if(!variable){
        if(self.functionNames.includes(expr.name)){
            return {register: null, value: expr.name}; // nama fungsi bisa dikembalikan
        }
        throw new Error(`Error: ${expr.name} is not defined`);
    }

    const offset = Math.abs(variable.offset);
    self.textSection.push(
        `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${variable.offset} ke register eax\n`
    );

    return {register: null, value: variable};
}

module.exports = generateIdentifier;