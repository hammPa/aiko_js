function handleBreak(self, stmt){
  	self.emit(`; ------------------------------ Start Break ------------------------------`);// Cek apakah kita sedang di dalam loop
  	if (self.loopStack.length === 0) {
  	    throw new Error("Compiler Error: 'break' digunakan di luar loop.");
  	}
	  
  	// Ambil info loop paling baru (paling dalam)
  	const currentLoopBreak = self.loopStack[self.loopStack.length - 1];
	  
  	self.emit(`jmp ${currentLoopBreak.breakLabel}`);
  	self.emit(`; ------------------------------ End Break ------------------------------`);// Cek apakah kita sedang di dalam loop
}

module.exports = handleBreak;