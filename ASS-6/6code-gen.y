
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
void yyerror(char *);
typedef struct Stack
{
	char s[2][3];
	int tp;
}stack;

stack rstack,tstack;
void push(char c,char a[]);
char * pop(char c);
char * top(char c);

typedef struct NODES
{
	char data[10];
	int label;
	struct NODES *left;
	struct NODES * right;
}NODE;
NODE * root=NULL, *temp=NULL, *p=NULL;
void inorder(NODE *);
void swap(char c);
void gencode(NODE *n,char c);
void labelling(NODE *);
NODE * createNode(char a[], NODE *,NODE *);
char R[3],T[3],a[3];
int i,j;
int nr=2;//no of available registers
%}
%union
{
char s[20];
struct NODES *n;
}
%token <s>ID
%type <n>E 
%left '='
%left '+' '-'
%left '*' '/'

%%
S:E {root=$1; gencode(root,'g'); }  
 ;
E:E'+'E {$$=createNode("ADD",$1,$3); labelling($$);}
 |E'*'E {$$=createNode("MUL",$1,$3); labelling($$); }
 |E'-'E { $$=createNode("SUB",$1,$3); labelling($$);}
 |E'/'E { $$=createNode("DIv",$1,$3); labelling($$);}
 |'('E')' {$$=$2;}
 |ID { $$=createNode($1,NULL,NULL); }
 ;
%%
void main()
{
int g;
root=NULL;
temp=NULL;
p=NULL;
	j=1;
	rstack.tp=-1;
	tstack.tp=-1;
	push('r',"R1");
	push('r',"R0");

	push('t',"T1");
	push('t',"T0");

	
	yyparse();
	printf("\nThe syntax tree is:- \n");
	printf("\nNODE   LABEL");
	printf("\n=============");
	inorder(root);
	printf("\n");
}
void yyerror(char *s)
{	
		printf("%s",s);
}

NODE * createNode(char a[],NODE * l,NODE * r)
{

  temp=(NODE *)malloc(sizeof(NODE));
  strcpy(temp->data,a);
  temp->left=l;
  temp->right=r;
  temp->label=0;
  return temp;
}

void inorder(NODE * a)
{
	if(a!=NULL)
	{
		inorder(a->left);
		printf("\n%s	%d", a->data,a->label);
		inorder(a->right);
	}
}

void push(char c,char a[])
{
	if(c=='r')
	{
		rstack.tp++;
		strcpy(rstack.s[rstack.tp],a);
	}
	else
	{
		tstack.tp++;
		strcpy(tstack.s[tstack.tp],a);
	}
}

char * pop(char c)
{
	if(c=='r')
	{
		strcpy(a,rstack.s[rstack.tp]);
		strcpy(rstack.s[rstack.tp],"");
		rstack.tp--;
	}
	else
	{
		strcpy(a,tstack.s[tstack.tp]);
		strcpy(tstack.s[tstack.tp],"");
		tstack.tp--;
	}
	return a;
}

char * top(char c)
{
	if(c=='r')
	{
		strcpy(a,rstack.s[rstack.tp]);
	}
	else
	{
		strcpy(a,tstack.s[tstack.tp]);
	}
	return a;
}

void swap(char c)
{
	char t[3];
	if(c=='r')
	{
		strcpy(t,rstack.s[rstack.tp]);
		strcpy(rstack.s[rstack.tp],rstack.s[rstack.tp-1]);
		strcpy(rstack.s[rstack.tp-1],t);
	}
	else
	{
		strcpy(t,tstack.s[tstack.tp]);
		strcpy(tstack.s[tstack.tp],tstack.s[tstack.tp-1]);
		strcpy(tstack.s[tstack.tp-1],t);
	}
}

void labelling(NODE *a)
{
	NODE *d,*d1;
	d=a->left;
	d1=a->right;
	if(d->label==0)
		a->left->label=1;
	if(d->label>d1->label)
		a->label=d->label;
	else if(d->label<d1->label)
		a->label=d1->label;
	else
		a->label=d->label+1;
}

void gencode(NODE *n,char c)
{
	if((n->left==NULL) && (n->right==NULL))
	{
		if(c=='l')
		{
			printf("\nMOV %s, %s",n->data,top('r'));
		}
	}	
	else if(n->right->label==0)
	{
		gencode(n->left,'l');
		printf("\n%s, %s, %s",n->data,n->right->data,top('r'));
	}
	else if((1<=n->left->label)&&(n->left->label<n->right->label)&&(n->left->label<nr))
	{
		swap('r');
		gencode(n->right,'r');
		strcpy(R,pop('r'));
		gencode(n->left,'l');
		printf("\n%s %s, %s",n->data,R,top('r'));
		push('r',R);
		swap('r');
	}
	else if((1<=n->right->label)&&(n->right->label<=n->left->label)&&(n->right->label<nr))
	{
		gencode(n->left,'l');
		strcpy(R,pop('r'));
		gencode(n->right,'r');
		printf("\n%s %s, %s",n->data,top('r'),R);
		push('r',R);
	}
	else 
	{
		gencode(n->right,'r');
		strcpy(T,pop('t'));
		printf("\nMOV %s, %s",top('r'),T);
		gencode(n->left,'l');
		printf("\n%s , %s , %s",n->data,T,top('r'));
		push('t',T);
	}
}

Output:

(a+b)*(c-d)-(e/f+(m+n))

MOV e, R0
DIv, f, R0
MOV m, R1
ADD, n, R1
ADD R1, R0
MOV R0, T0
MOV a, R0
ADD, b, R0
MOV c, R1
SUB, d, R1
MUL R1, R0
SUB , T0 , R0
The syntax tree is:- 

NODE   LABEL
=============
a	1
ADD	1
b	0
MUL	2
c	1
SUB	1
d	0
SUB	3
e	1
DIv	1
f	0
ADD	2
m	1
ADD	1
n	0
pccoecomp@STAFFPC:~$
*/

