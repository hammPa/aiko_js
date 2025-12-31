function handleVarDecl(self, stmt){
    let varType = "";
    let size = self.currentOffset;
    if(!stmt.initializer){
        throw new Error("ga ada initializer");
    }
    
    const {register, value, isFun = false} = self.generateExpression(stmt.initializer);
    
    // if(!value) console.log("Error generating initializer");
    
    if(stmt.initializer.type === 'Literal'){
        if (typeof stmt.initializer.value === 'boolean') varType = 'boolean';
        else if (typeof stmt.initializer.value === 'number') varType = 'number';
        else if (typeof stmt.initializer.value === 'string') varType = 'string';
        else throw new Error("unsupported literal type");
        
        size = self.getSizeFromType(varType);
        const logicSize = size;

        // agar allignment 4 byte, semacam dibulatkan, 1 byte untuk bool, 3 kosong
        if(varType === 'boolean') size = 4;
        self.currentOffset -= size;

        switch(varType){
            case 'string':
                self.textSection.push(
                    `\tsub esp, ${size}    ; alokasi stack sebesar ${size} byte untuk variable bernama ${stmt.name}\n`,
                    `\tmov dword [ebp - ${Math.abs(self.currentOffset)}], ${value}    ; pindahkan nilai ${value} ke dalam stack dengan offset -${Math.abs(self.currentOffset)}\n\n\n`
                );
                break;
            case 'number':
                self.textSection.push(
                    `\tsub esp, ${size}    ; alokasi stack sebesar 4 byte untuk variable number bernama ${stmt.name}\n`,
                    `\tmov dword [ebp - ${Math.abs(self.currentOffset)}], ${register}    ; pindahkan nilai ${value} dalam eax ke dalam stack dengan offset -${Math.abs(self.currentOffset)}\n\n\n`
                );
                break;
            case 'boolean':
                self.textSection.push(
                    `\tsub esp, ${size}    ; alokasi stack sebesar 4 byte (1 boolean, 3 kosong) untuk variable bernama ${stmt.name}\n`,
                    `\tmov dword [ebp - ${Math.abs(self.currentOffset)}], ${register}    ; pindahkan nilai ${value} dalam eax ke dalam stack dengan offset -${Math.abs(self.currentOffset)}\n\n\n`
                );
                break;
            default: throw new Error("unknown type");
        }

        const currentScope = self.variables[self.variables.length - 1];
        currentScope[stmt.name] = {
            offset: self.currentOffset, 
            type: varType,
            size: logicSize,
            value
        };
    }
    else if (stmt.initializer.type === "Identifier") {
        // cari variabel sumber (initializer.name)
        let sourceVar;
        for (let i = self.variables.length - 1; i >= 0; i--) {
            if (stmt.initializer.name in self.variables[i]) {
                sourceVar = self.variables[i][stmt.initializer.name];
                break;
            }
        }
        if (!sourceVar) throw new Error(`Variable ${stmt.initializer.name} not defined`);
    
        // alokasikan slot baru untuk var yang dideklarasikan
        const size = self.getSizeFromType(sourceVar.type);
        self.currentOffset -= size;
    
        // load -> register -> store
        self.textSection.push(
            `\tsub esp, ${size}    ; alokasi stack untuk variable bernama ${stmt.name}\n`,
            `\tmov eax, [ebp - ${Math.abs(sourceVar.offset)}]    ; load nilai dari variabel ${stmt.initializer.name} ke register eax\n`,
            `\tmov [ebp - ${Math.abs(self.currentOffset)}], eax ; simpan dari eax ke variable baru ${stmt.name}\n\n`
        );
    
        // simpan di scope
        const currentScope = self.variables[self.variables.length - 1];
        currentScope[stmt.name] = {
            offset: self.currentOffset,
            type: sourceVar.type,
            size: sourceVar.size,
            value: sourceVar.value
        };
    }
    else if(stmt.initializer.type === 'FunctionCall'){
        // misal initializer adalah BinaryExpression, function call expression
        const varType = 'unknownFunType'; // default untuk ekspresi numeric
    
        const size = 4;           // 4 byte
        self.currentOffset -= size;
        
        // alokasi stack
        self.textSection.push(
            `\tsub esp, ${size}    ; alokasi stack untuk variable bernama ${stmt.name}\n`,
            `\tmov [ebp - ${Math.abs(self.currentOffset)}], ${register}    ; simpan hasil ekspresi ke stack\n\n`
        );
    
        // simpan di variables
        const currentScope = self.variables[self.variables.length - 1];
        currentScope[stmt.name] = {
            offset: self.currentOffset,
            type: varType,
            size: size,
            value: value // bisa undefined untuk ekspresi, tapi tetap catat
        };
        
    }
    else {
        // misal initializer adalah BinaryExpression
        let varType = 'number'; // default untuk ekspresi numeric


        const size = 4;           // 4 byte
        self.currentOffset -= size;
        
        // alokasi stack
        self.textSection.push(
            `\tsub esp, ${size}    ; alokasi stack untuk variable bernama ${stmt.name}\n`,
            `\tmov [ebp - ${Math.abs(self.currentOffset)}], ${register}    ; simpan hasil ekspresi ke stack\n\n`
        );
    
        // simpan di variables
        const currentScope = self.variables[self.variables.length - 1];
        currentScope[stmt.name] = {
            offset: self.currentOffset,
            type: varType,
            size: size,
            value: value // bisa undefined untuk ekspresi, tapi tetap catat
        };
    }    
}

module.exports = handleVarDecl;