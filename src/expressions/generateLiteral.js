function generateLiteral(self, expr, mode){
  const { value } = expr;
  // console.log({mode});
  if(mode === 'condition'){
    // console.log("yg jalan yg langsung");
    
    self.emit(`mov ecx, ${value}    ; masukkan nilai ${value} ke register ecx`);
    return { box: false, val: value };
  }
    
    // console.log("yg jalan yg box");
  // alokasikan struct Box (8 byte)
  self.emit(`; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------`);
  self.allocBox();
  // disini sekarang eax = Box* (alamat Box)

  if(typeof value === 'number'){
    self.emit(`mov dword [eax], ${value}    ; masukkan nilai ${value} ke alamat dalam register eax`);
    self.emit(`mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0`);
    // self.blank(2);
  }
  else if(typeof value === 'boolean'){
    self.emit(`mov dword [eax], ${value === true ? 1 : 0}    ; masukkan nilai ${value ? 'true' : 'false'} dengan angka berupa ${value ? 1 : 0} ke alamat dalam register eax`);
    self.emit(`mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean`);
    // self.blank(2);
  }
  else if(typeof value === 'string'){
    const label = `str_${self.stringLiteralCounter++}`;
    self.dataSection.push(`\t${label} db "${value}", 0    ; buat variabel string global bernama ${label} dengan tipe byte`);
    self.emit(`mov dword [eax], ${label}    ; masukkan alamat label ke alamat dalam register eax`);
    self.emit(`mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string`);
    // self.blank(2);
  }
  else {
    throw new Error("Unsupported literal type");
  }

  // return Box*
  return { box: true, val: value };
}

module.exports = generateLiteral;