<!-- @format -->

# Python Parser Project

## CS 4450

### Team: JavaScript > Java

Team members:

Ethan Loftis, Isaac Ernst, Isaac Wengler, Kenny Fatoki, Stephen Bowen

## Project Explanation

This project implements a parser for a simplified Python language. This is made using antlr4.

This was completed as a part of CS 4450, Principles of Programming Languages.

This simplified Python language features:
   - Primitive Python types
   - Lists and tuples
   - Variable definitions
   - Arithmetic and assignment operations
   - if/else blocks
   - Conditionals
   - Loops (for and while)
   - Function definitions
   - Function calls

## Requirements to Run
1. Download java 19.0.1
2. Follow Canvas intructions for antlr4 install [here](https://umsystem.instructure.com/courses/113343/files/14509890?module_item_id=5418931)
   - This includes the following aliases: `alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9.2-complete.jar:/usr/local/lib/antlr-denter-1.2.jar:$CLASSPATH" org.antlr.v4.Tool'` and  `alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9.2-complete.jar:/usr/local/lib/antlr-denter-1.2.jar:$CLASSPATH" org.antlr.v4.gui.TestRig`
3. Add `antlr-denter-1.2.jar` to your CLASSPATH. (this file is in this directory)
   - Move `antlr-denter-1.2.jar` to your `/usr/local/lib/` folder
   - Add it to your classpath that you made in the previous step. For example, in my .zshrc file: `export CLASSPATH=".:/usr/local/lib/antlr-4.9.2-complete.jar:/usr/local/lib/antlr-denter-1.2.jar:$CLASSPATH"`

## How to Run
First, complete "Requirements to Run" above.

For standard use with a gui AST displayed, run the following commands in this directory:
```
$ antlr4 SimplePython.g4
$ javac *.java
$ grun SimplePython startRule -gui test_file.py
```

Alternatively, replace `test_file.py` with another file to parse it, or omit `test_file.py` to input on stdin, and enter `control + D` to end the input.

Switch `-gui` to `-tree` to have command line output, instead of gui output.

## Demo Video

This video shows our parser correctly parsing a Python file, and then correctly erroring when parsing a file that has a syntax error. 

https://youtu.be/axTpoLPe8ow
