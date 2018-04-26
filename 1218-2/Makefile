a.out: y.tab.c lex.yy.c eval.c node.h
	gcc y.tab.c eval.c -ll

y.tab.c: syntax.y
	yacc $<

lex.yy.c: scan.l
	lex $<
