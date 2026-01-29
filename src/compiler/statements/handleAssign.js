function handleAssign(self, stmt){
    const { variable, initializer } = stmt;

    if (variable.type === 'ArrayAccess') {
        const { array_name, index } = variable;
        
        // cari alamat pointer array
        const meta = self.resolveVar(array_name.name);
        if (!meta) throw new Error(`Undefined variable ${array_name.name}`);

        // 2. Hitung Alamat Slot Array (Logika sama persis dengan generateArrayAccess)
        // Logika index variabel (i)
        self.emit(`; ------------------------------ Start Assign Array ------------------------------`);
        if(variable.index.type === 'Literal'){
            self.generateExpression(index, 'condition');      // EAX = Address variabel i
        }
        else {
            self.generateExpression(index);
            self.emit(`mov ecx, [eax]    ; pindahkan nilai ke ecx`); // Sekarang ECX berisi value indeks (misal: 2)
        }
        self.generateExpression(array_name); // EAX = Base Address Array
        self.emit(`call check_bound`);
        self.emit(`imul ecx, 8`);            // ECX = Offset data
        
        self.emit(`add eax, ecx`);           // EAX + Offset Index
        self.emit(`add eax, 8`);             // EAX + Header (8 byte)

        // 3. PENTING: Simpan alamat tujuan (EAX) ke Stack dulu
        // Karena kita mau pakai EAX untuk generate value di kanan sama dengan
        self.emit(`push eax ; simpan alamat slot array tujuan`);

        // 4. Generate Value Baru (initializer)
        // Hasilnya ada di EAX berupa Pointer ke Box baru
        self.generateExpression(initializer);

        // 5. Ambil kembali alamat tujuan ke register lain (misal EDX)
        self.emit(`pop edx ; EDX sekarang menunjuk ke slot array arr[i]`);

        // 6. COPY DATA (Unboxing)
        // Kita salin isi Box baru (EAX) ke dalam Slot Array (EDX)
        
        // Copy Value (Offset 0)
        self.emit(`mov ecx, [eax]      ; ambil value dari box baru`);
        self.emit(`mov [edx], ecx      ; masukkan ke slot array`);

        // Copy Type (Offset 4)
        self.emit(`mov ecx, [eax + 4]  ; ambil type dari box baru`);
        self.emit(`mov [edx + 4], ecx  ; masukkan ke slot array`);
        
            self.emit(`; ------------------------------ End Assign Array ------------------------------`);
    }
    else {
        const meta = self.resolveVar(variable.name);
        if (!meta) throw new Error(`Undefined variable ${variable.name}`);

        self.generateExpression(initializer); // EAX = Box baru
        
        // free jangan lupa nanti (untuk nilai lama yang tertimpa)
        self.emit(`push eax`);
        // if(meta.kind === 'param'){
        self.emit(`mov eax, [ebp - ${meta.offset}]`);
        self.emit(`; Free memori lama sebelum ditimpa`);
        // self.emit(`push 8`);        // Argumen 2: Size // kalau ini aktif maka bisa tes counter, tapi gabisa assign var identifier
        // self.emit(`push eax`);      // Argumen 1: Pointer lama
        // self.emit(`call dealloc`);  // Panggil fungsi pembersih
        // self.emit(`add esp, 8`);    // Bersihkan stack argumen (8 byte)
        console.log("free assign lama");
        
        self.emit(`pop eax`);

        self.emit(`; ------------------------------ Start Assign ke variabel ${variable.name} ------------------------------`);
        // Cukup ganti pointer di stack frame
        self.emit(`mov dword [ebp - ${meta.offset}], eax    ; ${variable.name} diperbarui menunjuk ke Box baru`);
        self.emit(`; ------------------------------ End Assign ke variabel ${variable.name} ------------------------------`);
        self.blank(1);
    }
}

module.exports = handleAssign;