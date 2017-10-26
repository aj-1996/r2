%{
	#include<stdio.h>
	#include<string.h>   
  	#include<math.h>
  	#include<stdlib.h>
	
  	
  	struct node
	{
		char name[10];
		struct node *left,*right;
	}*root;
	 struct node *temp=NULL;
	 struct node *createnode(char *s, struct node *l, struct node *r);
	
  	
%}

%union
{
	struct node *p;
	char str[20];
}

%token <str> id
%left '+' '-'
%left '*' '/'
%nonassoc UM
%type <p> E
%%


S:E ';'			{root=$1;}				
 |id '=' E ';'		{temp=createnode($1,NULL,NULL); root=createnode("=",temp,$3);}
 ;
E:E '+' E	        {$$=createnode("+",$1,$3);}
 |E '-' E	     	{$$=createnode("-",$1,$3);}
 |E '*' E	     	{$$=createnode("*",$1,$3);}
 |E '/' E	     	{$$=createnode("/",$1,$3);}
 |id			{$$=createnode($1,NULL,NULL);}
 ;

%%




void display(struct node *n)
{
	if(n==NULL)
		return;
	display(n->left);
	printf("%s",n->name);
	display(n->right);
	
}

struct node *createnode(char *s, struct node *l, struct node *r)
{
	struct node *t;
	t=(struct node*)malloc(sizeof(struct node));
	strcpy(t->name,s);
	t->left=l;
	t->right=r;
	return t;
}
main()
{
	yyparse();
	display(root);
	printf("\n");
}


int yyerror(char *s)
{
	printf("%s (Invalid Input)\n",s);
}			



