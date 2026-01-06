function handleFunDecl(self, stmt){
    const { name, params, body } = stmt;
    
    // daftarkan fungsi
    self.registerFunction({
        name,
        paramCount: params.length,
        paramNames: params
    });

    const oldSection = self.textSection; // current section sekarang adalah function body
    
    // arahkan semua statement fungsi ke funcBody
    self.textSection = [];
    
    self.enterScope();
    self.emit(`push ebp    ; buat stack frame baru`);
    self.emit(`mov ebp, esp`);
    self.blank(1);
    
    console.log(params);
    
    // bind parameter ke scope
    params.forEach((param, i) => {
        const paramName =
            typeof param === 'string'
                ? param
                : param?.type === 'Identifier'
                    ? param.name
                    : (() => { throw new Error('Invalid parameter'); })();

        const offset = 8 + i * 4;

        self.defineVar(paramName, {
            offset,
            storage: 'stack',
            kind: 'param'
        });
    });
    
    
    for(const innerStmt of body){
        // console.log({innerStmt});
        self.generateStatement(innerStmt);
    }
    
    self.blank(1);
    self.exitScope();
    self.blank(2);
    self.emit(`mov esp, ebp    ; bersihkan stack frame saat fungsi selesai`);
    self.emit(`pop ebp`);
    self.emit('ret');
    self.blank(5); 
    
    // baru tulis definisi fungsi
    self.functiontSection.push(`${name}:\n`);
    self.functiontSection.push(...self.textSection);

    // balik lagi ke section lama (_start)
    self.textSection = oldSection;
}

module.exports = handleFunDecl;