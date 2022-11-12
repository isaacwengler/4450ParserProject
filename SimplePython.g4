grammar SimplePython;

startRule: statement EOF;

statement: ((assignment | expression) NEWLINE)*;

assignment: VAR SPACE* arith SPACE* expression;

expression:
	expression SPACE* ARITHMETIC_OP SPACE* expression
	| VAR
	| primative
	| OPAR SPACE* expression SPACE* CPAR;

/*
 * TOKENS DEFINED HERE
 */

// Variable starts with letter or underscore with n letters, numbers, and underscores after
VAR: [A-Za-z_] [A-Za-z0-9_]*;

// Windows uses \r\n for newline
NEWLINE: '\n' | '\r\n';

SPACE: ' ';

STRING:
	'\'' ('\\\'' | '\\' | ~('\'' | '\\' | '\n' | '\r'))*? '\''
	| '"' ('\\"' | '\\' | ~('\'' | '\\' | '\n' | '\r'))*? '"';

TRUE: 'True';

FALSE: 'False';

BOOL: TRUE | FALSE;

number: INT | FLOAT;

INT: '0' | [1-9][0-9]*;

FLOAT: INT '.' [0-9]+;

primative: BOOL | number | STRING;

ARITHMETIC_OP: '+' | '-' | '*' | '/' | '%' | '//' | '**';

arith: ARITHMETIC_OP? '=' | '=';

IF: 'if';

ELSE: 'else';

OPAR: '(';

CPAR: ')';

GT: '>';

LT: '<';

GTEQ: '>=';

LTEQ: '<=';

EQ: '==';

NEQ: '!=';

AND: 'and';

OR: 'or';

NOT: 'not';

