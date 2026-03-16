module.exports = {
  	// untuk menggantikan push ke text section manual agar tidak hardcode indent
  	emit(line = "") {
  	  	const indent = "    ".repeat(this.indentLevel);
  	  	this.textSection.push(indent + line);
  	  	this.sourceMap.push(this.currentSourceLocation);
  	},

  	blank(n = 1) {
  	    for (let i = 0; i < n; i++) {
  	        this.textSection.push("\n");
  	        this.sourceMap.push(this.currentSourceLocation);
  	    }
  	},

  	// membuat label unik
  	newLabel(prefix = 'L') {
  	  	this.labelCounter += 1;
  	  	return `${prefix}_${this.labelCounter}`;
  	}
};