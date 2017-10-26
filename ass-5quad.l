%option noyywrap
%{
	#include "y.tab.h"
	#include<math.h>
	extern YYSTYPE yylval;
%}

%%
[-+*/();=]				{return yytext[0];}	
[a-zA-Z_][a-zA-Z_0-9]*	{strcpy(yylval.str, yytext); return id;}
[\n\t ]					{;}
"$"						{return 0;}
%%



