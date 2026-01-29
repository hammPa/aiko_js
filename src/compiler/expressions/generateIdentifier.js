function generateIdentifier(self, expr){
    const meta = self.resolveVar(expr.name);
    if (!meta) throw new Error(`Undefined variable ${expr.name}`);  
    
    // load Box* ke eax
    self.emit(`; ------------------------------ Start Ambil offset variabel ${expr.name} ------------------------------`);

    if(meta.kind === 'param'){
        self.emit(`mov eax, [ebp + ${meta.offset}]    ; eax = Box*`);    
    }
    else {
        self.emit(`mov eax, [ebp - ${meta.offset}]    ; eax = Box*`);
    }
    self.emit(`; ------------------------------ End Ambil offset variabel ${expr.name} ------------------------------`);
    self.blank(1);
    // console.log({meta});
    
    return { box: true, val: meta.offset };
}

module.exports = generateIdentifier;