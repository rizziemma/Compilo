all :
	yacc -d -v -t compiler.y
	flex compiler.l
	gcc lex.yy.c y.tab.c symbols.c temp.c asm.c -o compiler


lexer :
	flex lexicale.l
	gcc lex.yy.c -o lexer

clean :
	rm -f lex.yy.c lexer t.tab.c compiler y.tab.c y.tab.h y.output output.s compiler.tab.c

