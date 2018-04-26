a.out: lex.yy.c y.tab.c
	gcc y.tab.c -ll

y.tab.c: syntax.y 
	yacc $<

lex.yy.c: scan.l
	lex $<
