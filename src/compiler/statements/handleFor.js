const { IdentifierStmt } = require('../../../helper/ast_tree');
const handleForEach = require('./handleForEach');

function handleFor(self, stmt) {
    const { iterator, endExpr, step, block } = stmt;

    const forId = self.forCounter++;
    const checkLabel   = `for_${forId}_check`;
    const endLabel     = `for_${forId}_end`;
    const updateLabel  = `for_${forId}_update`;
    const noFlipLabel  = `for_${forId}_no_flip`;

    if (endExpr === null) {
        handleForEach({ self, iterator, step, block, forId, checkLabel, endLabel, updateLabel });
        return;
    }

    self.loopStack.push({ breakLabel: endLabel, continueLabel: updateLabel });
    self.enterScope();

    // ─────────────────────────────────────────────
    // 1. Deklarasi variabel iterator (i = start)
    // ─────────────────────────────────────────────
    self.generateStatement(iterator);

    // ─────────────────────────────────────────────
    // 2. Simpan ESI & EDI ke stack (karena nested loop
    //    akan pakai ESI/EDI juga, kita preserve dulu)
    //    ESI = end_value
    //    EDI = step_value
    // ─────────────────────────────────────────────
    self.emit(`push esi    ; preserve ESI (end_value for_${forId})`);
    self.emit(`push edi    ; preserve EDI (step_value for_${forId})`);

    // ─────────────────────────────────────────────
    // 3. Evaluasi END → ESI
    // ─────────────────────────────────────────────
    self.emit(`; --- Evaluasi End Expression ---`);
    if (endExpr.type === 'Literal') {
        self.emit(`mov esi, ${endExpr.value}    ; esi = end`);
    } else {
        const res = self.generateExpression(endExpr, 'condition');
        if (res && res.box) {
            self.emit(`mov esi, [eax]    ; esi = unbox end`);
        } else {
            self.emit(`mov esi, eax`);
        }
    }

    // ─────────────────────────────────────────────
    // 4. Evaluasi STEP → EDI
    // ─────────────────────────────────────────────
    self.emit(`; --- Evaluasi Step Expression ---`);
    if (!step) {
        self.emit(`mov edi, 1    ; default step = 1`);
    } else if (step.type === 'Literal') {
        self.emit(`mov edi, ${step.value}    ; edi = step`);
    } else {
        const res = self.generateExpression(step, 'condition');
        if (res && res.box) {
            self.emit(`mov edi, [eax]    ; edi = unbox step`);
        } else {
            self.emit(`mov edi, eax`);
        }
    }

    // ─────────────────────────────────────────────
    // 5. Runtime Auto-Flip Step
    // ─────────────────────────────────────────────
    self.emit(`; --- Auto-Flip Step Direction ---`);
    self.generateExpression(new IdentifierStmt(iterator.name));
    self.emit(`mov eax, [eax]    ; eax = nilai start`);
    self.emit(`cmp eax, esi`);
    self.emit(`je ${endLabel}    ; start == end, skip`);
    self.emit(`jl ${noFlipLabel} ; start < end, step harus positif`);

    // start > end → pastikan step negatif
    self.emit(`cmp edi, 0`);
    self.emit(`jl ${noFlipLabel} ; step sudah negatif, ok`);
    self.emit(`neg edi           ; flip step ke negatif`);

    self.emit(`${noFlipLabel}:`);

    // ─────────────────────────────────────────────
    // 6. LOOP CHECK
    // ─────────────────────────────────────────────
    self.emit(`; ----- Start Loop For ${forId} -----`);

    // self.emit(`for_${forId}_body:`);
    self.emit(`${checkLabel}:`);
    self.generateExpression(new IdentifierStmt(iterator.name));
    self.emit(`mov eax, [eax]`);
    self.emit(`sub eax, esi    ; counter - end`);
    self.emit(`imul eax, edi   ; * step (negatif = belum selesai)`);
    self.emit(`jge ${endLabel}`);
    self.emit(`for_${forId}_body:`);

    // ─────────────────────────────────────────────
    // 7. BODY
    // ─────────────────────────────────────────────
    self.enterScope();
    for (const s of block) {
        self.generateStatement(s);
    }
    self.exitScope();

    // ─────────────────────────────────────────────
    // 8. UPDATE
    // ─────────────────────────────────────────────
    self.emit(`${updateLabel}:`);
    self.generateExpression(new IdentifierStmt(iterator.name));
    self.emit(`add dword [eax], edi    ; counter += step`);
    self.emit(`jmp ${checkLabel}`);

    // ─────────────────────────────────────────────
    // 9. CLEANUP: restore ESI & EDI
    // ─────────────────────────────────────────────
    self.emit(`${endLabel}:`);
    self.emit(`pop edi    ; restore EDI`);
    self.emit(`pop esi    ; restore ESI`);
    self.emit(`; ----- End Loop For ${forId} -----`);

    self.exitScope();
    self.loopStack.pop();
}

module.exports = handleFor;