%{
%}

NUMBER	[0-9][0-9]*

%%
{NUMBER} { yylval = atoi(yytext); return NUM; }
\n	{ return NL; }
. {; }
%%
