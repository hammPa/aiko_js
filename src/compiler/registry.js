module.exports = {
  	// menyimpan metadata fungsi deklarasi
  	registerFunction({ name, paramCount = 0, paramNames = [] }) {
  	  	const existing = this.functionNames.find(fn => fn.name === name);
  	  	if (existing) {
  	  		// You can decide to allow redeclare or not
  	  		throw new Error(`Function "${name}" already defined`);
  	  	}
  	  	this.functionNames.push({ name, paramCount, paramNames });
  	},

  	// memvalidasi funtion call
  	resolveFunction(name) {
  		return this.functionNames.find(fn => fn.name === name) || null;
  	}
}