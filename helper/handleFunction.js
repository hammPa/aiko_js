// helper/handleFunction.js
/**
 * Menghasilkan kode assembly untuk sebuah fungsi.
 * @param {Object} obj - Objek AST fungsi berisi name, params, dan body.
 * @param {Object} self - Konteks generator (menyimpan dataSection, textSection, dll).
 */
function generateFun(obj, self) {
    const { name, params, body } = obj;
    
    // Simpan konteks saat ini
    const savedTextSection = self.textSection;
    self.textSection = [];
    
    // Prolog fungsi
    self.textSection.push(`${name}:\n`);
    self.textSection.push('\tpush ebp\n');
    self.textSection.push('\tmov ebp, esp\n');
    
    // Handle parameter (disimpan di stack: [ebp+8], [ebp+12], dst)
    params.forEach((param, index) => {
        const offset = 8 + index * 4;
        self.textSection.push(`\tmov eax, [ebp+${offset}]\n`);
        self.textSection.push(`\tmov [${param}], eax\n`);
        self.variablesType[param] = 'number';
        self.dataSection.push(`\t${param} dd 0\n`);
    });
    
    // Generate body fungsi
    body.forEach(stmt => self.generateStatement(stmt));
    
    // Epilog fungsi
    self.textSection.push('\tmov esp, ebp\n');
    self.textSection.push('\tpop ebp\n');
    self.textSection.push('\tret\n');
    
    // Simpan kode fungsi ke subroutineSection
    self.subroutineSection.push(...self.textSection);
    
    // Kembalikan konteks sebelumnya
    self.textSection = savedTextSection;
}

/**
 * Menghasilkan kode assembly untuk statement 'return'.
 * @param {Object} obj - Objek AST return, berisi nilai return.
 * @param {Object} self - Konteks generator.
 */
function generateReturn(obj, self) {
    const { value } = obj;
    
    // Generate nilai return
    if (value.type === 'BinaryOp') {
        self.generateBinaryOp(value);
    } else if (value.type === 'Literal') {
        self.textSection.push(`\tmov eax, ${value.value}\n`);
    } else if (value.type === 'Identifier') {
        self.textSection.push(`\tmov eax, [${value.name}]\n`);
    }
    
    // Kembalikan kontrol
    self.textSection.push('\tmov esp, ebp\n');
    self.textSection.push('\tpop ebp\n');
    self.textSection.push('\tret\n');
}

module.exports = {
    generateFun,
    generateReturn
};