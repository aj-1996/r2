%{
	#include<stdio.h>
	#include<string.h>   
  	#include<math.h>
  	struct quad
  	{
  		char symname[20];
  		double sval;
  	};
  	struct symtab s[20];
  	int sindex=0,i;
	
%}

%union
{
	char name[20];
	double val;
}

%token <name> id
%token <val> num
%token SIN COS TAN SQRT LOG
%left '+' '-'
%left '*' '/'
%nonassoc UM
%type <val> E
%start SList
%%

SList:SList S
	 |S;
S:id '=' E ';'				{i=insert($1);
							 s[i].sval=$3;}
 |E ';'						{printf("%f",$1);}
 ;
E:E '+' E					{$$=$1+$3;}
 |E '-' E					{$$=$1-$3;}
 |'-' E			%prec UM 	{$$=-$2;}
 |E '*' E					{$$=$1*$3;}
 |E '/' E					{$$=$1/$3;}
 |SIN'('E')'			{$$=sin($3*(3.141/180.0));}
 |COS'('E')' 			{$$=cos($3*(3.141/180.0));}
 |TAN'('E')' 			{$$=tan($3*(3.141/180.0));}
 |SQRT'('E')'			{$$=sqrt($3);}
 |LOG'('E')'			{$$=log($3);}
 |id						{i=insert($1);
 						$$=s[i].sval;}
 |num						{$$=$1;}
 ;
 
%%

main()
{
	yyparse();
}

int insert(char *name)
{
	int i=0;
	for(i=0;i<sindex;i++)
	{
		if(strcmp(s[i].symname,name)==0)
			return i;
	}
	strcpy(s[sindex].symname,name);
	sindex++;
	return sindex-1;
}

int yyerror(char *s)
{
	printf("%s (Invalid Input)\n",s);
}	
