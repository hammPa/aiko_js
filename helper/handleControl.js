const {
    allocateStack,
    allocateHeap,
    initStackValue
} = require('../helper/allocate');

/**
 * Menghasilkan kode assembly untuk struktur if-elseif-else.
 * @param {Object} obj - AST node untuk if-statement.
 * @param {Object} self - Konteks generator (state compiler).
 */
function generateIf(obj, self) {
    const { condition, then_block, elifs, else_block } = obj;

    const ifLabel = `condition_${self.condition_index++}`;
    const endLabel = `${ifLabel}_end`;
    let nextLabel = elifs.length > 0 ? `${ifLabel}_elif_0` : (else_block ? `${ifLabel}_else` : endLabel);

    // Generate condition
    self.generateBinaryOp(condition);
    self.textSection.push(`\tcmp eax, 0\n`);
    self.textSection.push(`\tje ${nextLabel}\n`);

    // THEN block - ITERATE STATEMENTS
    self.textSection.push(`${ifLabel}_start:\n`);
    then_block.forEach(stmt => self.generateStatement(stmt)); // Perubahan di sini
    self.textSection.push(`\tjmp ${endLabel}\n`);

    // ELIF blocks
    elifs.forEach((elif_stmt, i) => {
        const elifLabel = `${ifLabel}_elif_${i}`;
        nextLabel = i + 1 < elifs.length 
            ? `${ifLabel}_elif_${i + 1}` 
            : (else_block ? `${ifLabel}_else` : endLabel);

        self.textSection.push(`${elifLabel}:\n`);
        self.generateBinaryOp(elif_stmt.condition);
        self.textSection.push(`\tcmp eax, 0\n`);
        self.textSection.push(`\tje ${nextLabel}\n`);
        
        // Iterate ELIF block statements
        elif_stmt.block.forEach(stmt => self.generateStatement(stmt)); // Perubahan di sini
        self.textSection.push(`\tjmp ${endLabel}\n`);
    });

    // ELSE block
    if (else_block) {
        self.textSection.push(`${ifLabel}_else:\n`);
        // Iterate ELSE block statements
        else_block.forEach(stmt => self.generateStatement(stmt)); // Perubahan di sini
    }

    self.textSection.push(`${endLabel}:\n`);
}

/**
 * Menghasilkan kode assembly untuk perulangan for.
 * @param {Object} obj - AST node untuk for-loop.
 * @param {Object} self - Konteks generator (state compiler).
 */
function generateFor(obj, self){
    const { var_name, start, end, step, block } = obj;

    // Alokasikan memory untuk iterator
    allocateStack(self, var_name, start, 4);
    initStackValue(self, var_name, start);

    const variableData = self.symbolTable[var_name];
    const offset = Math.abs(variableData.offset);
    

    const index = self.index_for++;
    const loop_label = `loop_${index}`;
    // Perbaikan: Gunakan operator perbandingan yang sesuai (jl untuk step negatif)
    const cmp_op = step === -1 ? 'jle' : 'jge';
    // Perbaikan: Gunakan operator yang sesuai (dec untuk step negatif)
    const step_op = step === -1 ? 'dec' : 'inc';
    
    
    self.textSection.push(
        `${loop_label}_start:\n` +
        `\tmov eax, [ebp - ${offset}]\n` +
        `\tcmp eax, ${end.value}\n` +
        `\t${cmp_op} ${loop_label}_end\n\n` // Gunakan operator perbandingan yang sesuai
    );

    // Generate body
    for(const stmt of block){
        self.generateStatement(stmt);
    }

    self.textSection.push(
        `\tmov eax, [ebp - ${offset}]\n` +
        `\t${step_op} eax\n` +
        `\tmov [ebp - ${offset}], eax\n` +
        `\tjmp ${loop_label}_start\n\n` +
        `${loop_label}_end:\n\n\n`
    );
}

module.exports = {
    generateIf,
    generateFor
};