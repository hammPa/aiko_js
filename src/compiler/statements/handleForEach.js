function handleForEach({
    self, iterator,
    step, block,
    forId, checkLabel,
    endLabel, updateLabel
}){
    // Setup Loop Stack (agar break/continue bekerja)
    self.loopStack.push({
        breakLabel: endLabel,
        continueLabel: updateLabel
    });

    self.enterScope();
    self.generateStatement(iterator); // ambil alamat array
    self.emit(`; ------------------------------ Start Looping For-In ${forId} ------------------------------`);
//     // variabel sementara untuk counter di stack dengan mengurangi 4 byte esp -> harusnya gitu
    self.emit(`push eax`);
    self.emit(`xor esi, esi`);

    // --- B. Start Loop Check ---
    self.emit(`${checkLabel}:`);

    // 1. Ambil Array Pointer & Length
    self.emit(`; Load Array Info`);
        
    // if(step) self.generateExpression(step); // bandingkan eax dengan kondisi
    self.emit(`mov edx, [esp]`);
        
    // if(step) self.generateExpression(step); // bandingkan eax dengan kondisi
    self.emit(`cmp esi, [edx]`);
    self.emit(`jge ${endLabel}`); // Jika i >= length, selesa
    
    self.emit(`; Loop Body`);
    self.emit(`lea edi, [edx + 8 + esi * 8]    ; edi = alamat array`);
    const varName = iterator.value || iterator.name; 
    const varOffset = self.resolveVar(varName).offset;
    
    self.emit(`; Assign current element address to loop variable '${varName}'`);
    self.emit(`mov dword [ebp - ${varOffset}], edi`)
    
    // console.log(step);
    if(step){
        self.emit(`; --- Start Filter Check (when clause) ---`);
        
        // 1. Generate kode assembly untuk ekspresi "item > 500"
        // Hasil evaluasi biasanya disimpan di EAX (1 = true, 0 = false)
        self.generateExpression(step, 'condition'); 
        
        // 2. Bandingkan hasil (EAX) dengan 0 (False)
        // Sesuaikan ini dengan cara compiler Anda menangani boolean.
        // Jika return tipe Boxed, mungkin perlu unboxing dulu.
        // Asumsi sederhana: EAX = 1 (True), EAX = 0 (False)
        self.emit(`cmp eax, 0`); 
        
        // 3. Jika 0 (False), lompat ke updateLabel (skip body)
        self.emit(`je ${updateLabel}`); 
        
        self.emit(`; --- End Filter Check ---`);
    }

    for(const s of block){
        self.generateStatement(s);
    }

    self.emit(`${updateLabel}:`);
    // --- G. End Loop ---
    self.emit(`add esi, 1    ; increment counter sebanyak 1`);
    self.emit(`jmp ${checkLabel}    ; ulangi loop`);
    self.emit(`${endLabel}:`);
    self.emit(`add esp, 4`);
    
    self.emit(`; ------------------------------ End Looping For-In ${forId} ------------------------------`);
    self.exitScope();
    self.loopStack.pop();
}

module.exports = handleForEach;