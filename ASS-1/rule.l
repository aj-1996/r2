%{
        #include<stdio.h>
        #include<string.h>
        FILE *fp,*yyin;
        int i,symcnt=0;
        
        struct Symboltable
        {
                int index;
                char name[20];
        }s[10];
%}

%%
"#include"[\t]*"<"[a-z]+"."[hc]">" {printf("\nPreprocessor directive %s",yytext);}
"int"|"main"|"printf"|"scanf"|"if"|"return"|"else"|"for"  	{printf("\nKeyword %s",yytext);}
[{}()]+      	{printf("\nParenthesis %s",yytext);}
[,;:]          	{printf("\nDelimiter %s",yytext);}
[-+*/=&]          {printf("\nOperator %s",yytext);}
[0-9]+            {printf("\nConstant %s",yytext);}
\"[^\n"]*\"     	{printf("\nString constant %s",yytext);}
[a-zA-Z][a-zA-Z0-9]*   {printf("\nIdentifier %s",yytext); insert(yytext);}
%%

int insert(char txt[20])
{
       int flag=0;
        for(i=0;i<=symcnt;i++)
        {
                if((strcmp(s[i].name,txt))==0)
                {
				    flag=1;
				    break; 
                }
			
        }
	   if(flag!=1)
	   {
		  symcnt++;
		  strcpy(s[symcnt].name,txt);
		  s[symcnt].index=symcnt;
	   }  
	return 0;
}
int main()
{ 
        fp=fopen("add.c","r");
	   int j;
        yyin=fp;
        yylex();
		printf("\nIndex:");
          printf("\tName:\n");
        for(j=1;j<=symcnt;j++)
        {
                printf("\n%d",s[j].index);
                printf("\t%s\n",s[j].name);
        }
        return 0;
}
 int yywrap()
 {               
        return 1; 
 }	
