%{
#include <stdio.h>
int valid=1;
%}

%%
S : 'a' S 'b' | ;
%%

int yyerror(char * s)
{
    valid=0;
}

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter String");
    yyparse();
    if(valid)
        printf("Valid string\n");
    else
        printf("Invalid string\n");
}
