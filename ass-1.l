
%{
  #include<stdio.h>
  #include<string.h>   
  
  struct symtab
  {
  	char symname[20];
  };
  struct symtab s[20];
  int sindex=0;
%}

%%
"main"   {  printf("%s \t MAIN \n",yytext);  }    

[ \t]*"#include"[ \t]*"<"[a-zA-Z]+[.][hc]">"	{printf("%s \t Preprocessor Directives \n",yytext);}
[ \t]*"#include"[ \t]*["][a-zA-Z]+[.][hc]["]	{printf("%s \t Preprocessor Directives \n",yytext);}    
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"sizeof"|"signed"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"	{printf("%s \t KEYWORDS \n",yytext);}
[=]				{printf("%s \t ASSIGNMENT OPERATOR \n",yytext);}
[-+*/%]  			{printf("%s \t ARITHMETIC OPERATOR \n",yytext);}
"<"|">"|"<="|">="|"==" 	{printf("%s \t RELATIONAL OPERATOR \n",yytext);}
"!"|"&&"|"||"		{printf("%s \t LOGICAL OPERATOR \n",yytext);}
[+-]?[0-9]+			{printf("%s \t NUMBER \n",yytext);}
[+-]?[0-9]+([.][0-9]+)?([eE][+-]?[0-9]+)?	{printf("%s \t FLOATING POINT NUMBER \n",yytext);}
[ \t\n]			{printf("%s \t WHITESPACE \n",yytext);}
"("|")"			{printf("%s \t PARENTHESIS \n",yytext);}
"{"|"}"			{printf("%s \t CURLY BRACES \n",yytext);}
[,;]				{printf("%s \t DELIMITERS \n",yytext);}
["][^"\n]*["]		{printf("%s \t STRING CONSTANT \n",yytext);}
['].[']			{printf("%s \t CHARACTER CONSTANT \n",yytext);}
[A-Za-z_][A-Za-z0-9]*	{printf("%s \t IDENTIFIER \n",yytext); insert(yytext); }
"//".*			{printf("%s \t SINGLE LINE COMMENT \n",yytext);}
"/*"([^*]*|[^/]*)"*/" 	{printf("%s \t MULTI LINE COMMENT \n",yytext);}
%%

main()
{ 
	FILE * fp;
	char f[10];
	
	printf("\n ENTER FILE NAME : ");
	scanf("%s",f);
	
	if(fp=fopen(f,"r"))
	{
	
	yyin=fp;
	
       printf("\nLEXEMES \t TOKENS\n\n");
       
       yylex();
       
       int i;
       
       printf("\nSymbol Table:\n\n");
       printf("Symbol index\tSymbol Name\n");
       for(i=0;i<sindex;i++)
       {
       	printf("\t%d\t%s\n",i,s[i].symname);
       }
  	}
  	else
  	
  	  printf("\n FILE NOT FOUND\n\n");	
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
	return sindex;
} 	 
   int yywrap()
   {
      return 1;
   }


