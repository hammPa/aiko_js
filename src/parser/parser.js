const Core = require('./core');
const statementMethods = require('./statements');
const expressionMethods = require('./expressions');

class Parser extends Core {
    
};

Object.assign(Parser.prototype, statementMethods);
Object.assign(Parser.prototype, expressionMethods);

module.exports = Parser;