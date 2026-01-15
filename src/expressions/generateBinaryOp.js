function generateBinaryOp(self, expr, mode){
    const { left, op, right } = expr;
    let boxLeft, boxRight, leftVal, rightVal;

    // 1. Optimasi Khusus: Jika keduanya Literal Angka (10 < 20)
    if(left.type === 'Literal' && right.type === 'Literal'){
        // (Kode lama kamu sudah benar untuk bagian ini, tapi untuk konsistensi saya rapikan sedikit)
        self.emit(`; ------------------------------ Compare Literals ------------------------------`);
        if (mode !== 'condition') {
             // Jika bukan kondisi (misal: var x = 10 < 20), butuh box hasil
             self.allocBox();
             // EAX sekarang hold alamat hasil
             self.emit(`push eax`); // simpan alamat hasil
        }

        self.generateExpression(left, 'condition'); // value di ecx
        self.emit(`mov edx, ecx`);
        self.generateExpression(right, 'condition'); // value di ecx
        self.emit(`mov ebx, ecx`);

        if (mode !== 'condition') {
             self.emit(`pop eax`); // kembalikan alamat hasil ke eax
        }
    }
    // 2. Mode Kondisi (if (x < 10))
    else if(mode === 'condition'){
        self.emit(`; ------------------------------ Condition Comparison ------------------------------`);
        
        // --- PROSES LEFT ---
        const resLeft = self.generateExpression(left, 'condition');
        // Jika hasil berupa Box (variabel), value ada di [eax]. Jika Literal, value ada di ecx.
        if (resLeft.box) {
            self.emit(`mov edx, [eax]    ; ambil value dari alamat Box di eax`);
        } else {
            self.emit(`mov edx, ecx      ; ambil value langsung dari ecx`);
        }
        self.emit(`push edx          ; simpan left value sementara ke stack`);

        // --- PROSES RIGHT ---
        const resRight = self.generateExpression(right, 'condition');
        
        // Kita butuh Right Value di EBX (standar untuk cmp edx, ebx)
        if (resRight.box) {
            self.emit(`mov ebx, [eax]    ; ambil value right dari Box`);
        } else {
            self.emit(`mov ebx, ecx      ; ambil value right langsung`);
        }

        self.emit(`pop edx           ; kembalikan left value ke EDX`);
        // SEKARANG: EDX = Left Value, EBX = Right Value. Aman untuk cmp.
    }
    // 3. Mode Assignment / Expression Biasa (var x = a + b)
    else {
        self.emit(`; ------------------------------ Binary Expression ------------------------------`);

        // --- PROSES LEFT ---
        const resLeft = self.generateExpression(left); // return Box* di EAX
        self.emit(`push eax    ; simpan Box* left operand ke stack`);
    
        // --- PROSES RIGHT ---
        const resRight = self.generateExpression(right); // return Box* di EAX
        self.emit(`mov esi, eax    ; esi = Box* right operand`);
        self.emit(`pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)`);
        
        // Simpan pointer operand ke stack agar tidak rusak oleh alloc
        self.emit(`push edi`);
        self.emit(`push esi`);
    
        // --- ALLOC RESULT ---
        self.emit(`; result disimpan di register eax`);
        self.allocBox();
        // EAX sekarang = Alamat Hasil Baru
        
        // Restore pointer operand
        self.emit(`pop esi`); // Right Box*
        self.emit(`pop edi`); // Left Box*

        // Ambil Value Murni
        self.emit(`mov edx, [edi]      ; ambil left value dari edi`);
        self.emit(`mov ebx, [esi]      ; ambil right value dari esi`);
    }

    // --- LOGIKA OPERASI ---
    // Pastikan variabel display untuk map source code tetap jalan
    // (Hack: ambil value dari literal AST jika ada untuk komentar asm)
    let leftDisplay = left.value || "val"; 
    let rightDisplay = right.value || "val";
    
    // Default resultVal (hanya untuk simulasi JS side jika perlu, bisa diabaikan untuk ASM)
    let resultVal = 0; 

    // Variabel regRight tidak perlu logic rumit lagi, kita sudah pastikan Right selalu di EBX
    const regRight = 'ebx'; 

    switch(op){
        case '+':
            self.emit(`add edx, ebx`);
            break;
        case '-':
            self.emit(`sub edx, ebx`);
            break;
        case '*':
            self.emit(`imul edx, ebx`);
            break;
        case '/':
            self.emit(`push eax    ; simpan alamat result`);
            self.emit(`mov eax, edx    ; eax = dibagi`);
            self.emit(`cdq`);
            self.emit(`idiv ebx    ; eax = eax / ebx`);
            self.emit(`mov edx, eax    ; pindahkan hasil bagi ke edx`);
            self.emit(`pop eax    ; kembalikan alamat result`);
            break;
        case '%':
            self.emit(`push eax    ; simpan alamat result`);
            self.emit(`mov eax, edx`);
            self.emit(`cdq`);
            self.emit(`idiv ebx`);
            self.emit(`pop eax`);
            self.emit(`mov [eax], edx`); // Pindahkan sisa bagi (edx) ke memori hasil (eax) segera? 
            // Note: untuk operasi %, hasil akhir biasanya diharapkan ada di register edx untuk logic bawahnya
            // Tapi khusus % logic bawah (mov [eax], edx) akan menimpa lagi. 
            // Jadi biarkan edx berisi sisa bagi.
            break;
        case '<':
            self.emit(`cmp edx, ebx`);
            self.emit(`setl bl`);
            self.emit(`movzx edx, bl`); // Hasil boolean (0/1) masuk ke EDX
            break;
        case '>':
            self.emit(`cmp edx, ebx`);
            self.emit(`setg bl`);
            self.emit(`movzx edx, bl`);
            break;
        case '==':
            self.emit(`cmp edx, ebx`);
            if(mode === 'condition'){
                self.emit(`sete al`);       
                self.emit(`movzx eax, al`); 
                return { box: false, val: null }; 
            }
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
    };

    // --- FINISHING ---
    
    if(mode === 'condition') {
        // Untuk comparison operator (<, >, dll), hasil sudah ada di EDX (0 atau 1)
        // Kita perlu pindahkan ke EAX agar 'cmp eax, 0' di handleIf bekerja
        self.emit(`mov eax, edx`);
        return { box: false, val: resultVal };
    }

    // Jika bukan condition, simpan hasil (EDX) ke dalam Box (EAX)
    self.emit(`; simpan hasil ke Box`);
    self.emit(`mov [eax], edx    ; Masukkan value`);
    self.emit(`mov dword [eax+4], 0 ; Tipe data (anggap int/bool)`);
    self.blank(1);

    return { box: true, val: resultVal};
}

module.exports = generateBinaryOp;