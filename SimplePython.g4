grammar SimplePython;

startRule: block EOF;

block
: (OPENTAB* (if_statement|assignment|NEWLINE))+
;

assignment: VAR SPACE* ASSIGNMENT_OP SPACE* expression NEWLINE;

expression
:
	expression SPACE* (ARITHMETIC_OP | LOGIC_OP) SPACE* expression
	| primitive
	| VAR
	| list
	| tuple
	| OPAR SPACE* expression SPACE* CPAR
	| NOT SPACE* expression
	| expression SPACE* CONDITIONAL_OP SPACE* expression
;

list
: '[' (SPACE* expression SPACE* COMMA)* (SPACE* expression SPACE*)? ']'
;

tuple
: '(' (SPACE* expression SPACE* COMMA)* (SPACE* expression SPACE*)? ')'
;

if_statement
 : IF SPACE* condition_block (OPENTAB* ELIF SPACE* condition_block)* (OPENTAB* ELSE SPACE* COLON SPACE* NEWLINE block)?
 ;

condition_block
 : expression SPACE* COLON SPACE* NEWLINE block 
 ;

primitive: BOOL | NUMBER | STRING | NONE;

/*
 * TOKENS DEFINED HERE
 */

// Windows uses \r\n for newline
NEWLINE: '\n' | '\r\n';
SPACE: ' ';
// whitespace to start a line can be tabs or 4 spaces
OPENTAB: '    ' | '\t';


STRING:
	'\'' ('\\\'' | '\\' | ~('\'' | '\\' | '\n' | '\r'))*? '\''
	| '"' ('\\"' | '\\' | ~('\'' | '\\' | '\n' | '\r'))*? '"';

BOOL: 'True' | 'False';
NUMBER: INT | FLOAT;
INT: '0' | [1-9][0-9]*;
FLOAT: INT '.' [0-9]+;
NONE: 'None';

ARITHMETIC_OP: '+' | '-' | '*' | '/' | '%' | '//' | '**';
ASSIGNMENT_OP: ARITHMETIC_OP? '=';
CONDITIONAL_OP: '>' | '<' | '>=' | '<=' | '==' | '!=';
LOGIC_OP: 'and' | 'or';
NOT: 'not';
OPAR: '(';
CPAR: ')';
OBRA: '[';
CBRA: ']';
COMMA: ',';

IF: 'if';
ELIF: 'elif';
ELSE: 'else';
COLON: ':';

// this has to be under other identifiers so they can take effect 
// Variable starts with letter or underscore with n letters, numbers, and underscores after
VAR: [A-Za-z_] [A-Za-z0-9_]*;