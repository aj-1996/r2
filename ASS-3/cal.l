%{
	#include "y.tab.h"
%}
%%
"sin"			{return SIN;}
"cos"			{return COS;}
"tan"			{return TAN;}
"sqrt"			{return SQRT;}
"log"			{return LOG;}
[a-zA-Z_][a-zA-Z_0-9]*		{strcpy(yylval.name,yytext); return id;}
[0-9]+(\.[0-9]+)?	{yylval.val=atoi(yytext);return num;}
[-+*/=();]			{return yytext[0];}
[ \t\n]			{;}
"$"			{return 0;}

%%
