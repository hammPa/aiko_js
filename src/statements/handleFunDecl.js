function handleFunDecl(self, stmt){
    const { name, params, body } = stmt;
    const oldSection = self.textSection; // current section sekarang adalah function body
    
    // arahkan semua statement fungsi ke funcBody
    self.textSection = [];
    
    self.enterScope();
    self.textSection.push(
        `\tpush ebp    ; buat stack frame baru\n`,
        `\tmov ebp, esp\n\n`
    );
    
    if(params){
        // console.log(params);                
        const dataSize = 4; // 4 byte per slot
        for (let i = 0; i < params.length; i++) {
            const param = params[i];
            const paramName = param.name;
    
            // nilai di stack (value dulu, lalu type)
            // param pertama = value [ebp+8], type [ebp+12]
            // param kedua   = value [ebp+16], type [ebp+20]
            const valueOffset = (i * (dataSize * 2)) + 8;
            const typeOffset  = valueOffset + 4;
    
            self.variables[self.variables.length - 1][paramName] = {
                offset: valueOffset,
                typeOffset,
                type: 'dynamic',
                size: dataSize * 2,
                value: 0,
                isParam: true
            };
        }
    
        // console.log(self.variables);
    }
    
    
    for(const innerStmt of body){
        // console.log({innerStmt});
        
        self.generateStatement(innerStmt);
    }
    self.textSection.push(
        `\n\tmov esp, ebp    ; bersihkan stack frame saat fungsi selesai\n`,
        `\tpop ebp\n`,
        '\tret\n',
    );
    self.exitScope();
    
    // baru tulis definisi fungsi
    self.functiontSection.push(`${name}:\n`);
    self.functiontSection.push(...self.textSection);
    
    // balik lagi ke section lama (_start)
    self.textSection = oldSection;
    
    // self.functionNames.push(name);
    self.functionNames.push({
        name: name,
        paramCount: params ? params.length : 0,
        paramNames: params ? params.map(p => p.name) : []
    });
}

module.exports = handleFunDecl;