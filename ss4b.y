%{
 #include <stdio.h>
 int valid=1;
%}

%token LETTER DIGIT

%%
VAR : LETTER | VAR LETTER | VAR DIGIT;
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
    printf("Enter a variable:\n");
    yyparse();
    if(valid)
        printf("Valid variable\n");
    else
        printf("Invalid variable\n");
    return 0;
}
