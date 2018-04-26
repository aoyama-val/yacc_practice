%{
#include <stdio.h> 
#include <stdlib.h> 
#include <setjmp.h> 

#define SIZE_OF_STACK	(100)

void push(double);
double pop(void);


%}

F   ([0-9]*("."[0-9]+)?)

%%

";".*$	    { ; /* comment */ }
[ \t\n]+    { ; /* white space */ }
{F}	    { push(atof(yytext)); }
"+"	    { push(pop() + pop()); }
"-"	    { 
		double a = pop();
		double b = pop();
		push(b - a);
	    }
"?"	    { printf("val = [%f]\n", pop()); }

.	    { fprintf(stderr, "syntax error\n"); }

%%

static double stack[SIZE_OF_STACK];
static int sp = 0;

static jmp_buf error;

double pop(void)
{
    if (sp > 0) {
	return stack[--sp];
    }
    fprintf(stderr, "stack underflow\n");
    longjmp(error, 1);
}

void push(double a)
{
    if (sp < SIZE_OF_STACK) {
	stack[sp++] = a;
	return;
    }
    fprintf(stderr, "stack overflow\n");
    longjmp(error, 1);
}

int main()
{
    setjmp(error);
    while (yylex()) ;

    return 0;
}

