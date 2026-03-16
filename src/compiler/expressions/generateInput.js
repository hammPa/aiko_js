function generateInput(self, expr){
    const { print, data_type, line } = expr;

  	self.emit(`; ------------------------------ Start Input ------------------------------`);
    if(print) self.generateStatement(print);
    if (data_type === 'int') {
    	// 1. Panggil scan_int
    	self.emit(`push eax`); 
    	self.emit(`call scan_int`);
    	self.emit(`add esp, 4`);

      	// Saat ini: EAX berisi angka 9 (hasil input)
		
      	// 2. Simpan nilai EAX sementara di Stack 
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
		self.allocBox(16); // 128 byte
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
  	self.emit(`; ------------------------------ End Input ------------------------------`);
	self.blank(1);

    return { box: true, value: 'input_result' };
}

module.exports = generateInput;