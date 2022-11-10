import sys
from antlr4 import *
from SimplePythonLexer import SimplePythonLexer
from SimplePythonParser import SimplePythonParser
 
def main(argv):
    input_stream = FileStream(argv[1])
    lexer = SimplePythonLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = SimplePythonParser(stream)
    tree = parser.startRule()
 
if __name__ == '__main__':
    main(sys.argv)