function generateTypeof(self, expr){
    const { expression } = expr;

    self.emit(`; TYPEOF`);
    const { box, val } = self.generateExpression(expression);
    
    self.emit(`mov ecx, [eax + 4]`);
    self.emit(`push ecx`);
    self.emit(`call typeof`);
    self.emit(`add esp, 4`);
    self.emit(`mov ecx, eax`);
    self.allocBox(1);
    self.emit(`mov dword [eax], ecx    ; masukkan tipe data ke alamat dalam register eax`);
    self.emit(`mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0`);
    return { box: true, val: 'typee' };
}

module.exports = generateTypeof;