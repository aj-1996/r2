#include<stdio.h>
#include<string.h>

void E();
void T();
void Tdash();
void Edash();
void F();
char input[20];
int i=0,error=0;
int main()
{
        
        printf("\nEnter the string:");
        scanf("%s",input);
        
        E();
       
          if(input[i]==0 && error==0)
          {
             printf("String is accepted\n");
          }
        
          else
          {
            printf("String is not accepted\n");    
          }
      return 0;
}
        void E()
        {
                T();
                Edash();
        }
        void T()
        {
                F();
                Tdash();
        }    
        void Tdash()
        {
                if(input[i]=='*')
                {
                        i++;
                        F();
                        Tdash();
                }
        }
        void Edash()
        {
                if(input[i]=='+')
                {
                        i++;
                        T();
                        Edash();
                }
        }
        void F()
        {
                if(input[i]=='(')
                {
                        i++;
                        E();
                        if(input[i]==')')
                        {
                                i++;
                        }
                }
                else if((input[i]>='a' && input[i]<='z') || (input[i]>='A' && input[i]<='Z') || isalpha(input[i]))
                {
                        i++;
                }
                else if(isdigit(input[i]))
                {
                        i++;
                }
                else
                {
                        error=1;
                }
        }
