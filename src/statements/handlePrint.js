function handlePrint(self, stmt){
    const { expression } = stmt;
    const {register, value} = self.generateExpression(expression);

    if(expression.type === 'FunctionCall'){
        console.log({expression});
        
        self.textSection.push(
            `\tpush ${value}    ; hasil return tipe data value\n`,
            `\tpush ${register}    ; hasil return fungsi (ada di eax)\n`,
            `\tcall print_generic    ; print hasil dari fungsi\n`,
            `\tadd esp, 8    ; bersihkan stack\n`,
            `\tcall newline    ; buat baris baru\n\n`,
        );
    }
    else if(value.type === 'unknownFunType'){
        const labelInt = self.newLabel("isInt");
        const labelString = self.newLabel("isString");
        const labelEnd = self.newLabel("endType");
        const offset = Math.abs(value.offset);

        self.textSection.push( // cuma ini yang kepikiran caranya, cek saat runtime
            `\tcmp ebx, 0\n`, // walaupun jadinya mengulang kode yang sama setiap print return
            `\tje ${labelInt}\n`, // ini menyalin else if pada variable yang dibawah
            `\tcmp ebx, 1\n`,
            `\tje ${labelString}\n`,
            `\tjmp ${labelEnd}\n\n`,

            `${labelInt}:\n`,
            `\tpush 0    ; push tipe data value sebagai int(0)\n`,
            `\tpush eax    ; push nilai ${value} dalam register eax ke stack sebagai parameter fungsi\n`,
            `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
            `\tadd esp, 8    ; pop argument dari stack\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
            `\tjmp ${labelEnd}\n\n`,

            `${labelString}:\n`,
            `\tpush 1    ; push tipe data sebagai string(1)\n`,
            `\tmov ecx, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register ecx\n`,
            `\tpush ecx\n`,
            `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa string\n`,
            `\tadd esp, 8    ; pop argument dari stack\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
            `\tjmp ${labelEnd}\n\n`,

            `${labelEnd}:\n\n\n`,

        );
    }

    // 1. number literal
    else if(typeof value === 'number'){
        self.textSection.push(
            `\tpush 0    ; push tipe data value sebagai int (0)\n`,
            `\tpush ${register}    ; push nilai ${value} dalam register eax ke stack sebagai parameter fungsi\n`,
            `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
            `\tadd esp, 8    ; pop argument dari stack\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
        );
    }

    // 2. string literal
    else if(typeof value === 'string'){
        const globalVarName = value;
        self.textSection.push(
            `\tpush 1    ; push tipe data value sebagai str(1)\n`,
            `\tpush ${globalVarName}\n`,
            `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa string\n`,
            `\tadd esp, 8    ; pop argument dari stack\n`,
            `\tcall newline    ; untuk memanggil enter\n\n`,
        );
    }

    // 3. boolean literal -> tidak digunakan karna pakai int saja
    // else if(typeof value === 'boolean'){
    //     self.textSection.push(
    //         `\tpush eax    ; masukkan nilai ${value} yang tersimpan dalam register eax ke stack\n`,
    //         `\tcall print_int    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
    //         `\tcall newline    ; untuk memanggil enter\n\n`,
    //     );
    // }

    // 4. variable
    else if(typeof value === 'object'){
        // console.log(register, value);
        const offset = Math.abs(value.offset);
        if(value.type === 'number'){
            self.textSection.push(
                `\tpush 0    ; push tipe data variabel sebagai int(0)\n`,
                // `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register eax\n`,
                `\tpush eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi\n`,
                `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
                `\tadd esp, 8    ; pop argument dari stack\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
        else if(value.type === 'string'){
            self.textSection.push(
                `\tpush 1    ; masukkan tipe data variabel sebagai string(1)\n`,
                `\tmov ecx, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register ecx\n`,
                `\tpush ecx\n`,
                `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
                `\tadd esp, 8    ; pop argument dari stack\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
        else if(value.type === 'boolean'){
            self.textSection.push(
                `\tpush 0    ; masukkan tipe data variabel sebagai bool(int -> 1)\n`,
                // `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register eax\n`,
                `\tpush eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi\n`,
                `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai berupa number\n`,
                `\tadd esp, 8    ; pop argument dari stack\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
        else if(value.type === 'dynamic' && value.isParam){ // argument
            self.textSection.push(
                `\tmov ebx, [ebp + ${Math.abs(value.typeOffset)}]    ; masukkan offset tipe data variable dynamic\n`,
                `\tpush ebx    ; push tipe data variabel dynamic\n`,
                // `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${value.offset} ke register eax\n`,
                `\tpush eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi\n`,
                `\tcall print_generic    ; panggil fungsi untuk menampilkan nilai\n`,
                `\tadd esp, 8    ; pop argument dari stack\n`,
                `\tcall newline    ; untuk memanggil enter\n\n`,
            );
        }
        else console.log({value});
        
    }
}

module.exports = handlePrint;