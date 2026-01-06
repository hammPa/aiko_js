function generateIdentifier(self, expr){
    const meta = self.resolveVar(expr.name);
    if (!meta) throw new Error(`Undefined variable ${expr.name}`);  
    
    // load Box* ke eax
    self.emit(`; ambil offset variabel ${expr.name}`);

    if(meta.kind === 'param'){
        self.emit(`mov eax, [ebp + ${meta.offset}]    ; eax = Box*`);    
    }
    else {
        self.emit(`mov eax, [ebp - ${meta.offset}]    ; eax = Box*`);
    }
    self.blank(1);
    return { box: true };
}

module.exports = generateIdentifier;