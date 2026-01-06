const { IdentifierStmt } = require('../../helper/ast_tree');

function handleFor(self, stmt) {
    const { iterator, endExpr, step, block } = stmt;
    const stepValue = step ? step.value : 1;

    const forId = self.forCounter++;
    const checkLabel = `for_${forId}_check`;
    const bodyLabel = `for_${forId}_body`;
    const endLabel = `for_${forId}_end`;
    const counter = iterator.initializer.value < endExpr.value ? stepValue : -stepValue;
    const jump = counter >= 0 ? 'jge' : 'jle';

    self.emit(`${checkLabel}:`);
    self.enterScope();
    self.generateStatement(iterator);
    
    self.emit(`${bodyLabel}:`);

    self.generateExpression(endExpr, 'condition');
    const variable = self.generateExpression(new IdentifierStmt(iterator.name));
    
    self.emit(`cmp [eax], ecx`);
    self.emit(`${jump} ${endLabel}`);

    for(const s of block){
        self.generateStatement(s);
    }

    self.generateExpression(new IdentifierStmt(iterator.name));
    self.emit(`add dword [eax], ${counter}`);
    self.emit(`jmp ${bodyLabel}`);
    self.emit(`${endLabel}:`);

    self.exitScope();
}


module.exports = handleFor;