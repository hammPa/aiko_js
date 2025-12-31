function generateIdentifier(self, expr, mode = "write"){
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
        const fnMeta = self.functionNames.find(fn => fn.name === expr.name);
        if(fnMeta){
            return {register: null, value: fnMeta.name}; 
        }
        throw new Error(`Error: ${expr.name} is not defined`);
    }


    if(mode === "write"){
        const offset = Math.abs(variable.offset);

        if(variable.type !== 'string'){
            if(variable.isParam){
                self.textSection.push(
                    `\tmov eax, [ebp + ${offset}]    ; masukkan nilai yang tersimpan didalam parameter ${expr.name} ke register eax\n`
                );
            }
            else {
                self.textSection.push(
                    `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${variable.offset} ke register eax\n`
                );
            }
        }
    }

    return {register: null, value: variable};
}

module.exports = generateIdentifier;