function handleContinue(self, stmt){
  	self.emit(`; ------------------------------ Start Continue ------------------------------`);// Cek apakah kita sedang di dalam loop
  	if (self.loopStack.length === 0) {
  	    self.reportError("'continue' digunakan di luar loop.", stmt);
		return;
	}
  
  	const currentLoopCont = self.loopStack[self.loopStack.length - 1];
  
  	self.emit(`; --- Continue ---`);
  	self.emit(`jmp ${currentLoopCont.continueLabel}`);
	self.emit(`; ------------------------------ End Continue ------------------------------`);// Cek apakah kita sedang di dalam loop
}

module.exports = handleContinue;