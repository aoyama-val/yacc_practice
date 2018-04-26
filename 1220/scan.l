%{
%}

NUMBER	[0-9]+

%%

{NUMBER}    { yylval = atoi(yytext); return NUMBER; }
\n	    { return NL; }
.	    { return yytext[0]; }

%%
