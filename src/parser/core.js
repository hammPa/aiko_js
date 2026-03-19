class Core {
    constructor(tokens, reporter){
        this.tokens = tokens;
        this.reporter = reporter;
        this.position = 0;
        this.current = this.tokens[this.position] || { type: 'EOF', value: null, line: 0 };
    }

    next_token(){
        this.position++;
        this.current = this.tokens[this.position] || { type: 'EOF', value: null, line: this.current.line };
    }
    
    getLine(){
        return this.current ? this.current.line : 0;
    }

    error(message) {
        const line = this.current ? this.current.line : 0;
        this.reporter.report("PARSER", message, line);
    }

    // cek token, jika cocok maka kembalikan untuk di cek di expect
    match(type, value = null){
        // jika sesuai dengan type dan value
        if(this.current.type === type
            && (value === null || this.current.value === value)){
                const token = this.current;
                this.next_token();
                return token;
        }
        return null;
    }

    expect(type, value) {
        const token = this.match(type, value);
        if (!token) {
            // Ambil token terakhir yang sukses diproses
            const lastToken = this.tokens[this.position - 1];
            
            // Gunakan baris dari lastToken sebagai lokasi error yang lebih akurat
            const errorLine = lastToken ? lastToken.line : this.getLine();

            this.reporter.report(
                "PARSER", 
                `Mengharapkan '${type}${value ? ` ${value}` : ''}' setelah '${lastToken ? (lastToken.value || lastToken.type) : 'ekspresi'}', tapi menemukan '${this.current.type}'`, 
                errorLine 
            );

            // RECOVERY: Kembalikan objek dummy agar parseVarDeclStmt tidak crash saat akses .line
            return { type: type, value: "ERROR_RECOVERY", line: errorLine };
        }
        return token;
    }
};

module.exports = Core;