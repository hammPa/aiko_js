function generateBinaryOp(self, expr, mode) {
    const { left, op, right } = expr;

    self.emit(`; ------------------------------ Start Binary Op (${op}) ------------------------------`);

    // left operand, diawal semua dicoba ke condition dlu agar dapat value, tapi kalau masih dapat box lanjut ke if
    const resLeft = self.generateExpression(left, 'condition'); 
    
    // Logic: hasil Left ada di EDX
    if (resLeft.box) {
        self.emit(`mov eax, ${resLeft.reg || 'eax'}`);
        self.emit(`mov edx, [eax]    ; Unbox left ke EDX`);
    }
    else {
        // Jika child berupa Literal
        if (left.type === 'Literal') {
            self.emit(`mov edx, ecx    ; left harus di edx`);
        } 
        // Jika anak BinaryOp (mode 'condition'), dia sudah return di EDX. Aman.
    }

    self.emit(`push edx    ; simpan left value`);

    // right operand
    const resRight = self.generateExpression(right, 'condition'); // Minta 'condition' juga

    // Logic: hasil Right ada di EBX
    if (resRight.box) {
        self.emit(`mov eax, ${resRight.reg || 'eax'}`);
        self.emit(`mov ebx, [eax]    ; Unbox right ke EBX`);
    }
    else {
        if (right.type === 'Literal') {
            self.emit(`mov ebx, ecx    ; right harus di ebx`);
        }
        else {
            self.emit(`mov ebx, edx    ; right harus di ebx`);
        }
    }

    self.emit(`pop edx    ; restore left value ke edx`);

    // =========================================================
    // 3. EKSEKUSI OPERASI (EDX op EBX)
    // =========================================================
    
    switch(op){
        // Aritmatika
        case '+': self.emit(`add edx, ebx`); break;
        case '-': self.emit(`sub edx, ebx`); break;
        case '*': self.emit(`imul edx, ebx`); break;
        case '/': 
            self.emit(`mov eax, edx`);
            self.emit(`cdq`);
            self.emit(`idiv ebx`);
            self.emit(`mov edx, eax`);
            break;
        case '%':
            self.emit(`mov eax, edx`);
            self.emit(`cdq`);
            self.emit(`idiv ebx`);
            // Sisa bagi sudah di EDX
            break;

        // Komparasi (Hasil boolean 0/1 ditaruh di EDX agar seragam)
        case '<':
            self.emit(`cmp edx, ebx`);
            self.emit(`setl bl`);
            self.emit(`movzx edx, bl`);
            break;
        case '>':
            self.emit(`cmp edx, ebx`);
            self.emit(`setg bl`);
            self.emit(`movzx edx, bl`);
            break;
        case '==':
            self.emit(`cmp edx, ebx`);
            self.emit(`sete bl`);
            self.emit(`movzx edx, bl`);
            break;
        case '!=':
            self.emit(`cmp edx, ebx`);
            self.emit(`setne bl`);
            self.emit(`movzx edx, bl`);
            break;
        case '<=':
            self.emit(`cmp edx, ebx`);
            self.emit(`setle bl`);
            self.emit(`movzx edx, bl`);
            break;
        case '>=':
            self.emit(`cmp edx, ebx`);
            self.emit(`setge bl`);
            self.emit(`movzx edx, bl`);
            break;
    }

    self.emit(`; ------------------------------ End Binary Op ${op} ------------------------------`);

    // return handling
    // KASUS A: Dipanggil oleh IF / WHILE / ELIF
    // Parent membutuhkan hasil di EAX untuk "cmp eax, 0"
    if (mode === 'condition') {
        self.emit(`mov eax, edx    ; Pindahkan hasil (0/1) ke EAX`); 
        return { box: false };
    }

    // KASUS B: Dipanggil oleh Operasi Matematika Lain (Optimasi)
    // Parent membutuhkan Raw Value di EDX untuk dijumlahkan lagi
    if (mode === 'condition') {
        // Biarkan hasil di EDX
        return { box: false };
    }

    // KASUS C: Default (Assignment atau Print)
    // Parent tidak mengirim mode (undefined), berarti butuh BOX (Pointer)
    self.emit(`; simpan hasil di box`);
    self.emit(`push edx`);       // Simpan hasil hitungan
    self.allocBox();             // EAX = pointer box baru
    self.emit(`pop edx`);        // Ambil hasil hitungan
    self.emit(`mov [eax], edx`); // Masukkan ke box
    self.emit(`mov dword [eax + 4], 0`); // Masukkan tipe ke box

    // Opsional: Jika bahasa Anda butuh tipe data runtime (misal 1=INT, 2=BOOL)
    // Anda bisa tambahkan logic di sini untuk set tipe berdasarkan operator.
    // Contoh: if(['==','!=','<','>'].includes(op)) mov [eax+4], TYPE_BOOL

    return { box: true, val: left.val }; 
}

module.exports = generateBinaryOp;