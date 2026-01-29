class Core {
    constructor(tokens){
        this.tokens = tokens;
        this.position = 0;
        this.current = this.tokens[this.position];
    }

    next_token(){
        this.position++;
        this.current = this.tokens[this.position];
    }
    
    getLine(){
        return this.current ? this.current.line : 0;
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

    expect(type, value){
        const token = this.match(type, value);
        if(!token) throw new Error(`Expected token ${type} ${value ?? ''}, but got ${this.current.type} ${this.current.value}`);
        return token;
    }
};

module.exports = Core;