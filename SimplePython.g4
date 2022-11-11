grammar SimplePython;

startRule: expression EOF;

expression: VAR SPACE arithmatic NEWLINE;

/*
 * TOKENS DEFINED HERE
 */

// Variable starts with letter or underscore with n letters, numbers, and underscores after
VAR: [A-Za-z_] [A-Za-z0-9_]*;

// Windows uses \r\n for newline
NEWLINE: '\n' | '\r\n';

SPACE: ' ';

SPACES: SPACE+;

STRING: '\'' ASCII '\'' | '"' ASCII '"';

ASCII: [ -~];

ARITHMETIC_OP: '+' | '-' | '*' | '/' | '%' | '//' | '**';

ASSIGNMENT_OP: ARITHMETIC_OP? '=';

arithmatic: (NUMBER | VAR) SPACES? ARITHMETIC_OP SPACES? (
		NUMBER
		| VAR
	);

assignment: VAR SPACES? ASSIGNMENT_OP SPACES? (VAR | NUMBER);

NUMBER: ('0' .. '9')+ ('.' ('0' .. '9')+)?;

