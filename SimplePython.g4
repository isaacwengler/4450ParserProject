grammar SimplePython;

tokens { INDENT, UNINDENT }

@lexer::header {
  import com.yuvalshavit.antlr4.DenterHelper;
}

@lexer::members {
  private final DenterHelper denter = new DenterHelper(NEWLINE,
                                                       SimplePythonParser.INDENT,
                                                       SimplePythonParser.UNINDENT)
  {
    @Override
    public Token pullToken() {
      return SimplePythonLexer.super.nextToken();
    }
  };

  @Override
  public Token nextToken() {
    return denter.nextToken();
  }
}

startRule: block EOF;

block
: (if_statement | assignment | for_loop | while_loop | comment_line)+
;

blockInLoop
: (if_statement_in_loop | assignment | for_loop | while_loop | break_statment | continue_statement | comment_line)+
;

comment_line: COMMENT NEWLINE;

indentedBlock
 : INDENT block UNINDENT
;

indentedBlockInLoop
 : INDENT blockInLoop UNINDENT
;

assignment: VAR SPACE* ASSIGNMENT_OP SPACE* expression SPACE* COMMENT? NEWLINE;

expression
:
	expression SPACE* ARITHMETIC_OP SPACE* expression
	| expression SPACE+ LOGIC_OP SPACE+ expression
	| primitive
	| VAR
	| list
	| tuple
	| OPAR SPACE* expression SPACE* CPAR
	| NOT SPACE+ expression
	| expression SPACE* CONDITIONAL_OP SPACE* expression
;

list
: '[' (SPACE* expression SPACE* COMMA)* (SPACE* expression SPACE*)? ']'
;

tuple
: '(' (SPACE* expression SPACE* COMMA)* (SPACE* expression SPACE*)? ')'
;

// TODO: add function (because return value)
iterable
: list | tuple | STRING | VAR
;

if_statement
 : IF SPACE+ condition_block (ELIF SPACE+ condition_block)* ( ELSE SPACE* COLON SPACE* COMMENT? indentedBlock)?
 ;

if_statement_in_loop
 : IF SPACE+ condition_block_in_loop (ELIF SPACE+ condition_block_in_loop)* ( ELSE SPACE* COLON SPACE* COMMENT? indentedBlockInLoop)?
 ;

while_loop
 : WHILE SPACE+ condition_block_in_loop
 ;

for_loop
 : FOR SPACE+ VAR SPACE+ IN SPACE+ iterable SPACE* COLON SPACE* COMMENT? indentedBlockInLoop
 ;

condition_block
 : expression SPACE* COLON SPACE* COMMENT? indentedBlock 
 ;

condition_block_in_loop
 : expression SPACE* COLON SPACE* COMMENT? indentedBlockInLoop 
 ;

break_statment
 : BREAK SPACE* COMMENT? NEWLINE
 ;

continue_statement
 : CONTINUE SPACE* COMMENT? NEWLINE
 ;

primitive: BOOL | NUMBER | STRING | NONE;

/*
 * TOKENS DEFINED HERE
 */

// Windows uses \r\n for newline
NEWLINE: (' '* '\r'? '\n' ' '*);
SPACE: ' ';
// whitespace to start a line can be tabs or 4 spaces
OPENTAB: '    ' | '\t';

// we do not care about comments for our ASTs, so skip these
COMMENT: '#' ~('\r' | '\n')* -> skip;

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
WHILE: 'while';
FOR: 'for';
IN: 'in';
BREAK: 'break';
CONTINUE: 'continue';
COLON: ':';

// this has to be under other identifiers so they can take effect 
// Variable starts with letter or underscore with n letters, numbers, and underscores after
VAR: [A-Za-z_] [A-Za-z0-9_]*;