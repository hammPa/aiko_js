function handleFunCall(self, stmt){
    const { name, args } = stmt;
    
    let funcName;

    if (typeof name === 'string') funcName = name;
    else if (name?.type === 'Identifier') funcName = name.name;
    else throw new Error('Invalid function name in call');
    
    const fn = self.resolveFunction(funcName);
    if (!fn) {
        throw new Error(`Function "${funcName}" not defined`);
    }

    if (args.length !== fn.paramCount) {
        throw new Error(
            `Function "${funcName}" expects ${fn.paramCount} args, got ${args.length}`
        );
    }

    //  push argumen dari kanan ke kiri
    for (let i = args.length - 1; i >= 0; i--) {
        const argExpr = args[i];

        // generateExpression WAJIB mengembalikan Box*
        const { box } = self.generateExpression(argExpr);

        self.emit(`; --- Pass-by-Value: Copying argument ${i} ---`);
        self.emit(`push eax            ; Simpan alamat Box asli sementara`);

        // 2. Alokasi Box baru untuk parameter (8 byte)
        // Pastikan self.allocBox(1) menghasilkan EAX = Alamat Box Baru
        self.allocBox(1); 
        
        self.emit(`pop ebx             ; EBX = Alamat Box asli`);

        // 3. Salin data dari Box Asli (EBX) ke Box Baru (EAX)
        self.emit(`mov ecx, [ebx]      ; Ambil value`);
        self.emit(`mov [eax], ecx      ; Masukkan ke Box baru`);
        self.emit(`mov ecx, [ebx + 4]  ; Ambil type`);
        self.emit(`mov [eax + 4], ecx  ; Masukkan ke Box baru`);

        // eax = Box*
        self.emit(`push eax    ; push arg ${i}`);
    }

    // panggil
    self.emit(`call fun_${funcName}`);

    // bersihkan argumen (cdecl)
    if (args.length > 0) {
        self.emit(`add esp, ${args.length * 4}`);
    }

    return { box: true, val: null };
}

module.exports = handleFunCall;