function allocateStack(self, name, variable, size){
    if(variable.type === 'ArrayLiteral'){
        self.currentStackOffset -= size;        
    }
    else if(typeof variable.value === 'number' || typeof variable.value === 'boolean'){
        self.currentStackOffset -= size;
    }
    else if(typeof variable.value === 'string'){
        self.currentStackOffset -= size + 1;
    }

    self.symbolTable[name] = {
        'name': name,
        'type': variable.type === 'ArrayLiteral' ? 'array' : typeof variable.value,
        'scope': 'local',
        'location': 'stack',
        'offset': self.currentStackOffset,
        'size': size
    };
}

function deallocateStack(){

}


function allocateHeap(self, name, variable, size){

}

function initStackValue(self, name, variable){
    const variableData = self.symbolTable[name];
    const offset = Math.abs(variableData.offset);
    
    if (variable.type === 'ArrayLiteral') {
        const elements = variable.elements;

        for (let i = 0; i < elements.length; i++) {
            const value = elements[i].value;
            const elementOffset = offset - i * 4;

            self.textSection.push(`\tmov dword [ebp - ${elementOffset}], ${value}\n`);
        }

        self.textSection.push(`\tsub esp, ${elements.length * 4}`);
    }
    else if(typeof variable.value === 'number'){
        self.textSection.push(`\tsub esp, 4\n`);
        self.textSection.push(`\tmov dword [ebp - ${offset}], ${variable.value}\n`);
    }
    // ini untuk variabel yang pakai operasi aritmatika
    else if(typeof variable.value === 'string' && variable.value === 'binaryOp'){
        self.textSection.push(`\tsub esp, 4\n`);
        self.textSection.push(`\tmov [ebp - ${offset}], eax\n\n`);
    }
    else if(typeof variable.value === 'string' && variable.value !== 'binaryOp'){
        const str = variable.value;

        self.textSection.push(`\tsub esp, ${variableData.size + 1}\n`);
        for(let i = 0; i < str.length; i++){
            const ch = str[i];
            const ascii = ch.charCodeAt(0);
    
            // offset terakhir adalah null terminator
            const charOffset = offset - i;
            self.textSection.push(`\tmov byte [ebp - ${charOffset}], ${ascii}\n`);
        }
        self.textSection.push(`\tmov byte [ebp - ${offset - variableData.size}], 0\n`); // null terminator di offset
    }
    else if(typeof variable.value === 'boolean'){
        self.textSection.push(`\tsub esp, 1\n`);
        self.textSection.push(`\tmov byte [ebp - ${offset}], ${variable.value === true ? 1 : 0}\n`);
    }
    self.textSection.push('\n');
}

module.exports = { allocateStack, allocateHeap, initStackValue };