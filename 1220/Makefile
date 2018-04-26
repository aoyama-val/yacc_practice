a.out: lex.yy.c
	gcc y.tab.c -ly -ll

lex.yy.c: scan.l
	lex $<

y.tab.c: syntax.y
	yacc $<
