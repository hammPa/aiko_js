function handleFunCall(self, stmt){
    const { name, args } = stmt;
    
    let funcName;

    if (typeof name === 'string') funcName = name;
    else if (name?.type === 'Identifier') funcName = name.name;
    else throw new Error('Invalid function name in call');
    
    const fn = self.resolveFunction(funcName);
    if (!fn) {
        throw new Error(`Function "${funcName}" not defined`);
    }

    if (args.length !== fn.paramCount) {
        throw new Error(
            `Function "${funcName}" expects ${fn.paramCount} args, got ${args.length}`
        );
    }

    //  push argumen dari kanan ke kiri
    for (let i = args.length - 1; i >= 0; i--) {
        const argExpr = args[i];

        // generateExpression WAJIB mengembalikan Box*
        const { box } = self.generateExpression(argExpr);

        // eax = Box*
        self.emit(`push eax    ; push arg ${i}`);
    }

    // panggil
    self.emit(`call fun_${funcName}`);

    // bersihkan argumen (cdecl)
    if (args.length > 0) {
        self.emit(`add esp, ${args.length * 4}`);
    }

    return { box: true, val: null };
}

module.exports = handleFunCall;