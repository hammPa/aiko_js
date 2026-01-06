function handleVarDecl(self, stmt){
    const { box, val } = self.generateExpression(stmt.initializer);
    
    // alokasi 4 byte untuk variabel pointer
    self.currentOffset += 4;


    const offset = Math.abs(self.currentOffset);
    self.emit(`; deklarasi variabel ${stmt.name}`);
    self.emit(`sub esp, 4`);
    self.emit(`mov dword [ebp - ${offset}], eax    ; pindahkan alamat Box* ke dalam offset ${offset}`);
    self.blank(2);

    // daftarkan ke variables di scope sekarang
    self.defineVar(stmt.name, {
        offset: self.currentOffset,
        storage: 'stack',
        kind: 'box'
    });
}

module.exports = handleVarDecl;