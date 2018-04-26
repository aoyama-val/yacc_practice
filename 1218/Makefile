a.out: lex.yy.c y.tab.c
	gcc -W -Wall y.tab.c -ll -lm

y.tab.c: syntax.y
	yacc $<

lex.yy.c: scan.l
	lex scan.l

clean:
	rm a.out
