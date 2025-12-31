function handleFor(self, stmt) {
    const name = stmt.var_name;

    // self.enterScope();
    // 1. Inisialisasi variabel i di stack baru
    self.generateStatement({
        type: 'VarDecl',
        name,
        initializer: stmt.start
    });

    const currentScope = self.variables[self.variables.length - 1];
    const offset = Math.abs(currentScope[name].offset);

    // 2. Label unik
    const loopId = self.forCounter++;
    const loopCond = `loop_cond_${loopId}`;
    const loopBody = `loop_body_${loopId}`;
    const loopInc  = `loop_inc_${loopId}`;
    const loopEnd  = `loop_end_${loopId}`;

    // 3. Lompat ke kondisi
    self.textSection.push(`\tjmp ${loopCond}\n`);

    // 4. Kondisi
    self.textSection.push(`${loopCond}:\n`);
    const endExpr = self.generateExpression(stmt.end);

    if (endExpr.value !== undefined) {
        // kalau literal, langsung masukin ke ecx
        self.textSection.push(`\tmov ecx, ${endExpr.value}    ; end\n`);
    } else {
        self.textSection.push(`\tmov ecx, ${endExpr.register} ; end\n`);
    }

    self.textSection.push(
        `\tmov eax, [ebp - ${offset}]   ; load i\n`,
        `\tcmp eax, ecx                ; bandingkan i dengan end\n`,
        `\tjge ${loopEnd}               ; kalau i > end lompat ke akhir\n`,
        `\tjmp ${loopBody}\n`
    );

    // 5. Body
    self.textSection.push(`${loopBody}:\n`);
    for (const s of stmt.block) {
        self.generateStatement(s);
    }
    self.textSection.push(`\tjmp ${loopInc}\n`);

    // 6. Increment
    self.textSection.push(`${loopInc}:\n`);
    const stepExpr = self.generateExpression(stmt.step);

    if (stepExpr.value !== undefined) {
        self.textSection.push(`\tmov edx, ${stepExpr.value}    ; step\n`);
    } else {
        self.textSection.push(`\tmov edx, ${stepExpr.register} ; step\n`);
    }

    self.textSection.push(
        `\tmov eax, [ebp - ${offset}]   ; load i\n`,
        `\tadd eax, edx                ; i += step\n`,
        `\tmov [ebp - ${offset}], eax  ; simpan kembali\n`,
        `\tjmp ${loopCond}\n`
    );

    // 7. End
    self.textSection.push(`${loopEnd}:\n`);

    // self.exitScope();
}


module.exports = handleFor;