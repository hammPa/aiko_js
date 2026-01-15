function handleAssign(self, stmt){
    const { variable, initializer } = stmt;
    console.log(variable);
    
    let meta;
    if(variable.type === 'ArrayAccess') meta = self.resolveVar(variable.array_name.name);
    else meta = self.resolveVar(variable.name);
    
    if (!meta) {
        throw new Error(`Undefined variable ${variable.name}`);
    }

    self.generateExpression(initializer);

    // free jangan lupa nanti

    self.emit(`; ------------------------------ Assign ke variabel ${variable.name} ------------------------------`);
    self.emit(`mov dword [ebp - ${meta.offset}], eax    ; ${variable.name} = Box*`);
}

module.exports = handleAssign;