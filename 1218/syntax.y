%{
#include <stdio.h>
#include <stdlib.h>

int yyerror(char* msg);
int yylex();
%}

%union {
    double d;
    int    i;
    double (*f)(double);
}

// 演算子の優先順位は上から下、左から右の順で強くなる
%token <d> NUMBER
%token END
%token IDENT
%token <f> FUNCTION
%left '+' '-'
%left '*' '/' '%'

%type <d> expr

%%

program :
    stmt_list
    ;

stmt_list :
    stmt_list stmt
    |
    ;

stmt :
    expr END { printf("-> %f\n", $1); }
    | END { }
    ;

expr :
    NUMBER { $$ = $1; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | expr '%' expr { $$ = $1 - $3; }
    | '(' expr ')'  { $$ = $2; }
    | FUNCTION '(' expr ')' {
		double(*f)(double);
		f = $1;
		$$ = f($3);
	    }
    ;

%%

#include "lex.yy.c"

int yyerror(char* msg)
{
    fprintf(stderr, "syntax error: %s\n", msg);
    return 0;
}

int main()
{
    yyparse();
    return 0;
}
