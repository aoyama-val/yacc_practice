%{
#include <stdio.h>

%}

NUMBER	[0-9]+
%%

{NUMBER}    { yylval.i = atoi(yytext); return NUMBER; }
\n	    { return NL;}
"("	    { return '('; }
")"	    { return ')'; }
[ \t]+	    { /* ignore */ }
.	    { return yytext[0]; }


%%
