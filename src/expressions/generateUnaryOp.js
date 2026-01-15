function generateUnaryOp(self, stmt){
    // console.log(stmt);
    const { op, operand } = stmt;
    
    const { box, val } = self.generateExpression(operand);
    // disini eax = Box*

    // simpan nilai asli
    self.emit(`push eax    ; simpan Box* operand unary`);

    // eax = Box* result
    self.emit(`; result disimpan di register eax`);
    self.emit(`; Alokasikan 8 byte untuk Box (value + type)`);
    self.allocBox();
    
    self.emit(`pop ecx     ; ecx = Box* operand`);
    self.emit(`mov ebx, [ecx]  ; ebx = operand value`);

    let resultVal;

    switch(stmt.op){
        case '-':
            // arithmetic negation
            self.emit(`neg ebx        ; ebx = -ebx`);
            resultVal = -operand;
            break;
        case '!':
            // logical not
            self.emit(`cmp ebx, 0`);
            self.emit(`sete bl        ; bl = (ebx == 0)`);
            self.emit(`movzx ebx, bl ; ebx = zero-extended result`);
            resultVal = !operand;
            break;
        default: throw new Error(`Unsupported unary operator: ${stmt.op}`);
    }

    self.emit(`mov [eax], ebx ; simpan hasil unary ke Box result`);

    // === 6. Copy type (atau set manual kalau mau strict) ===
    self.emit(`mov edx, [ecx + 4]  ; ambil type operand`);
    self.emit(`mov [eax + 4], edx  ; type result = type operand`);

    return { box: true, val: resultVal };
}

module.exports = generateUnaryOp;