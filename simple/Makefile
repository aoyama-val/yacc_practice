a.out: lex.yy.c y.tab.c
	gcc y.tab.c -ll

lex.yy.c: 1.l
	flex $<

y.tab.c: 1.y
	yacc 1.y
