%{
#include <stdio.h>
#include <unistd.h>
%}

%token NUMBER
%token NL

%%

program :
	stmt_list;

stmt_list :
	  stmt_list stmt
	  |
	  ;

stmt :
     expr NL { printf("-> %d\n", $1); }
     | NL
     ;

expr :
     NUMBER
     ;

%%

int yyerror(char* msg)
{
    fprintf(stderr, "syntax error: %s\n", msg);
}

int main()
{
    yyparse();
    return 0;
}


#include "lex.yy.c"

