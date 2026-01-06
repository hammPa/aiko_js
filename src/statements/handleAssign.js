function handleAssign(self, stmt){
    const { variable, initializer } = stmt;

    const meta = self.resolveVar(variable.name);
    console.log(meta);
    if (!meta) {
        throw new Error(`Undefined variable ${variable.name}`);
    }

    self.generateExpression(initializer);

    // free jangan lupa nanti

    self.emit(`mov dword [ebp - ${meta.offset}], eax    ; ${variable.name} = Box*`);
}

module.exports = handleAssign;