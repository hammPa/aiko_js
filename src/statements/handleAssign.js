function handleAssign(self, stmt){
    // console.log(stmt);
    
    const { variable, initializer } = stmt;
    const { register, value } = self.generateExpression(variable, "read");
    const { _, value: newValue } = self.generateExpression(initializer);
    // console.log({value});
    // console.log({newValue});
    
    // perbarui nilai di symbol table untuk literal
    const currentScope = self.variables[self.variables.length - 1];
    currentScope[variable.name].value = newValue;
    currentScope[variable.name].type = typeof initializer.value;
    
    const variableOffset = value.offset
    
    const varType = typeof initializer.value;
    switch(varType){
        case 'string': // ganti untuk load ke register dulu baru masukkan ke stack
            self.textSection.push(
                `\tmov dword [ebp - ${Math.abs(variableOffset)}], ${newValue}    ; pindahkan nilai ${newValue} ke dalam variable ${variable.name} dengan offset -${Math.abs(variableOffset)}\n\n\n`
            );
            break;
        case 'number':
            self.textSection.push(
                `\tmov dword [ebp - ${Math.abs(variableOffset)}], ${newValue}    ; pindahkan nilai ${newValue} ke dalam variable ${variable.name} dengan offset -${Math.abs(variableOffset)}\n\n\n`
            );
            break;
        case 'boolean':
            self.textSection.push(
                `\tmov dword [ebp - ${Math.abs(variableOffset)}], ${newValue}    ; pindahkan nilai ${newValue} ke dalam variable ${variable.name} dengan offset -${Math.abs(variableOffset)}\n\n\n`
            );
            break;
        case 'undefined': // untuk assign ke variabel
            if(newValue.value){
                currentScope[variable.name].value = newValue.value;
                currentScope[variable.name].type = newValue.type;
                self.textSection.push(
                    `\tmov dword eax, [ebp - ${Math.abs(currentScope[initializer.name].offset)}]    ; load nilai dalam variabel ${initializer.name} ke register eax\n`,
                    `\tmov dword [ebp - ${Math.abs(variableOffset)}], eax    ; simpan dari eax ke variable baru ${stmt.name}\n\n\n`
                );
            }
            break;
        default: throw new Error("unknown type");
    }
}

module.exports = handleAssign;