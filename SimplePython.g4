grammar SimplePython;

startRule: expression EOF;

expression: 'hello\n';

arithmatic
        : left=NUMBER operator='+' right=NUMBER
        | left=NUMBER operator='-' right=NUMBER
        | left=NUMBER operator='*' right=NUMBER
        | left=NUMBER operator='/' right=NUMBER
        | left=NUMBER operator='%' right=NUMBER
        ;

NUMBER
    : ('0' .. '9') + ('.' ('0' .. '9') +)?
    ;


