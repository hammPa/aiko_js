function generateArrayLiteral(self, expr){
    const length = expr.elements.length;

    self.allocBox(length);
    for(let i = 0; i < length; i++){
        self.generateExpression(expr.elements[i], 'condition');
        const index = i > 0 ? ` + ${4 * (i * 2)}` : '';
        self.emit(`mov [eax${index}], ecx`);
    }

    return { box: true, val: null};
}

module.exports = generateArrayLiteral;