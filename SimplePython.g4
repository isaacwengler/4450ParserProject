grammar SimplePython;

// The following code for INDENT and UNINDENT tokens
// was made with assistance from the README of
// of Antlr Denter Helper,
// an open source project to help handle indentation
// Link: https://github.com/yshavit/antlr-denter

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

// end of code made with assistance from antlr denter helper

startRule: block EOF;

block
: 
  (create_function 
    | statement 
    | if_statement 
    | for_loop 
    | while_loop)+
;

blockInLoop
: 
    (statement
      | if_statement_in_loop
      | for_loop 
      | while_loop 
      | statement_in_loop)+
;

blockInFunction
: 
  (create_function 
    | statement
    | return_statment
    | if_statement_in_function
    | for_loop_in_function 
    | while_loop_in_function)+
;

blockInFunctionAndLoop
: 
  (statement
    | return_statment
    | if_statement_in_function_and_loop
    | for_loop_in_function 
    | while_loop_in_function 
    | statement_in_loop)+
;

statement:
  call_function_statment
  | assignment
  | comment_line
;

statement_in_loop:
  break_statment
  | continue_statement
;

comment_line: COMMENT NEWLINE;

// different blocks are required, because when a statement makes a new scope, it
// can use different statments.
// Like only inside a function there can be a return, and a loop can be a break.
// This is necessary so, for example, an if statment inside a function can return.

indentedBlock
 : INDENT block UNINDENT
;

indentedBlockInLoop
 : INDENT blockInLoop UNINDENT
;

indentedBlockInFunction
 : INDENT blockInFunction UNINDENT
;

indentedBlockInFunctionAndLoop
 : INDENT blockInFunctionAndLoop UNINDENT
;

assignment: (VAR | list_index) SPACE* ASSIGNMENT_OP SPACE* expression SPACE* COMMENT? NEWLINE;

expression
:
	expression SPACE* ARITHMETIC_OP SPACE* expression
	| expression SPACE+ LOGIC_OP SPACE+ expression
  | call_function
  | call_function_on_object
	| primitive
	| VAR
  | list_index
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

list_index
: VAR ('[' expression ']')+
;

iterable
: list | tuple | call_function | STRING | VAR
;

//function implementation
create_function
 : DEF SPACE+ VAR SPACE* '(' SPACE* parameters? SPACE* ')' SPACE* COLON SPACE* COMMENT? indentedBlockInFunction
 ;
parameters: VAR ( SPACE* ',' SPACE* VAR )*;

// for when a function call is on its own line
call_function_statment: (call_function | call_function_on_object) SPACE* COMMENT? NEWLINE;
// call function
call_function: VAR '(' SPACE* arguments? SPACE* ')';
arguments: expression ( SPACE* ',' SPACE* expression )*;

return_statment: RETURN SPACE+ expression SPACE* COMMENT? NEWLINE;

call_function_on_object:
  (STRING | VAR | list | tuple) '.' call_function
;

if_statement
 : IF SPACE+ condition_block (ELIF SPACE+ condition_block)* ( ELSE SPACE* COLON SPACE* COMMENT? indentedBlock)?
 ;

if_statement_in_loop
 : IF SPACE+ condition_block_in_loop (ELIF SPACE+ condition_block_in_loop)* ( ELSE SPACE* COLON SPACE* COMMENT? indentedBlockInLoop)?
 ;

if_statement_in_function
 : IF SPACE+ condition_block_in_function (ELIF SPACE+ condition_block_in_function)* ( ELSE SPACE* COLON SPACE* COMMENT? indentedBlockInFunction)?
 ;

if_statement_in_function_and_loop
 : IF SPACE+ condition_block_in_function_and_loop (ELIF SPACE+ condition_block_in_function_and_loop)* ( ELSE SPACE* COLON SPACE* COMMENT? indentedBlockInFunctionAndLoop)?
 ;

while_loop
 : WHILE SPACE+ condition_block_in_loop
 ;

while_loop_in_function
 : WHILE SPACE+ condition_block_in_function_and_loop
 ;

for_loop
 : FOR SPACE+ VAR SPACE+ IN SPACE+ iterable SPACE* COLON SPACE* COMMENT? indentedBlockInLoop
 ;

for_loop_in_function
 : FOR SPACE+ VAR SPACE+ IN SPACE+ iterable SPACE* COLON SPACE* COMMENT? indentedBlockInFunctionAndLoop
 ;

condition_block
 : expression SPACE* COLON SPACE* COMMENT? indentedBlock 
 ;

condition_block_in_loop
 : expression SPACE* COLON SPACE* COMMENT? indentedBlockInLoop 
 ;

condition_block_in_function
 : expression SPACE* COLON SPACE* COMMENT? indentedBlockInFunction 
 ;

condition_block_in_function_and_loop
 : expression SPACE* COLON SPACE* COMMENT? indentedBlockInFunctionAndLoop 
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
INT: '0' | '-'? [1-9][0-9]*;
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
DEF: 'def';
RETURN: 'return';

// this has to be under other identifiers so they can take effect 
// Variable starts with letter or underscore with n letters, numbers, and underscores after
VAR: [A-Za-z_] [A-Za-z0-9_]*;
