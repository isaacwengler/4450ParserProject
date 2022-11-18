grammar SimplePython;

startRule: statement EOF;

statement
: assignment
| if_statement
;

assignment: VAR SPACE* ASSIGNMENT_OP SPACE* expression;

expression
:
	expression SPACE* ARITHMETIC_OP SPACE* expression
	| VAR
	| primative
	| OPAR SPACE* expression SPACE* CPAR
	| expression op=(LTEQ | GTEQ | LT | GT) expression
	| expression op=(EQ | NEQ) expression
	| expression AND expression
	| expression OR expression
;

parse: block EOF;

block: statement*;

if_statement
 : IF condition_block (ELSE IF condition_block)* (ELSE statement_block)?
 ;

condition_block
 : expression COLON statement_block
 ;

statement_block
 : OTAB block
 | statement
 ;

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

NUMBER: INT | FLOAT;
INT: '0' | [1-9][0-9]*;
FLOAT: INT '.' [0-9]+;
primative: BOOL | NUMBER | STRING;

ARITHMETIC_OP: '+' | '-' | '*' | '/' | '%' | '//' | '**';
ASSIGNMENT_OP: ARITHMETIC_OP? '=';

IF: 'if';
ELSE: 'else';

OPAR: '(';
CPAR: ')';
OTAB: '	';
COLON: ':';

GT: '>';
LT: '<';
GTEQ: '>=';
LTEQ: '<=';
EQ: '==';
NEQ: '!=';
AND: 'and';
OR: 'or';
NOT: 'not';