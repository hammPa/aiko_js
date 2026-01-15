function generateArrayAccess(self, expr){
    const { array_name, index } = expr;

    // jika index adalah literal bukan variabel
    if (index.type === 'Literal') {
        // Jangan ubah index.value langsung di AST, gunakan variabel lokal
        const offset = index.value * 8; 
        
        // Load alamat dasar array ke EAX
        self.generateExpression(array_name); 
        
        // Tambahkan offset manual
        if (offset > 0) {
            self.emit(`add eax, ${offset}`);
        }
    } 
    else {
        // 1. Dapatkan ALAMAT variabel index (misal 'i')
        // Asumsi: hasil ada di ECX (pointer ke variabel i)
        self.generateExpression(index); 
        
        // KOREKSI PENTING:
        // Karena ECX berisi alamat, kita harus ambil VALUE-nya dulu.
        // Contoh: i = 2. ECX menunjuk ke stack dimana angka 2 disimpan.
        self.emit(`mov ecx, [eax]`); // Sekarang ECX berisi value indeks (misal: 2)
        // 3. Kalikan VALUE index dengan 8 (karena 1 elemen = 8 byte)
        self.emit(`imul ecx, 8`);       // ECX = i * 8 (Offset dalam byte)
        
        // 4. Simpan Offset (ECX) ke Stack sebentar
        // Agar register aman saat kita meload base address array
        self.emit(`push ecx`);
        
        // 5. Dapatkan base address array
        // Asumsi: hasil ada di EAX
        self.generateExpression(array_name); 
        
        // 6. Ambil kembali Offset dari stack
        self.emit(`pop ecx`);
        
        // 7. Tambahkan Base Address (EAX) + Offset (ECX)
        self.emit(`add eax, ecx`);      // EAX sekarang menunjuk ke elemen array yang tepat
    }
    
    return { box: true, val: index.value};
}

module.exports = generateArrayAccess;