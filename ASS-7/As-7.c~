
Title:- Implement the following code optimization techniques:- 
 	   1)Common Subexpression Elimination
_______________________________________________________________________

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

typedef struct Table
{
	char arg1[5];
	char arg2[5];
 	char op[5];
	char result[10];
}tabl;
 
tabl table[15];
int counts;
char c[3];

void store(char a[],char b[],char c[],char d[]);
void searchleft(char a[5]);
int searchright(char a[5],char b[5],char c[5]);
int main()
{
	FILE *f,*f1;
	int n,i;
	char buff[30],t1[3],t2[3],t3[3],t4[3],t5[3],g[3];
	counts=0;
	f=fopen("in.txt","r");
	f1=fopen("out.txt","w");
	if(f==NULL)
	{
		printf("\nFile cannot be opened..");
		return;
	}
	while(fgets(buff,80,f))
	{
		n=sscanf(buff,"%s%s%s%s%s",t1,t2,t3,t4,t5);
		switch(n)
		{
			case 3:
				searchleft(t1);
				fprintf(f1,"%s\n",buff);
				break;
			case 5:
				
				i=searchright(t3,t4,t5);
				
				if(i!=-1)
				{
					fprintf(f1,"%s = %s\n",t1,table[i].result);
				}
				else
				{
					store(t3,t4,t5,t1);
					fprintf(f1,"%s\n",buff);
				}
				searchleft(t1);
				break;
			default:
				printf("\nInvalid choice,..");
		}
	}

	printf("\n********TABLE********");
	printf("\nIndex\tARG1\tARG2\tOP\tRESULT");
	for(i=0;i<counts;i++)
	{
		printf("\n%d\t%s\t%s\t%s\t%s",i+1,table[i].arg1,table[i].arg2,table[i].op,table[i].result);
	}	

	return 0;
}

void store(char a[],char b[],char c[],char d[])
{	
	
	strcpy(table[counts].arg1,a);
	strcpy(table[counts].arg2,c);
        strcpy(table[counts].op,b);
       strcpy( table[counts].result,d);
	counts++;
}


void searchleft(char a[5])
{
	int i,j;
	for(i=0;i<counts;i++)
	{
		if((strcmp(table[i].arg1, a)==0) || (strcmp(table[i].arg2, a)==0))
		{
			for(j=i;j<(counts-1);j++)
			{
				strcpy(table[j].arg1,table[j+1].arg1);
				strcpy(table[j].arg2,table[j+1].arg2);
				strcpy(table[j].op,table[j+1].op);
				strcpy(table[j].result,table[j+1].result);
			}
			counts--;
		}
	}
}

int searchright(char a[5],char b[5],char c[5])
{
	int i;
	for(i=0;i<counts;i++)
	{
		if((strcmp(table[i].arg1, a)==0) && (strcmp(table[i].arg2, c)==0) && (strcmp(table[i].op, b)==0))
		{
					return i;
		}
	}
	return -1;
}


__________________________________________________________________________________________________________

OUTPUT:

***INPUT FILE*****

t1 = a * b
t2 = x + y
x = a * b
a = x + y

***OUTPUT FILE*****

t1 = a * b
t2 = x + y
x = t1
a = x + y

********TABLE********
Index	ARG1	ARG2	OP	RESULT
1	x	y	+	a

*/
