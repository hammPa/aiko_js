module.exports = {
	allocBox(length = 1){
  	  	this.emit(`push ${8 * length}    ; ------------------------------ alokasi untuk ${length} element ------------------------------`);
  	  	// this.emit(`call alloc`);
		this.emit(`call arena_alloc`);
  	  	this.emit(`add esp, 4`);
  	},

    deallocBox(){
        // this.emit(`push 8`);       // Argumen 2: size
        // this.emit(`push eax`);     // Argumen 1: pointer
        // this.emit(`call dealloc`);
        // this.emit(`add esp, 8`);
    },

    findVarNameByOffset(targetOffset) {
  	  	// Kita iterasi dari scope paling dalam (index terakhir) ke luar
  	  	// agar memprioritaskan local scope saat ini.
  	  	for (let i = this.variables.length - 1; i >= 0; i--) {
  	  	  	const scope = this.variables[i];

  	  	  	// Loop setiap variabel dalam scope ini
  	  	  	for (const [name, meta] of Object.entries(scope)) {
  	  	  	  	// Cek apakah offset cocok DAN pastikan penyimpanannya di stack
  	  	  	  	if (meta.storage === 'stack' && meta.offset === targetOffset) {
  	  	  	  		return name;
  	  	  	  	}
  	  	  	}
  	  	}

    	return null; // Tidak ditemukan
  	}
};