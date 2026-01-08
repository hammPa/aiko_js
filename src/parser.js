const {
    ProgramStmt,
    VarDeclStmt,
    AssignmentStmt,
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
    FunctionCallStmt,
    TypeofStmt,
    InputStmt,
    UnaryOpStmt,
    UseStmt
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
            // console.log({current: this.current});
            
            statements.push(this.parseStatement());
        }
        return new ProgramStmt(statements);
    }

    getLine(){
        return this.current.line;
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
            const id = new IdentifierStmt(this.current.value, this.getLine());
            this.next_token();

            if(this.match('ASSIGN', '=')){
                const assignStmt = this.parseAssign(id);
                this.expect('SEMICOLON');
                return assignStmt;
            }
            // console.log("woi malas: ", id);
            
    
            if(this.match('LPAREN')) {
                const call = this.parseFunctionCall(id);
                this.expect('SEMICOLON');
                return call;
            }
    
            throw new Error(`Unexpected identifier usage: ${id.name}`);
        }
        if(this.current.type === 'USE') return this.parseUse();
        throw new Error(`Unexpected token: ${this.current.type} ${this.current.value}`);
    }




    parseVarDeclStmt(){
        const line = this.getLine();

        const name = this.expect('IDENTIFIER').value; // mengambil nilai nama variabel dari token
        let value = new LiteralStmt(0, this.getLine());

        if(this.match('ASSIGN', '=')){
            value = this.parseExpression();
        }
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
        return new VarDeclStmt(name, value, line);
    }


    parseAssign(variable){
        const line = variable.line;
        const initializer = this.parseExpression();
        return new AssignmentStmt(variable, initializer, line);
    }

    parsePrintStmt(){
        const line = this.getLine();
        this.expect('LPAREN');
        const expr = this.parseExpression();
        this.expect('RPAREN');
        this.expect('SEMICOLON');
        return new PrintStmt(expr, line);
    }

    parseIfStmt(){
        const line = this.getLine();

        const condition = this.parseExpressionUntil('LBRACE');
        const thenBlock = this.parseBlock();
        const elifs = [];
        let elseBlock = null;
        
        while(this.match('ELIF')){
            const elifCondition = this.parseExpressionUntil('LBRACE');
            const elifBody = this.parseBlock();
            elifs.push(new ElifStmt(elifCondition, elifBody, this.getLine()));
        }
        
        if(this.match('ELSE')){
            elseBlock = this.parseBlock();
        }

        return new IfStmt(condition, thenBlock, elifs, elseBlock, line);
    }

    parseForStmt(){
        const line = this.getLine();

        const name = this.expect('IDENTIFIER').value;
        this.expect('ASSIGN', '=');
        
        const startExpr = this.parseExpression();
        this.expect('RANGE', '..');
        
        const endExpr = this.parseExpression();
        
        let step = null;
        if(this.match('COMMA')){
            step = this.parseExpression();
        }
        
        if (!startExpr || !endExpr) {
            throw new Error("Invalid for-range expression");
        }
        
        const bodyLine = this.tokens[this.position - 1].line;
        const body = this.parseBlock();
        
        return new ForStmt(
            new VarDeclStmt(name, startExpr, bodyLine),
            endExpr,
            step,
            body,
            line
        );
    }

    parseReturnStmt(){
        const line = this.tokens[this.position - 1].line;
        // return; <-- tanpa nilai
        if (this.current.type === 'SEMICOLON') {
            this.expect('SEMICOLON');
            return new ReturnStmt(null, this.getLine());
        }

        // return <expression>;
        const value = this.parseExpression(); // misal return 1 + 2;
        this.expect('SEMICOLON');
        return new ReturnStmt(value, line);
    }

    parseParamStmt(){
        const token = this.expect('IDENTIFIER'); // mengambil nilai nama variabel dari token
        return new IdentifierStmt(token.value, token.line); // karna sebaris jdi langsung getline
    }

    parseFunctionDeclStmt(){
        const line = this.getLine();

        const name = this.expect('IDENTIFIER').value;
        this.expect('LPAREN');
        const params = [];
        if(this.current.type === 'IDENTIFIER'){
            params.push(this.parseParamStmt());
            while(this.match('COMMA')){
                params.push(this.parseParamStmt());
            }
        }
        
        this.expect('RPAREN');
        const body = this.parseBlock();
        // console.log("body: ", body);
        
        return new FunctionDeclStmt(name, params, body, line);
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
        return new FunctionCallStmt(callee, args, this.getLine());
    }

    parseUse(){
        const line = this.getLine();
        this.expect('USE');
        const module = [];

        module.push(this.expect('IDENTIFIER').value);
        while(this.match('DOT')){
            module.push(this.expect('IDENTIFIER').value);
        }

        let alias = null;
        if(this.match('AS')){
            alias = this.expect('IDENTIFIER').value;
        }

        return new UseStmt(module, alias, line);
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
            const opToken = this.tokens[this.position - 1];
            const right = this.parseComparison();
            left = new BinaryOpStmt(left, opToken.value, right, opToken.line);
        }
        return left;
    }

    parseComparison(){
        let left = this.parseTerm();
        while(this.match('COMPARISON')){
            const opToken = this.tokens[this.position - 1];
            const right = this.parseTerm();
            left = new BinaryOpStmt(left, opToken.value, right, opToken.line);
        }
        return left;
    }

    parseTerm(){
        let left = this.parseFactor();
        while(this.match('OPERATOR', '+') || this.match('OPERATOR', '-')){
            const opToken = this.tokens[this.position - 1];
            const right = this.parseFactor();
            left = new BinaryOpStmt(left, opToken.value, right, opToken.line);
        }
        return left;
    }

    parseFactor(){
        let left = this.parseUnary();
        while(this.match('OPERATOR', '*') || this.match('OPERATOR', '/') || this.match('OPERATOR', '%')){
            const opToken = this.tokens[this.position - 1];
            const right = this.parseUnary();
            left = new BinaryOpStmt(left, opToken.value, right, opToken.line);
        }
        return left;
    }

    // untuk -, !
    parseUnary(){
        while(this.match('OPERATOR', '-') || this.match('OPERATOR', '!')){
            const opToken = this.tokens[this.position - 1];
            const operand = this.parseUnary();
            return new UnaryOpStmt(opToken.value, operand, opToken.line);
        }
        return this.parsePrimary();
    }

    parsePrimary(){ // pokoknya ini untuk statement tanpa apapun , misal tanpa assignment, dll
        if(this.current.type === 'INT' || this.current.type === 'FLOAT' || this.current.type === 'STRING' || this.current.type === 'BOOLEAN'){
            const value = this.current.value;
            this.next_token();
            return new LiteralStmt(value, this.getLine());
        }

        // cek input
        if(this.current.type === 'INPUT'){
            this.next_token();
            this.expect('LPAREN');
            this.expect('RPAREN');
            return new InputStmt(this.getLine());
        }

        // cek typeof
        if(this.current.type === 'TYPEOF'){
            // const value = this.current.value;
            this.next_token();
            const expr = this.parseUnary(); // cek identifier atau literal
            return new TypeofStmt(expr, this.getLine());
        }

        // cek variabel
        if(this.current.type === 'IDENTIFIER'){
            const ID = new IdentifierStmt(this.current.value, this.getLine());
            this.next_token();

            // cek kalau pemanggilan fungsi
            if(this.match('LPAREN')){
                return this.parseFunctionCall(ID);
            }

            // cek array
            if(this.match('LBRACKET')){
                const index = this.parseExpression();
                this.expect('RBRACKET');
                return new ArrayAccessStmt(ID, index, this.getLine());
            }
            return ID;
        }

        // cek array
        if(this.match('LBRACKET')){
            const line = this.tokens[this.position - 1].line;
            const elements = [];

            if(this.current.type !== 'RBRACKET'){
                elements.push(this.parseExpression()); // ini nanti sampai ke parsePrimary
                while(this.match('COMMA')){
                    elements.push(this.parseExpression());
                }
            }

            this.expect('RBRACKET');
            return new ArrayLiteralStmt(elements, line);
        }

        // cek (expr)
        if(this.match('LPAREN')){
            const expr = this.parseExpression();
            this.expect('RPAREN');
            return expr;
        }
        console.log(this.current)
        throw new Error(`Unexpected token in expression: ${this.current.type}`);
    }
};

module.exports = Parser;