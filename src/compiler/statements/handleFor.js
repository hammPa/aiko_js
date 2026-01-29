const { IdentifierStmt } = require('../../../helper/ast_tree');
const handleForEach = require('./handleForEach');

function handleFor(self, stmt) {
    const { iterator, endExpr, step, block } = stmt;

    const forId = self.forCounter++;
    const checkLabel = `for_${forId}_check`;
    const endLabel = `for_${forId}_end`;
    const updateLabel = `for_${forId}_update`;
    
    if (endExpr === null) {
        handleForEach({
            self, iterator,
            step, block,
            forId, checkLabel,
            endLabel, updateLabel
        });
        return;
    }

    // console.log(stmt);
    
    // // ganti pakai ini alih alih compile time cek step
    
    // self.loopStack.push({
    //     breakLabel: endLabel, // jika break ke endlabel
    //     continueLabel: updateLabel // jika continue ke updatelabel
    // });
    // self.enterScope();

    // self.generateStatement(iterator);
    // if (step) { // step berupa angka bukan variabel, variabell blm di buat
    //     self.generateExpression(step, 'condition');
    //     self.emit(`push ecx`);
    //     // Jika expression pointer, ambil valuenya:
    //     // self.emit(`mov ebx, [eax]`); 
    // }
    // else {
    //     self.emit(`push 1`);   // Default Step
    // }

    
    // // masukkan kedalam esp saja, buat var step agar mengurangi push pop
    // self.emit(`; ------------------------------ Start Looping For ${forId} ------------------------------`);
    // self.emit(`${checkLabel}:`);
    // self.emit(`mov ebx, [ebp - 8] ; [FIX] Load Step dari Stack sebelum cek kondisi`);

    // if (endExpr.type === 'Literal') {
    //     // Jika Literal, load langsung ke ecx
    //     self.generateExpression(endExpr, 'condition'); 
    //     // self.emit(`mov ecx, ${endExpr.value}`); 
    // }
    // else if (endExpr.type === 'Identifier') {
    //     // Jika Identifier, ambil alamatnya, lalu ambil valuenya
    //     self.generateExpression(endExpr); // EAX = Alamat pointer 'end'
    //     self.emit(`mov ecx, [eax]`);      // ECX = Value dari 'end'
    // }
    // else if(endExpr.type === 'BinaryOp') {
    //     self.emit(`; bin wi`);
    //     const res = self.generateExpression(endExpr);     
        
    //     if (res.box) {
    //         self.emit(`mov ecx, [eax]`); // Ambil value dari dalam Box
    //     } else {
    //         // Jaga-jaga jika ada optimasi yang return valuenya langsung di register
    //         self.emit(`mov ecx, eax`); 
    //     }
    // }

    // const variable = self.generateExpression(new IdentifierStmt(iterator.name));
    
    // self.emit(`; --- Dynamic Step Check ---`);

    // // 1. Cek apakah Step (EBX) negatif atau positif
    // self.emit(`test ebx, ebx`);      // Set flags berdasarkan EBX
    // self.emit(`jge ${positiveStepLabel}`); // Jika Positif/Nol, lompat ke logika positif

    // // 2. Logika Jika Step NEGATIF
    // // Loop break jika: Iterator <= End (jle)
    // self.emit(`; Case: Negative Step`);
    // self.emit(`cmp [eax], ecx`);     // Bandingkan Iterator vs Batas
    // self.emit(`jle ${endLabel}`);    // Break jika Iterator <= Batas
    // self.emit(`jmp ${bodyLabel}`); // Lompat ke body loop

    // // 3. Logika Jika Step POSITIF
    // self.emit(`${positiveStepLabel}:`);
    // self.emit(`; Case: Positive Step`);
    // self.emit(`cmp [eax], ecx`);     // Bandingkan Iterator vs Batas
    // self.emit(`jge ${endLabel}`);    // Break jika Iterator >= Batas


    // self.emit(`${bodyLabel}:`);
    // for(const s of block){
    //     self.generateStatement(s);
    // }

    // self.emit(`${updateLabel}:`);
    // self.emit(`mov ebx, [ebp - 8] ; Reload step dari stack`);
    // self.generateExpression(new IdentifierStmt(iterator.name));
    // self.emit(`add dword [eax], ebx    ; increment counter sebanyak nilai di ebx`);
    // self.emit(`jmp ${checkLabel}    ; ulangi loop`);
    // self.emit(`${endLabel}:    ; akhir loop`);
    // self.emit(`; ------------------------------ End Looping For ${forId} ------------------------------`);
    // self.emit(`add esp, 4 ; Hapus variabel step dari stack`);
    // self.blank(1);
    // self.exitScope();
    // self.loopStack.pop();

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
    else {
        // console.log({startNode});
        // console.log({endExpr});
    }
    

    const isDecrement = stepValue < 0;
    const jumpInstruction = isDecrement ? 'jle' : 'jge';


    self.loopStack.push({
        breakLabel: endLabel, // jika break ke endlabel
        continueLabel: updateLabel // jika continue ke updatelabel
    });


    self.enterScope();
    self.generateStatement(iterator);
    
    
    self.emit(`; ------------------------------ Start Looping For ${forId} ------------------------------`);
    self.emit(`${checkLabel}:`);

    if (endExpr.type === 'Literal') {
        // Jika Literal, load langsung ke ecx
        self.generateExpression(endExpr, 'condition'); 
        // self.emit(`mov ecx, ${endExpr.value}`); 
    }
    else if (endExpr.type === 'Identifier') {
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
    
    self.emit(`cmp [eax], ecx    ; bandingkan: eax = counter, ecx = batas`);
    self.emit(`${jumpInstruction} ${endLabel}`);

    for(const s of block){
        self.generateStatement(s);
    }

    self.emit(`${updateLabel}:`);
    self.generateExpression(new IdentifierStmt(iterator.name));
    self.emit(`add dword [eax], ${stepValue}    ; increment counter sebanyak ${stepValue}`);
    self.emit(`jmp ${checkLabel}    ; ulangi loop`);
    self.emit(`${endLabel}:    ; akhir loop`);
    self.emit(`; ------------------------------ End Looping For ${forId} ------------------------------`);
    self.blank(1);

    self.exitScope();
    self.loopStack.pop();
}


module.exports = handleFor;