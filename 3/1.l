%{
#include <stdio.h> 
%}

NUM	[0-9][0-9]*

%%
{NUM} { printf("num=[%s]\n", yytext); }

struct { printf("struct found\n"); }

. {; }
%%
