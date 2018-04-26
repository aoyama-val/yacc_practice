%{
#include <stdio.h>
%}

%token NUMBER NL '(' ')'
%left '+' '-'
%left '*' '/'

%start prog

%%

prog :
     stmt_list;

stmt_list :
	  stmt_list stmt
	  |
	  ;

stmt :
     expr NL	{ printf("val=%d\n", $1); }
     | NL
     ;

expr :
     NUMBER
     | expr '+' expr { $$ = $1 + $3; }
     | expr '-' expr { $$ = $1 - $3; }
     | expr '*' expr { $$ = $1 * $3; }
     | expr '/' expr { $$ = $1 / $3; }
     | '(' expr ')' { $$ = $2; }
     ;

%%


/*
int yyerror(char* msg)
{
    puts(msg);
    return 0;
}
*/

int main()
{
    yyparse();
    return 0;
}

//#include "lex.yy.c"
