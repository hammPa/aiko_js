function generateIdentifier(self, expr){
    const variable = self.variables[expr.name];
    if(!variable) throw new Error(`Variable ${expr.name} not declared`);

    const offset = Math.abs(variable.offset);
    self.textSection.push(
        `\tmov eax, [ebp - ${offset}]    ; masukkan nilai yang tersimpan didalam offset ${variable.offset} ke register eax\n`
    );

    return {register: null, value: variable};
}

module.exports = generateIdentifier;