function handlePrint(self, stmt){
  const { expression } = stmt;
  
  const { box, val } = self.generateExpression(expression);
  // console.log(self.variables);
  const varName = self.findVarNameByOffset(val);
  
  
  self.emit(`; ------------------------------ Start Print ------------------------------`);
  self.emit(`push dword [eax + 4]    ; push tipe data ${varName ? 'variabel: ' + varName : ''}`);
  self.emit(`push dword [eax]    ; push nilai ${varName ? 'variabel: ' +  varName : ''}`);
  self.emit(`call print_generic    ; panggil fungsi untuk menampilkan nilai`);
  self.emit(`add esp, 8    ; pop argument dari stack`);
  self.emit(`call newline    ; untuk memanggil enter`);
  self.emit(`; ------------------------------ End Print ------------------------------`);
  self.blank(1);
}

module.exports = handlePrint;