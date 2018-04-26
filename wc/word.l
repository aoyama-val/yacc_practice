%{
#include <stdio.h>

int count = 0;

%}

WORD	[A-Za-z]+

%%

{WORD}	{ count++; }
. {  }

%%

int main()
{
    while (yylex());

    printf("%d\n", count);
    return 0;
}
