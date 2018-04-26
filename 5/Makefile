a.out: y.tab.c eval.c lex.yy.c
	cc -g y.tab.c eval.c -ll

lex.yy.c: scan.l
	lex $<

y.tab.c: example.y
	yacc example.y

test:
	./a.out < rei.3
