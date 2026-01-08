function handleIf(self, stmt) {
    const ifId = self.ifCounter++;

    const thenLabel = `if_${ifId}_then`;
    const endLabel  = `if_${ifId}_end`;
    const elseLabel = stmt.else_block ? `if_${ifId}_else` : endLabel;

    const elifCondLabels = stmt.elifs.map(
        (_, i) => `if_${ifId}_elif_${i}_cond`
    );
    const elifThenLabels = stmt.elifs.map(
        (_, i) => `if_${ifId}_elif_${i}_then`
    );

    self.emit(`; ------------------------------ Kondisi if ${ifId} ------------------------------`);
    // IF condition
    self.generateExpression(stmt.condition, 'condition');
    self.emit(`; jika false maka lanjut kondisi selanjutnya`);
    self.emit(`cmp eax, 0`);
    self.emit(`je ${stmt.elifs.length > 0 ? elifCondLabels[0] : elseLabel}`);
    self.emit(`jmp ${thenLabel}`);

    // IF THEN
    self.emit(`${thenLabel}:`);
    self.enterScope();
    for (const s of stmt.then_block) {
        self.generateStatement(s);
    }

    self.setLine(stmt.line);
    
    self.exitScope();
    self.emit(`jmp ${endLabel}`);
    self.blank(1);

    // ELIF
    for (let i = 0; i < stmt.elifs.length; i++) {
        const nextFalse =
            i + 1 < stmt.elifs.length
                ? elifCondLabels[i + 1]
                : elseLabel;

        self.emit(`${elifCondLabels[i]}:`);
        self.generateExpression(stmt.elifs[i].condition, 'condition');
        self.emit(`cmp dword eax, 0`,);
        self.emit(`je ${nextFalse}`,);
        self.emit(`jmp ${elifThenLabels[i]}`);
        self.blank(1);

        self.emit(`${elifThenLabels[i]}:`);
        self.enterScope();
        for (const s of stmt.elifs[i].block) {
            self.generateStatement(s);
        }

        self.setLine(stmt.elifs[i].line || stmt.line);
        
        self.exitScope();
        self.emit(`jmp ${endLabel}`);
        self.blank(1);
    }

    // ELSE
    if (stmt.else_block) {
        self.emit(`${elseLabel}:`);
        self.enterScope();
        for (const s of stmt.else_block) {
            self.generateStatement(s);
        }

        self.setLine(stmt.line);
        self.exitScope();
    }

    self.emit(`${endLabel}:`);
    self.blank(1);
}


module.exports = handleIf;
