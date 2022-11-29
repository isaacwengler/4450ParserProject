<!-- @format -->

# Python Parser Project

## CS 4450

### Team: JavaScript > Java

Ethan Loftis, Isaac Ernst, Isaac Wengler, Kenny Fatoki, Stephen Bowen

## How to run

1. Have java 19.0.1
2. Follow intructions for antlr4 install [here](https://umsystem.instructure.com/courses/113343/files/14509890?module_item_id=5418931)
   - This includes the following aliases: `alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9.2-complete.jar:/usr/local/lib/antlr-denter-1.2.jar:$CLASSPATH" org.antlr.v4.Tool'` and  `alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9.2-complete.jar:/usr/local/lib/antlr-denter-1.2.jar:$CLASSPATH" org.antlr.v4.gui.TestRig`
3. Add `antlr-denter-1.2.jar` to your CLASSPATH. 
   - Move `antlr-denter-1.2.jar` to your `/usr/local/lib/` folder
   - Add it to your classpath that you made in the previous step. For example, in my .zshrc file: `export CLASSPATH=".:/usr/local/lib/antlr-4.9.2-complete.jar:/usr/local/lib/antlr-denter-1.2.jar:$CLASSPATH"`
3. Run `antlr4 SimplePython.g4` in this directory
4. Run `javac *.java` to compile into java class files
5. To parse
    - And print tree on stdout, run: `grun SimplePython startRule -tree <file>`
    - And visualize in a gui, run: `grun SimplePython startRule -gui <file>`
        - Replace `<file>` with the `test_file.py` or alternative to parse a file
        - Omit `<file>` to input on stdin, and enter `control + D` to end the input
