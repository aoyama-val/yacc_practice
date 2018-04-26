%{
#include <math.h>
%}

NUMBER	[0-9]+(\.[0-9]+)?

%%

{NUMBER}    { yylval.d = atof(yytext); return NUMBER; }
[ \t]	    { /* ignore */ }
";"	    { return END; }
"+"	    { return '+'; }
"-"	    { return '-'; }
"*"	    { return '*'; }
"/"	    { return '/'; }
"%"	    { return '%'; }
"("	    { return '('; }
")"	    { return ')'; }
sin	    { yylval.f = sin; return FUNCTION; }
cos	    { yylval.f = cos; return FUNCTION; }
tan	    { yylval.f = tan; return FUNCTION; }
.	    { yylval.d = yytext[0]; return IDENT; }

%%

/*
int main()
{
    yylex();
    return 0;
}
*/
