#include<stdio.h>

void E();
void Edash();
void T();
void Tdash();
void F();

char input[30];
int error=0,ip=0;

void main()
{
	
	printf("\nEnter the input:");
	scanf("%s",input);
	
	E();
	
	if(input[ip]=='\0' && error==0)
		printf("\n\nInput is valid\n");
	else
		printf("\n\nInput is invalid\n");
}

void E()
{
	printf("\nE-> TE'");
	T();
	Edash();
}

void Edash()
{
	if(input[ip]=='+')
	{
		printf("\nE'-> +TE'");
		ip++;
		T();
		Edash();
	}
	else if(input[ip]=='-')
	{
		printf("\nE'-> -TE'");
		ip++;
		T();
		Edash();
	}
	else 
		printf("\nE'-> epsilon");	
}
	
void T()
{
	printf("\nT-> FT'");
	F();
	Tdash();
}
	
void Tdash()
{
	if(input[ip]=='*')
	{
	 	printf("\nT'-> *FT'");
		ip++;
		F();
		Tdash();
	}
	else if(input[ip]=='/')
	{
		printf("\nT'-> /FT'");
		ip++;
		F();
		Tdash();
	}
	else 
		printf("\nT'-> epsilon");
}
	
void F()
{
	if(isalpha(input[ip]))
	{
		printf("\nF-> id");
		ip++;
	}
	else
	{
		if(input[ip]=='(')
		{
				
			ip++;
			E();
			if(input[ip]==')')
			{
				printf("\nF-> (E)");
				ip++;
			}
			else
				error=1;
		}
		else
			error=1;
	}	
}

