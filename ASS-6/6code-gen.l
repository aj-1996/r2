%{
	#include "y.tab.h"	
	#include<string.h>
	#include<math.h>
%}
%%
[a-zA-Z] {strcpy(yylval.s,yytext); return ID;}
[-+*/()=] { return yytext[0];}
"$" {return 0;}
[\n] {return 0;}
%%

