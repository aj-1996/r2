%{
	#include "y.tab.h"
	#include<math.h>
	extern YYSTYPE yylval;
%}
%%
[-+*/();=]				{return yytext[0];}	
[a-zA-Z_][a-zA-Z_0-9]*			{strcpy(yylval.str, yytext); return id;}
[\n\t ]					{;}
"$"					{return 0;}
%%

yywrap()
{
return 1;
}




output;
pccoe@212A-12:~$ lex tree.l
pccoe@212A-12:~$ yacc -d tree.y
pccoe@212A-12:~$ gcc lex.yy.c y.tab.c -lm
pccoe@212A-12:~$ ./a.out
a+b*c;$
a+b*c
pccoe@212A-12:~$
