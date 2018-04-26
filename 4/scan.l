%{
#include <string.h>

int line_no = 1;

%}

%%
[ \t]	    { ; }
^#.*$	    { ; }
\n	    { line_no += 1; }
if	    { return IF; }
else	    { return ELSE; }
endif	    { return ENDIF; }
while	    { return WHILE; }
end	    { return END; }
print	    { return PRINT; }
==	    { return EQ; }
[A-Za-z]    { yylval.var = yytext[0];	// 変数名は最初の一文字だけ意味を持つ。
		return VAR;
	    }
[0-9]+	    { yylval.val = atoi(yytext);
		return NUM;
	    }
\"[^"]*\"   { yytext[yyleng - 1] = '\0';
		yylval.str = strdup(&yytext[1]);
		return STRING;
	    }
.	    { return yytext[0];}
%%

