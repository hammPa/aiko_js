function handlePrint(self, stmt){
    const { expression } = stmt;
    const {register, value} = self.generateExpression(expression);
    
    // 1. number literal
    if(typeof value === 'number'){
        self.textSection.push(
            `\tpush ${register}    ; push nilai ${value} dalam register eax ke stack sebagai parameter fungsi\n`,
            `\tcall print_int    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
            `\tadd esp, 4    ; pop nilai ${value} dari stack\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
        );
    }

    // 2. string literal
    else if(typeof value === 'string'){
        const globalVarName = value;
        self.textSection.push(
            `\tmov ecx, ${globalVarName}\n`,
            `\tcall print_str    ; panggil fungsi untuk menampilkan nilai berupa string\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
        );
    }

    // 3. boolean literal
    else if(typeof value === 'boolean'){
        self.textSection.push(
            `\tpush eax    ; masukkan nilai ${value} yang tersimpan dalam register eax ke stack\n`,
            `\tcall print_int    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
        );
    }

    // 4. variable
    else if(typeof value === 'object'){
        const offset = Math.abs(value.offset);
        if(value.type === 'number'){
            self.textSection.push(
                // `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register eax\n`,
                `\tpush eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi\n`,
                `\tcall print_int    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
                `\tadd esp, 4    ; pop nilai ${value.value} dari stack\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
        else if(value.type === 'string'){
            self.textSection.push(
                `\tmov ecx, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register ecx\n`,
                `\tcall print_str    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
        else if(value.type === 'boolean'){
            self.textSection.push(
                // `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register eax\n`,
                `\tpush eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi\n`,
                `\tcall print_int    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
    }
}

module.exports = handlePrint;