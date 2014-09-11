%{
#include <stdio.h>
int valid = 1;
%}

%token A B

%%
S : A S | A A A A A A A A A A B ;
%%

int yyerror()
{
    valid = 0;
}

int yywrap()
{
    return 1;
}

int main()
{
    yyparse();
    if (valid)
        printf("valid\n");
    else
        printf("invalid\n");
    return 0;
}
