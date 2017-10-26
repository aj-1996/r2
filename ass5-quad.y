%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<math.h>
	
	struct node
  	{
  		char name[10];
  		struct node *left, *right;
  	}*root;
  	struct node *top=NULL;
  	struct node *createnode(char *s, struct node *l, struct node *r);
%}

%union
{
	struct node *p;
	char str[10];
}

%token <str> id
%left '+' '-'
%left '*' '/'
%nonassoc UM
%type <p> E

%%

S	:	E ';'				{root=$1;}
	|	id '=' E ';'		{top=createnode($1,NULL,NULL);root=createnode("=",top,$3);}
  	;
E	:	E '+' E				{$$=createnode("+",$1,$3);}
	|	E '-' E				{$$=createnode("-",$1,$3);}
	|	E '*' E				{$$=createnode("*",$1,$3);}
	|	E '/' E				{$$=createnode("/",$1,$3);}
	|	'(' E ')'			{$$=$2;}
	|	id				{$$=createnode($1,NULL,NULL);}
	;
	
%%

void display(struct node *a)
{
	if(a==NULL)
		return;
	display(a->left);
	display(a->right);
	printf("%s",a->name);
}

struct node *createnode(char *s,struct node *l,struct node *r)
{
	struct node *temp;
	temp=(struct node*)malloc(sizeof(struct node));
	
	strcpy(temp->name,s);
	temp->left=l;
	temp->right=r;
	return temp;
}

main()
{
	yyparse();
	display(root);
	printf("\n");
}

int yyerror(char *s)
{
	printf("%s\n",s);
}

