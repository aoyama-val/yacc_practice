%{
#include <stdio.h>
%}

%%
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
\n	{ return NL; }
.	{ /* ignore */ }

%%

/*
int main()
{
    yylex();
    return 0;
}
*/
