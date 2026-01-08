function generateBinaryOp(self, expr, mode){
    const { left, op, right } = expr;
    let boxLeft, boxRight, leftVal, rightVal;

    // khusus keduanya angka
    if(left.type === 'Literal' && right.type === 'Literal'){
        self.generateExpression(left, 'conditional');
        self.generateExpression(right, 'conditional');        
    }
    else if(mode === 'condition'){
        // left = value from Box*
        ({ box: boxLeft, val: leftVal } = self.generateExpression(left, 'condition'));
        self.emit(`mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx`);

        // right = rVal
        ({ box: boxRight, val: rightVal } = self.generateExpression(right, 'condition'));
    }
    else {
        // eax = Box* (left)
        ({ box: boxLeft, val: leftVal } = self.generateExpression(left));
        self.emit(`push eax    ; simpan Box* left operand ke stack`);
    
        // eax = Box* (right)
        ({ box: boxRight, val: rightVal } = self.generateExpression(right));
        self.emit(`mov esi, eax    ; esi = Box* right operand`);
        self.emit(`pop ecx    ; ecx = Box* left operand`);
        
    
        // eax = Box* result
        self.emit(`; result disimpan di register eax`);
        self.emit(`push 8    ; Alokasikan 8 byte untuk Box (value + type)`);
        self.emit(`call alloc`);
        self.emit(`add esp, 4`);
    
        // edx = left, ebx = right
        self.emit(`mov edx, [ecx]      ; ambil left value dari ecx`);
        self.emit(`mov ebx, [esi]      ; ambil right value dari esi`);
        
    }
    // baru bisa int saja
    let resultVal;
    let leftDisplay = typeof leftVal === 'object' ? leftVal.value : leftVal;
    let rightDisplay = typeof rightVal === 'object' ? rightVal.value : rightVal;
    // console.log({leftVal, rightVal});

    const regRight = mode === 'condition' ? 'ecx' : 'ebx';
    switch(op){
        case '+':
            self.emit(`add edx, ebx    ; ${leftDisplay} + ${rightDisplay}`);
            resultVal = leftDisplay + rightDisplay;
            break;
        case '-':
            self.emit(`sub edx, ebx    ; ${leftDisplay} - ${rightDisplay}`);
            resultVal = leftDisplay - rightDisplay;
            break;
        case '*':
            self.emit(`imul edx, ebx    ; ${leftDisplay} * ${rightDisplay}`);
            resultVal = leftDisplay * rightDisplay;
            break;
        case '/':
            self.emit(`push eax    ; simpan alamat result`);
            self.emit(`mov eax, edx    ; eax = dibagi`);
            self.emit(`cdq`);
            self.emit(`idiv ebx    ; eax = eax / ebx, sisa bagi di edx`);
            self.emit(`mov edx, eax    ; pindahkan hasil bagi ke edx`);
            self.emit(`pop eax    ; kembalikan alamat result`);
            resultVal = leftDisplay / rightDisplay;
            break;
        case '%':
            self.emit(`push eax    ; simpan alamat result`);
            self.emit(`mov eax, edx    ; eax = dibagi`);
            self.emit(`cdq`);
            self.emit(`idiv ebx    ; eax = eax / ebx, sisa bagi di edx`);
            self.emit(`pop eax    ; kembalikan alamat result`);
            self.emit(`mov [eax], edx    ; pindahkan hasil sisa bagi ke eax`);
            resultVal = leftDisplay % rightDisplay;
            break;
        case '<':
            self.emit(`cmp edx, ebx`);
            self.emit(`setl bl`);
            self.emit(`movzx edx, bl`);
            resultVal = leftDisplay < rightDisplay ? 1 : 0;
            break;
        case '>':
            self.emit(`cmp edx, ebx`);
            self.emit(`setg bl`);
            self.emit(`movzx edx, bl`);
            resultVal = leftDisplay > rightDisplay ? 1 : 0;
            break;
        case '==':
            self.emit(`cmp edx, ${regRight}`);
            if(mode === 'condition'){
                self.emit(`sete al`);       // Set byte al jadi 1/0
                self.emit(`movzx eax, al`); // Pindahkan ke EAX (register return untuk if)
                
                // PENTING: RETURN DISINI! 
                // Agar tidak lanjut ke kode "simpan hasil" di bawah yang akan menimpa variabel i.
                return { box: false, val: leftDisplay == rightDisplay }; 
            }
            
            self.emit(`sete bl`);
            self.emit(`movzx edx, bl`);
            resultVal = leftDisplay == rightDisplay ? 1 : 0;
            break;
        case '!=':
            self.emit(`cmp edx, ebx`);
            self.emit(`setne bl`);
            self.emit(`movzx edx, bl`);
            resultVal = leftDisplay != rightDisplay ? 1 : 0;
            break;
        case '<=':
            self.emit(`cmp edx, ebx`);
            self.emit(`setle bl`);
            self.emit(`movzx edx, bl`);
            resultVal = leftDisplay <= rightDisplay ? 1 : 0;
            break;
        case '>=':
            self.emit(`cmp edx, ebx`);
            self.emit(`setge bl`);
            self.emit(`movzx edx, bl`);
            resultVal = leftDisplay >= rightDisplay ? 1 : 0;
            break;
    };

    self.emit(`; simpan hasil`);
    self.emit(`mov [eax], edx    ; Box* dalam eax = ${resultVal}`);
    self.emit(`mov dword [eax+4], 0`);
    self.blank(1);

    if(mode === 'condition') return { box: false, val: resultVal };
    return { box: true, val: resultVal};
}

module.exports = generateBinaryOp;