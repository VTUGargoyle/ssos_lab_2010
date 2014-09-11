%{
#include <stdio.h>
int valid=1;
%}

%token NUMBER ID
%left '+' '-'
%left '*' '/'
%left '(' ')'

%%
E : E'+'E | E'-'E | E'*'E | E'/'E | '('E')' | NUMBER | ID;
%%

int yyerror(char* s)
{
    valid=0;
}

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter Expression:\n");
    yyparse();
    if(valid)
        printf("Valid Expression\n");
    else
        printf("Invalid Expression\n");
    return 0;
}
