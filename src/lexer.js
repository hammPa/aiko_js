class Lexer {
    constructor(input){
        this.input = input;
        this.position = 0;
        this.currentChar = this.input[this.position];
    }

    // lanjut ke char berikut, lalu disimpan ke current char
    next_char(){
        this.position++;
        this.currentChar = this.position < this.input.length ? 
            this.input[this.position] : null;
    }

    // melihat karakter tanpa pindah ke posisi selanjutnya
    peek(){ return this.currentChar; }

    skip_whitespace(){
        while (this.currentChar && /\s/.test(this.currentChar)) {
            this.next_char();
        }
    }

    // skip_comment(){
    //     while (this.currentChar && this.currentChar == '#') {
    //         this.next_char();
    //     }
    // }

    // cek angka
    isDigit(char) { return /[0-9]/.test(char); }

    // cek huruf
    isAlpha(char) { return /[a-zA-Z_]/.test(char); }

    // cek angka dan huruf
    isAlphaNumeric(char) { return this.isAlpha(char) || this.isDigit(char) || char === '.'; }





    readNumber(){
        let result = '';
        // selama masih ada karakter dan itu angka
        while(this.currentChar && this.isDigit(this.currentChar)){
            result += this.currentChar;
            this.next_char();
        }
        

        // untuk mendeteksi bilangan berkoma
        if(this.currentChar == '.'){
            result += this.currentChar;
            while(this.currentChar && this.isDigit(this.currentChar)){
                result += this.currentChar;
                this.next_char();
            }

            return { type: 'FLOAT', value: parseFloat(result) };
        }

        return { type: 'INT', value: parseInt(result) };
    }

    readString(){
        const quote = this.currentChar;
        this.next_char();

        let result = '';
        // selama masih alfabet
        while(this.currentChar && this.currentChar !== quote){
            result += this.currentChar;
            this.next_char();
            // belum ada escape sequence
        }


        if(this.currentChar === quote){
            this.next_char();
            return { type: 'STRING', value: result };
        }
        else {
            throw new Error("'Unterminated String Literal");
        }
    }

    readIdentifier(){
        let result = '';
        while (this.currentChar && this.isAlphaNumeric(this.currentChar)) {
            if (this.currentChar === '.' && this.position + 1 < this.input.length && this.input[this.position + 1] === '.') {
                result += "..";
                this.next_char(); // Consume first '.'
                this.next_char(); // Consume second '.'
            } else {
                result += this.currentChar;
                this.next_char();
            }
        }


        const keywords = {
            'var': 'VAR',
            'print': 'PRINT',
            'if': 'IF',
            'elif': 'ELIF',
            'else': 'ELSE',
            'for': 'FOR',
            'fun': 'FUN',
            'return': 'RETURN',
            'true': 'TRUE',
            'false': 'FALSE',
            '..': 'RANGE'
            // 'while': 'WHILE',
        };

        return keywords[result] ? 
            { type: keywords[result], value: result } :
            { type: "IDENTIFIER", value: result }
    }


    get_next_token(){
        // selama masih membaca karakter
        while(this.peek()) {
            // skip whitespace
            if(/\s/.test(this.currentChar)){
                this.skip_whitespace();
                continue;
            }

            // Handle negative numbers
            if(this.currentChar === '-' && this.isDigit(this.input[this.position + 1])) {
                this.next_char(); // consume the '-'
                const numberToken = this.readNumber();
                numberToken.value = -numberToken.value;
                return numberToken;
            }

            // handle string
            if(this.currentChar === '"' || this.currentChar === "'"){
                return this.readString();
            }

            // handle angka
            if(this.isDigit(this.currentChar)){
                return this.readNumber();
            }

            // handle identifier
            if(this.isAlpha(this.currentChar) || this.currentChar === '.'){
                return this.readIdentifier();
            }

            // handle operators
            if(['+', '-', '*', '/', '%'].includes(this.currentChar)){
                const op = this.currentChar;
                this.next_char();
                return { type: 'OPERATOR', value: op };
            }

            // Handle comparisons and assignment
            if (['>', '<', '=', '!'].includes(this.currentChar)) {
                const op = this.currentChar;
                this.next_char();
                if (this.currentChar === '=') {
                    const combinedOp = op + '=';
                    this.next_char();
                    return { type: 'COMPARISON', value: combinedOp }; // ==, >=, etc.
                }
                if (op === '=') {
                    return { type: 'ASSIGN', value: op }; // single =
                }
                // ✔️ Semua simbol >, <, ! (tanpa =) dianggap pembanding
                return { type: 'COMPARISON', value: op };
            }

            // Handle single-character tokens
            const singleCharTokens = {
                ';': 'SEMICOLON',
                '(': 'LPAREN',
                ')': 'RPAREN',
                '{': 'LBRACE',
                '}': 'RBRACE',
                ',': 'COMMA',
                ':': 'COLON',
                '[': 'LBRACKET',
                ']': 'RBRACKET'
            };

            if (singleCharTokens[this.currentChar]) {
                const type = singleCharTokens[this.currentChar];
                const value = this.currentChar;
                this.next_char();
                return { type, value };
            }

            throw new Error(`Unknown character: ${this.currentChar} at position ${this.position}`);
        }

        return { type: 'EOF', value: null };
    }

    tokenize(){
        const tokens = [];
        let token = this.get_next_token();
        while(token.type != 'EOF'){
            tokens.push(token);
            token = this.get_next_token();
        }
        tokens.push(token);
        return tokens;
    }
};

module.exports = Lexer;