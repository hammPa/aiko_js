function handleFunCall(self, stmt){
    const { name, args } = stmt;
    
    // nama fungsi
    const identifier = typeof name === "string" ? name : name.name;
    
    // cari definisi fungsi
    const fnMeta = self.functionNames.find(fn => fn.name === identifier);
    if(!fnMeta){
        throw new Error(`Function "${identifier}" is not defined`);
    }
    
    const expected = fnMeta.paramCount;
    const got = args ? args.length : 0;
    
    if(expected !== got){
        throw new Error(
            `Function "${identifier}" expects ${expected} argument(s), but got ${got}`
        );
    }
    
    // push argumen ke stack
    if(args && args.length > 0){
        for(let i = args.length - 1; i >= 0; i--){
            const arg = self.generateExpression(args[i]);            
            if(typeof arg.value === "number"){
                self.textSection.push(
                    `\tpush 0    ; masukkan tipe data parameter (int)\n`,
                    `\tpush eax    ; push number literal parameter\n`,
                );
            }
            // else if(typeof arg.value === "boolean"){
            //     self.textSection.push(`\tpush ${arg.value ? 1 : 0}    ; push boolean literal\n`);
            // }
            else if(typeof arg.value === "string"){
                // console.log("argval: ", {arg});
                
                self.textSection.push(
                    `\tmov eax, ${arg.value}    ; ambil alamat string literal parameter\n`,
                    `\tpush 1\    ; masukkan tipe data parameter (str)\n`,
                    `\tpush eax    ; push alamat string\n`
                );
            }
            else if(typeof arg.value === "object" && arg.value.offset !== undefined){ // kalau argument adalah variable
                self.textSection.push(
                    `\tpush ${typeof arg.value.value === "number" ? 0 : 1}    ; push tipe data variable\n`,
                    `\tpush eax    ; push variable (sudah di-load ke eax)\n`
                );
            }
            else {
                throw new Error("Unsupported argument type: " + JSON.stringify(arg));
            }
        }
    }
    
    // panggil fungsi
    self.textSection.push(`\tcall ${identifier}\n`);
    
    if(args && args.length > 0){
        self.textSection.push(`\tadd esp, ${args.length * 8}    ; bersihkan parameter dari stack\n`);
    }
    
    self.textSection.push(`\n\n`);
    
    return { register: 'eax', type: 'dynamic', value: 'ebx', isFun: true };
}
module.exports = handleFunCall;