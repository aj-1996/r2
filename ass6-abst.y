
%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>   
  	#include<math.h>
	#define R 2
	#define T 10
  	struct node
  	{
  		int label;
  		char name[10];
  		struct node *left, *right;
  	}*root;

	struct stack
	{
		int st[10];
		int top;
	}rstack,tstack;
	void init();
	void push(struct stack *, int);
	int pop(struct stack *);
	int top(struct stack *);
	void swap();
	struct node * createnode(char *, struct node *, struct node *);
	void labelnode(struct node *);
	void display(struct node *);
	void codegen(struct node *);
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

S	:	E ';'					{root=$1;}
  	;
E	:	E '+' E					{$$=createnode("ADD",$1,$3); labelnode($$);}
	|	E '-' E					{$$=createnode("SUB",$1,$3); labelnode($$);}
	|	E '*' E					{$$=createnode("MUL",$1,$3); labelnode($$);}
	|	E '/' E					{$$=createnode("DIV",$1,$3); labelnode($$);}
	|	'(' E ')'				{$$=$2;}
	|	id					{$$=createnode($1,NULL,NULL);}
	;

%%


void init()
{
	int i,j;
	for(j=0,i=R-1;i>=0;i--,j++)
		rstack.st[i]=j;
		rstack.top=R-1;
	for(j=0,i=T-1;i>=0;i--,j++)
		tstack.st[i]=j;
	tstack.top=T-1;
}

void push(struct stack * stk, int x)
{
	stk->top++;
	stk->st[stk->top]=x;
}

int pop(struct stack * stk)
{
	return stk->st[stk->top--];
}

int top(struct stack * stk)
{
	return stk->st[stk->top];
}

void swap()
{
	int temp;

	temp=rstack.st[rstack.top];
	rstack.st[rstack.top]=rstack.st[rstack.top-1];
	rstack.st[rstack.top-1]=temp;

}

void codegen(struct node *n)
{
	
	if(n->left==NULL && n->right==NULL)
	{
		printf("MOV %s,R%d\n",n->name,rstack.st[rstack.top]);
	}
	else if(n->right->label==0)
	{
		codegen(n->left);
		printf("%s %s,R%d\n",n->name,n->right->name,rstack.st[rstack.top]);
	}
	else if(n->left->label >= 1 && n->right->label > n->left->label && n->left->label < R)
	{
		swap();
		codegen(n->right);
		int x=pop(&rstack);
		codegen(n->left);
		printf("%s R%d,R%d\n",n->name,x,rstack.st[rstack.top]);
		push(&rstack,x);
		swap();
	}
	else if(n->right->label>=1 && n->left->label >= n->right->label && n->right->label < R)
	{
		codegen(n->left);
		int x=pop(&rstack);
		codegen(n->right);
		printf("%s R%d,R%d\n",n->name,rstack.st[rstack.top],x);
		push(&rstack,x);
	}
	else
	{
		int t=pop(&tstack);
		codegen(n->right);
		printf("MOV R%d,T%d\n",rstack.st[rstack.top],t);
		codegen(n->left);
		printf("%s T%d,R%d\n",n->name,t,rstack.st[rstack.top]);
		push(&tstack,t);
	}
}

struct node * createnode(char *s, struct node *l, struct node *r)
{
	struct node * n;
	n=(struct node *)malloc((sizeof(struct node)));
	if(n!=NULL)
	{
		strcpy(n->name,s);
		n->left=l;
		n->right=r;
		n->label=0;
	}
	else
		printf("Memory not allocated");
	return n;
}

void labelnode(struct node * a)
{
	if(a->left->label==0)
		a->left->label=1;
	if(a->left->label==a->right->label)
		a->label=a->left->label+1;	
	else if(a->left->label>a->right->label)
		a->label=a->left->label;
	else
		a->label=a->right->label;
}

void display(struct node * a)
{
	if(a==NULL)
		return;
	display(a->left);
	display(a->right);	
	printf("%s	%d\n",a->name,a->label);
}

main()
{
	init();
	yyparse();
	display(root);
	codegen(root);
	printf("\n");
}

int yyerror(char *s)
{
	printf("%s (Invalid Input)\n",s);
}



