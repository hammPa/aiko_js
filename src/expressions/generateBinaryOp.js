function generateBinaryOp(self, expr){
    const op = expr.op;
            
    const { register: leftRegisterEax, value: leftValue } = self.generateExpression(expr.left);
    self.textSection.push(`\tpush eax    ; simpan left operand ke stack\n`);
    const { register: rightRegisterEax, value: rightValue } = self.generateExpression(expr.right);
    self.textSection.push(`\tpop ecx    ; ambil right operand dari stack\n`);
    
    // let isFloat = false;
    // if(!Number.isInteger(leftValue) || !Number.isInteger(rightValue)){
    //     isFloat = true;
    // }
    
    // baru bisa int saja
    let resultVal;
    switch(op){
        case '+':
            self.textSection.push(`\tadd eax, ecx    ; ${leftValue}(ecx) + ${rightValue} eax\n`);
            resultVal = leftValue + rightValue;
            break;
        case '-':
            self.textSection.push(
                `\tsub ecx, eax    ; ${leftValue}(ecx) - ${rightValue}(eax)\n`,
                `\tmov eax, ecx    ; pindahkan hasil pengurangan dari register ecx ke eax\n`
            );
            resultVal = leftValue - rightValue;
            break;
        case '*':
            self.textSection.push(`\timul eax, ecx    ; ${leftValue}(eax) * ${rightValue}(ecx)\n`);
            resultVal = leftValue * rightValue;
            break;
        case '/':
            self.textSection.push(
                `\txchg eax, ecx\n`,
                `\tcdq\n`,
                `\tdiv ecx\n`
            );
            resultVal = leftValue / rightValue;
            break;
        case '<':
            self.textSection.push(
                `\tcmp ecx, eax\n`,
                `\tsetl al\n`,
                `\tmovzx eax, al\n`
            );
            resultVal = leftValue < rightValue ? 1 : 0;
            break;
        case '>':
            self.textSection.push(
                `\tcmp ecx, eax\n`,
                `\tsetg al\n`,
                `\tmovzx eax, al\n`
            );
            resultVal = leftValue > rightValue ? 1 : 0;
            break;
        case '==':
            self.textSection.push(
                `\tcmp ecx, eax\n`,
                `\tsete al\n`,
                `\tmovzx eax, al\n`
            );
            resultVal = leftValue == rightValue ? 1 : 0;
            break;
        case '!=':
            self.textSection.push(
                `\tcmp ecx, eax\n`,
                `\tsetne al\n`,
                `\tmovzx eax, al\n`
            );
            resultVal = leftValue != rightValue ? 1 : 0;
            break;
        case '<=':
            self.textSection.push(
                `\tcmp ecx, eax\n`,
                `\tsetle al\n`,
                `\tmovzx eax, al\n`
            );
            resultVal = leftValue <= rightValue ? 1 : 0;
            break;
        case '>=':
            self.textSection.push(
                `\tcmp ecx, eax\n`,
                `\tsetge al\n`,
                `\tmovzx eax, al\n`
            );
            resultVal = leftValue >= rightValue ? 1 : 0;
            break;
        case '!':
            self.textSection.push(
                `\tcmp eax, 0    ; cek apakah eax == 0\n`,
                `\tsete al       ; kalau eax == 0 maka al = 1, kalau tidak al = 0\n`,
                `\tmovzx eax, al ; masukkan hasil ke eax (0/1)\n`
            );
            resultVal = (leftValue == 0 ? 1 : 0);  // fallback JS buat evaluasi hasil
            break;
    };
    self.textSection.push("\n\n");
    return {register: 'eax', value: resultVal};
}

module.exports = generateBinaryOp;