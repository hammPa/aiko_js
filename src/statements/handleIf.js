function handleIf(self, stmt){
    // console.log(stmt);
    const { condition, then_block, elifs, else_block } = stmt;
    
    const ifLabel = `cond_${self.ifCounter++}`;
    const thenLabel = `${ifLabel}_then`;
    const endLabel = `${ifLabel}_end`;
    let nextLabel = elifs.length > 0 ? `${ifLabel}_elif_0` : (else_block ? `${ifLabel}_else` : endLabel);
    
    // generate condition
    const condResult = self.generateExpression(condition);
    
    self.textSection.push(
        `\tcmp eax, 0    ; apakah false\n`,
        `\tje ${nextLabel}    ; kalau false lompat ke ${nextLabel}\n`,
        `\tjmp ${thenLabel}    ; kalau true lanjut ke then\n`
    );
    
    
    // then
    self.textSection.push(`${thenLabel}:\n`);
    // self.enterScope();
    for(const st of then_block){
        self.generateStatement(st);
    }
    // self.exitScope();
    self.textSection.push(`\tjmp ${endLabel}\n`);
    
    
    
    
    if(elifs){
        // elifs
        for(let i = 0; i < elifs.length; i++){
            const elif = elifs[i];
            const elifCondLabel = `${ifLabel}_elif_${i}`;
            const elifBodyLabel = `${elifCondLabel}_body`;
            const nextElifLabel = i + 1 < elifs.length ? 
                `${ifLabel}_elif_${i+1}` : (else_block ? `${ifLabel}_else` : endLabel);

            self.textSection.push(`${elifCondLabel}:\n`);

            const condResult = self.generateExpression(elif.condition);

            self.textSection.push(
                `\tcmp eax, 0\n`,
                `\tje ${nextElifLabel}    ; lompat ke ${nextElifLabel}\n`,
                `\tjmp ${elifBodyLabel}    ; lompat ke ${elifBodyLabel}\n`
            );

            self.textSection.push(`${elifBodyLabel}:\n`);
            // self.enterScope?.();
            for (const st of elif.block) {
                self.generateStatement(st);
            }
            // self.exitScope?.();
            self.textSection.push(`\tjmp ${endLabel}\n`);
        }
    }
    
    
    
    // else
    if(else_block){
        const elseLabel = `${ifLabel}_else`;
        self.textSection.push(`${elseLabel}:\n`);
        // self.enterScope();
        
        for(const st of else_block){
            self.generateStatement(st);
        }
        // self.exitScope();
        self.textSection.push(`\tjmp ${endLabel}\n`);
    }
    
    
    self.textSection.push(`${endLabel}:\n`);
}

module.exports = handleIf;