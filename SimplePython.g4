grammar SimplePython;

startRule: expression EOF;

statement: ((assignment | expression) NEWLINE)*;

assignment: VAR SPACES? ASSIGNMENT_OP SPACES? expression;

expression:
	expression SPACES? ARITHMETIC_OP SPACES? expression
	| VAR
	| NUMBER
	| STRING;

/*
 * TOKENS DEFINED HERE
 */

// Variable starts with letter or underscore with n letters, numbers, and underscores after
VAR: [A-Za-z_] [A-Za-z0-9_]*;

// Windows uses \r\n for newline
NEWLINE: '\n' | '\r\n';

SPACE: [ ];

SPACES: SPACE+;

STRING: '\'' ASCII '\'' | '"' ASCII '"';

ASCII: [ -~];

ARITHMETIC_OP: '+' | '-' | '*' | '/' | '%' | '//' | '**';

ASSIGNMENT_OP: ARITHMETIC_OP? '=';

NUMBER: ('0' .. '9')+ ('.' ('0' .. '9')+)?;

IF: 'if';

ELSE: 'else';

OBRACE: '{';

CBRASE: '}';

OPAR: '(';

CPAR: ')';

GT: '>';

LT: '<';

GTEQ: '>=';

LTEQ: '<=';

EQ: '==';

NEQ: '!=';

AND: '&&';

OR: '||';

NOT: '!';

