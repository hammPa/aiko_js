function generateInput(self, expr){
    const { print, data_type, line } = expr;

    if(print) self.generateStatement(print);
    if (data_type === 'int') {
      // ---------------------------------------------------------
      // STRATEGI BARU: Ambil Value Langsung dari EAX
      // ---------------------------------------------------------
      
      // 1. Panggil scan_int
      // (Asumsi: scan_int menyimpan angka hasil input user di register EAX)
      // Jika scan_int di stdio.asm kamu butuh argumen stack kosong, uncomment baris push/add di bawah
      self.emit(`push eax`); 
      self.emit(`call scan_int`);
      self.emit(`add esp, 4`);

      // Saat ini: EAX berisi angka 9 (hasil input)
      
      // 2. Simpan nilai EAX sementara di Stack 
      // (PENTING: Karena allocBox akan menimpa EAX dengan alamat memori baru)
      self.emit(`push eax`);        // Stack: [9]

      // 3. Buat Box Baru
      self.allocBox();              // EAX sekarang = Alamat Box Baru

      // 4. Masukkan NILAI ke dalam Box
      self.emit(`pop edx`);         // Ambil kembali angka 9 dari stack ke EDX
      
      self.emit(`mov dword [eax], edx`);   // Isi Box dengan Value (9)
      self.emit(`mov dword [eax + 4], 0`); // Tipe data Int (0)
    }
    else if (data_type === 'string') {
      // Untuk String, kita tetap simpan ALAMATNYA (karena string itu array/pointer)
      self.emit(`push 128`);
      self.emit(`call alloc`);
      self.emit(`add esp, 4`);
      self.emit(`push eax`);       // Simpan alamat buffer (untuk nanti dimasukkan ke box)
      self.emit(`push eax`);       // Copy alamat buffer (untuk argumen scan)
      
      self.emit(`push 128`);       // Argumen panjang string
      self.emit(`call scan_str`);
      self.emit(`add esp, 8`);     // Bersihkan argumen scan_str
      
      // Stack saat ini: [Alamat String Heap]
      
      self.allocBox();             // EAX = Alamat Box
      
      self.emit(`pop edx`);        // Ambil alamat string heap
      self.emit(`mov dword [eax], edx`);   // Box string berisi POINTER ke heap
      self.emit(`mov dword [eax + 4], 1`); // Tipe data String
    }
    return { box: true, value: 'input_result' };
}

module.exports = generateInput;