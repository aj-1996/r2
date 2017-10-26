
%{
	#include "y.tab.h"
	#include<math.h>
	extern YYSTYPE yylval;
%}
%%
[-+*/();=]				{return yytext[0];}	
[a-zA-Z_][a-zA-Z_0-9]*			{strcpy(yylval.name, yytext); return id;}
[ \t\n]					{;}
"$"					{return 0;}
%%

