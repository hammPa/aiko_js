function generateArrayAccess(self, expr){
    const { array_name, index } = expr;

    // jika index adalah literal bukan variabel
    if (index.type === 'Literal') {
        // 1. Load Index ke ECX
        self.generateExpression(index, 'condition');
    } 
    else {
        // 1. Dapatkan ALAMAT variabel index (misal 'i')
        // hasil generate di ecx
        self.emit(`; ambil alamat variabel`);
        self.generateExpression(index);         
        self.emit(`mov ecx, [eax]    ; pindahkan nilai ke ecx`); // Sekarang ECX berisi value indeks (misal: 2)
    }
    // 2. Load Array Base ke EAX (sementara, untuk pengecekan)
    // bisaditambahkan push ecx dan pop di sini kalau misal tabrakan register
    self.generateExpression(array_name); // EAX = Base Array Address
    // EAX sudah berisi Array Address
    // ECX sudah berisi Index Value
    self.emit(`call check_bound  ; Runtime check: crash jika index invalid`);
    
    // Jika program tidak crash di atas, berarti index aman.        
    self.emit(`imul ecx, 8`);    // Offset = Index * 8
    
    // karna check bound tidak mengubah register apa apa tidak perlu push dan ambil variabel lgi
    self.emit(`add eax, ecx`);   // Base + Offset Data
    self.emit(`add eax, 8`);     // Skip Header
    
    return { box: true, val: index.value};
}

module.exports = generateArrayAccess;