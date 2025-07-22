const {
    allocateStack,
    allocateHeap,
    initStackValue
} = require('../helper/allocate');

/**
 * Menghasilkan kode assembly untuk sebuah fungsi.
 * @param {Object} obj - Objek AST fungsi berisi name, params, dan body.
 * @param {Object} self - Konteks generator (menyimpan dataSection, textSection, dll).
 */
function generateFun(obj, self) {
    const { name, params, body } = obj;
    
    // Simpan konteks saat ini
    const savedTextSection = self.textSection;
    const savedReturnFlag = self.returnEncountered;
    self.textSection = [];
    self.returnEncountered = false;
    
    // Prolog fungsi
    self.textSection.push(`${name}:\n`);
    self.textSection.push('\tpush ebp\n');
    self.textSection.push('\tmov ebp, esp\n');
    
    // Handle parameter (disimpan di stack: [ebp+8], [ebp+12], dst)

    params.forEach((param, index) => {
        allocateStack(self, param, { type: 'Literal', value: 0 }, 4, true, index);
    });
    
    // Generate body fungsi
    body.forEach(stmt => self.generateStatement(stmt));
    
    // Tambahkan epilog HANYA JIKA return tidak ditemukan
    if (!self.returnEncountered) {
        self.textSection.push('\tmov esp, ebp\n');
        self.textSection.push('\tpop ebp\n');
        self.textSection.push('\tret\n');
    }
    
    // Simpan kode fungsi ke subroutineSection
    self.subroutineSection.push(...self.textSection);
    
    // Kembalikan konteks sebelumnya
    self.textSection = savedTextSection;
    self.returnEncountered = savedReturnFlag;
}

/**
 * Menghasilkan kode assembly untuk statement 'return'.
 * @param {Object} obj - Objek AST return, berisi nilai return.
 * @param {Object} self - Konteks generator.
 */
function generateReturn(obj, self) {
    const { value } = obj;

    self.returnEncountered = true;
    
    // Generate nilai return    
    if (value.type === 'BinaryOp') { // contoh : return 10 + 5
        self.generateBinaryOp(value);
    }
    else if (value.type === 'Literal') { // contoh: return 5
        // console.log("ini langsung 5", value);
        self.textSection.push(`\tmov eax, ${value.value}\n`);
    }
    else if (value.type === 'Identifier') {
        // console.log("hjmmmm", value);
        const variableData = self.symbolTable[value.name];
        const offset = variableData.offset;
        if (offset >= 0) {
            self.textSection.push(`\tmov eax, [ebp + ${offset}]\n`);
        } else {
            self.textSection.push(`\tmov eax, [ebp - ${Math.abs(offset)}]\n`);
        }
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