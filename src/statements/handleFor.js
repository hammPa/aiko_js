const { IdentifierStmt, BinaryOpStmt } = require('../../helper/ast_tree');

function handleFor(self, stmt) {
    const { iterator, endExpr, step, block } = stmt;
    
    let stepValue = step ? step.value : 1;

    const startNode = iterator.initializer; // bisa lieral atau identifier

    // jika keduanya angka literal
    if (startNode.type === 'Literal' && endExpr.type === 'Literal') {
        // auto-correct arah step
        if (startNode.value > endExpr.value && stepValue > 0) {
            stepValue = -stepValue;
        }
        if (startNode.value < endExpr.value && stepValue < 0) {
            stepValue = -stepValue;
        }
    }

    const isDecrement = stepValue < 0;
    const jumpInstruction = isDecrement ? 'jle' : 'jge';

    const forId = self.forCounter++;
    const checkLabel = `for_${forId}_check`;
    const endLabel = `for_${forId}_end`;


    self.enterScope();
    self.generateStatement(iterator);
    
    self.emit(`; ------------------------------ Looping For ${forId} ------------------------------`);
    self.emit(`${checkLabel}:`);

    self.emit(`; END`);
    if (endExpr.type === 'Literal') {
        // Jika Literal, load langsung ke ecx
        self.generateExpression(endExpr, 'condition'); 
        // self.emit(`mov ecx, ${endExpr.value}`); 
        
    } else if (endExpr.type === 'Identifier') {
        // Jika Identifier, ambil alamatnya, lalu ambil valuenya
        self.generateExpression(endExpr); // EAX = Alamat pointer 'end'
        self.emit(`mov ecx, [eax]`);      // ECX = Value dari 'end'
    }
    else if(endExpr.type === 'BinaryOp') {
        self.emit(`; bin wi`);
        const res = self.generateExpression(endExpr);     
        
        if (res.box) {
            self.emit(`mov ecx, [eax]`); // Ambil value dari dalam Box
        } else {
             // Jaga-jaga jika ada optimasi yang return valuenya langsung di register
            self.emit(`mov ecx, eax`); 
        }
    }

    const variable = self.generateExpression(new IdentifierStmt(iterator.name));
    
    self.emit(`cmp [eax], ecx`);
    self.emit(`${jumpInstruction} ${endLabel}`);

    for(const s of block){
        self.generateStatement(s);
    }

    self.generateExpression(new IdentifierStmt(iterator.name));
    self.emit(`add dword [eax], ${stepValue}`);
    self.emit(`jmp ${checkLabel}`);
    self.emit(`${endLabel}:`);

    self.exitScope();
}


module.exports = handleFor;