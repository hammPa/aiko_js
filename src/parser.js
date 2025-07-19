const {
    ProgramStmt,
    VarDeclStmt,
    PrintStmt,
    IfStmt,
    ElifStmt,
    ForStmt,
    ArrayLiteralStmt,
    ArrayAccessStmt,
    FunctionDeclStmt,
    ReturnStmt,
    BinaryOpStmt,
    LiteralStmt,
    IdentifierStmt,
    FunctionCallStmt
} = require ('../helper/ast_tree.js');

class Parser {
    constructor(tokens){
        this.tokens = tokens;
        this.position = 0;
        this.current = this.tokens[this.position];
    }

    next_token(){
        this.position++;
        this.current = this.tokens[this.position];
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


    parse(){
        const statements = [];
        while(this.current.type !== 'EOF'){
            // console.log(this.current);
            
            statements.push(this.parseStatement());
        }
        return new ProgramStmt(statements);
    }

    parseStatement(){
        // match sudah memanggil next token, jadi akan langsung ke identifier, atua apapun itu setelah keywords
        if(this.match('VAR')) return this.parseVarDeclStmt();
        if(this.match('PRINT')) return this.parsePrintStmt();
        if(this.match('IF')) return this.parseIfStmt();
        if(this.match('FOR')) return this.parseForStmt();
        if(this.match('RETURN')) return this.parseReturnStmt();
        if(this.match('FUN')) return this.parseFunctionDeclStmt();
        if(this.current.type === 'IDENTIFIER'){
            const id = new IdentifierStmt(this.current.value);
            this.next_token();
    
            if(this.match('LPAREN')) {
                const call = this.parseFunctionCall(id);
                this.expect('SEMICOLON');
                return call;
            }
    
            throw new Error(`Unexpected identifier usage: ${id.name}`);
        }
        throw new Error(`Unexpected token: ${this.current.type} ${this.current.value}`);
    }




    parseVarDeclStmt(){
        const name = this.expect('IDENTIFIER').value; // mengambil nilai nama variabel dari token
        this.expect('ASSIGN', '=');
        const value = this.parseExpression();
        /*
        berurutan mengecek dari:
        - equality : ==, !=
        - comparison : <, >, <=, >=
        - term : +, -
        - factor : *, /
        - unary : -, ! (prefix)
        - primary : angka, variabel, literal **** INI TERKUAT  ****
        */
        this.expect('SEMICOLON', ';');
        return new VarDeclStmt(name, value);
    }

    parsePrintStmt(){
        this.expect('LPAREN');
        const expr = this.parseExpression();
        this.expect('RPAREN');
        this.expect('SEMICOLON');
        return new PrintStmt(expr);
    }

    parseIfStmt(){
        const condition = this.parseExpressionUntil('LBRACE');
        const thenBlock = this.parseBlock();
        const elifs = [];
        let elseBlock = null;
        
        while(this.match('ELIF')){
            const elifCondition = this.parseExpressionUntil('LBRACE');
            const elifBody = this.parseBlock();
            elifs.push(new ElifStmt(elifCondition, elifBody));
        }
        
        if(this.match('ELSE')){
            elseBlock = this.parseBlock();
        }

        return new IfStmt(condition, thenBlock, elifs, elseBlock);
    }

    parseForStmt(){
        const iterator = this.expect('IDENTIFIER').value;
        this.expect('ASSIGN', '=');
        const start = this.parseExpression();
        this.expect('RANGE', '..');
        const end = this.parseExpressionUntil('LBRACE');
        const body = this.parseBlock();

        let step = 1;
        // Coba evaluasi nilai jika berupa literal
        try {
            const startVal = parseInt(start.value);
            const endVal = parseInt(end.value);
            // console.log(startVal, " ", endVal)
            if(startVal > endVal) step = -1;
        } catch(e) {
            // Jika tidak bisa dievaluasi, gunakan step default
            step = 1;
        }
        
        return new ForStmt(iterator, start, end, step, body);
    }

    parseReturnStmt(){
        // return; <-- tanpa nilai
        if (this.current.type === 'SEMICOLON') {
            this.expect('SEMICOLON');
            return new ReturnStmt(null);
        }

        // return <expression>;
        const value = this.parseExpression(); // misal return 1 + 2;
        this.expect('SEMICOLON');
        return new ReturnStmt(value);
    }

    parseFunctionDeclStmt(){
        const name = this.expect('IDENTIFIER').value;
        this.expect('LPAREN');
        const params = [];
        if(this.current.type === 'IDENTIFIER'){
            params.push(this.expect('IDENTIFIER').value);
            while(this.match('COMMA')){
                params.push(this.expect('IDENTIFIER').value);
            }
        }
        
        this.expect('RPAREN');
        const body = this.parseBlock();
        // console.log("body: ", body);
        
        return new FunctionDeclStmt(name, params, body);
    }

    parseFunctionCall(callee){
        const args = [];

        // parse arguments
        if(this.current.type !== 'RPAREN'){
            args.push(this.parseExpression()); // setiap argument diubah jadi parsePrimary melewati parseExpr
            while(this.match('COMMA')){
                args.push(this.parseExpression());
            }
        }

        this.expect('RPAREN');
        return new FunctionCallStmt(callee, args);
    }

    // untuk cek block {}
    parseBlock() {
        this.expect('LBRACE');
        const statements = [];
        while (this.current.type !== 'RBRACE') {
            statements.push(this.parseStatement());
        }
        this.expect('RBRACE');
        return statements;
    }

    // khusus if, for
    parseExpressionUntil(endType) {
        // Salin token sampai ketemu token endType (misal LBRACE)
        const exprTokens = [];
        while (this.current && this.current.type !== endType) {
            exprTokens.push(this.current);
            this.next_token();
        }
        // console.log(exprTokens);
        
        // Tambahkan EOF agar sub-parser bisa berjalan
        const subParser = new Parser(exprTokens.concat({ type: 'EOF', value: null }));

        // PENTING: kita panggil parseExpression() dari sub-parser, bukan parse()
        return subParser.parseExpression();
    }

    parseExpression(){
        return this.parseEquality();
    }

    // untuk urutan kekuatan operator
    // dimulai dari ==, !=
    parseEquality(){
        let left = this.parseComparison();
        while(this.match('COMPARISON', '==') || this.match('COMPARISON', '!=')){
            const op = this.tokens[this.position - 1].value;
            const right = this.parseComparison();
            left = new BinaryOpStmt(left, op, right);
        }
        return left;
    }

    parseComparison(){
        let left = this.parseTerm();
        while(this.match('COMPARISON')){
            const op = this.tokens[this.position - 1].value;
            const right = this.parseTerm();
            left = new BinaryOpStmt(left, op, right);
        }
        return left;
    }

    parseTerm(){
        let left = this.parseFactor();
        while(this.match('OPERATOR', '+') || this.match('-')){
            const op = this.tokens[this.position - 1].value;
            const right = this.parseFactor();
            left = new BinaryOpStmt(left, op, right);
        }
        return left;
    }

    parseFactor(){
        let left = this.parsePrimary();
        while(this.match('OPERATOR', '*') || this.match('OPERATOR', '/')){
            const op = this.tokens[this.position - 1].value;
            const right = this.parsePrimary();
            left = new BinaryOpStmt(left, op, right);
        }
        return left;
    }
    // parseFactor(){
    //     const left = this.parseUnary();
    // }

    // parseUnary(){
    //     const left = this.parsePrimary();
    // }

    parsePrimary(){ // pokoknya ini untuk statement tanpa apapun , misal tanpa assignment, dll
        if(this.current.type === 'INT' || this.current.type === 'FLOAT' || this.current.type === 'STRING' || this.current.type === 'BOOLEAN'){
            const value = this.current.value;
            this.next_token();
            return new LiteralStmt(value);
        }

        // cek variabel
        if(this.current.type === 'IDENTIFIER'){
            const ID = new IdentifierStmt(this.current.value);
            this.next_token();

            // cek kalau pemanggilan fungsi
            if(this.match('LPAREN')){
                return this.parseFunctionCall(ID);
            }

            // cek array
            if(this.match('LBRACKET')){
                const index = this.parseExpression();
                this.expect('RBRACKET');
                return new ArrayAccessStmt(ID, index);
            }
            return ID;
        }

        // cek array
        if(this.match('LBRACKET')){
            const elements = [];

            if(this.current.type !== 'RBRACKET'){
                elements.push(this.parseExpression()); // ini nanti sampai ke parsePrimary
                while(this.match('COMMA')){
                    elements.push(this.parseExpression());
                }
            }

            this.expect('RBRACKET');
            return new ArrayLiteralStmt(elements);
        }

        // cek (expr)
        if(this.match('LPAREN')){
            const expr = this.parseExpression();
            this.expect('RPAREN');
            return expr;
        }
        console.log(this.current.type)
        throw new Error(`Unexpected token in expression: ${this.current.type}`);
    }
};

module.exports = Parser;