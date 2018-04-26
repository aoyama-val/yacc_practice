%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char * msg)
{
    fprintf(stderr, "syntax error\n"); 
}

%}

%token NUM
%token NL

%%

program :
	stmt_list { }
	;

stmt_list :
	  stmt_list stmt
	  |
	  ;

stmt :
     expr NL { printf("-> %d\n", $1); } 
     | NL
     ;

expr :
     NUM { $$ = $1; }
     ;

%%

int main()
{
    yyparse();
    return 0;
}


#include "lex.yy.c"
