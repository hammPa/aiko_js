function generateIdentifier(self, expr){
    const variable = self.variables[expr.name];
    if(!variable) throw new Error(`Variable ${expr.name} not declared`);
    return {register: null, value: variable};
}

module.exports = generateIdentifier;