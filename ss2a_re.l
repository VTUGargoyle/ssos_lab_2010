%{
int idcnt=0, opcnt=0;
int ob=0, cb=0;
%}
id [a-zA-Z]+[a-zA-Z0-9]*
op (\+|\-|\/|\*)
%%
{id} { idcnt++; printf("\n %s is an identifier\n", yytext); }
{id}" "+{id} { printf("invalid expression\n"); exit(1); }
{op}{2,} { printf("invalid expression\n"); exit(1); }
{op} { opcnt++; }
"(" { if (cb <= ob) ob++; else { printf("Invalid expression\n"); exit(1); } }
")" { cb++; }
"("" "*")" { printf("invalid expression\n"); exit(1); }
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the expression\n");
    yylex();
    if (opcnt+1 == idcnt && ob == cb) {
	printf("Valid expression\n");
    }
    else {
	printf("invalid expression");
    }
    return 0;
}
