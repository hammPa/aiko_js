function handleFunDecl(self, stmt){
    const { name, params, body } = stmt;
    
    // daftarkan fungsi
    self.registerFunction({
        name,
        paramCount: params.length,
        paramNames: params
    });


    self.currentFunction = name;

    const oldSection = self.textSection; // current section sekarang adalah function body
    const oldSourceMap = self.sourceMap;       // <--- Simpan map utama
    const oldIndent = self.indentLevel;        // <--- Simpan indentasi
    
    // arahkan semua statement fungsi ke funcBody
    self.textSection = [];
    self.sourceMap = [];                       // <--- Reset map untuk fungsi ini
    self.indentLevel = 1;                      // <--- Reset indent jadi 1 (biar rapi)
    
    self.enterScope();
    self.emit(`push ebp    ; buat stack frame baru`);
    self.emit(`mov ebp, esp`);
    self.blank(1);
    
    // console.log(params);
    
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
    self.textSection.push(`${name}_exit:`);
    self.emit(`mov esp, ebp    ; bersihkan stack frame saat fungsi selesai`);
    self.emit(`pop ebp`);
    self.emit('ret');
    
    // baru tulis definisi fungsi
    self.functiontSection.push(`; ------------------------------ Deklarasi fungsi ${name} ------------------------------`);
    self.functiontSection.push(`${name}:`);
    self.functionSourceMap.push(stmt.line || 0);
    
    // Push Code & Map
    self.functiontSection.push(...self.textSection);
    self.functionSourceMap.push(...self.sourceMap); // <--- Simpan map fungsi ke functionSourceMap
    
    // balik lagi ke section lama (_start)
    self.textSection = oldSection;
    self.sourceMap = oldSourceMap;             // <--- Balikin map utama
    self.indentLevel = oldIndent;              // <--- Balikin indentasi
}

module.exports = handleFunDecl;