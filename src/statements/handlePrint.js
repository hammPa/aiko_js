function handlePrint(self, stmt){
  const { expression } = stmt;
    
  const { box, val } = self.generateExpression(expression);
  

  self.emit(`; print`);
  self.emit(`push dword [eax + 4]    ; push tipe data value (${typeof val})`);
  self.emit(`push dword [eax]    ; push nilai ${val} dalam register eax ke stack sebagai parameter fungsi`);
  self.emit(`call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number`);
  self.emit(`add esp, 8    ; pop argument dari stack`);
  self.emit(`call newline    ; untuk memanggil enter`);
  self.blank(1);
}

module.exports = handlePrint;