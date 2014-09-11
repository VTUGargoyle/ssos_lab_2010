%{
int valid = 1;
int parencnt = 0;
%}

id [a-zA-Z]+[0-9a-zA-Z]*
op   \+|\-|\*|\/
pop  "("
pcl  ")"
%x PARENOP
%x PARENCL
%x ID
%x OP
%%
<INITIAL>{
{id} { fprintf(yyout, "identifier: %s\n", yytext); BEGIN(ID);}
{op} { fprintf(yyout, "operator: %s\n", yytext); }
{pop} { parencnt++; BEGIN(PARENOP); }
{pcl} { printf("invalid expression\n"); exit(1); }
}
<ID>{
{id} { printf("invalid expression\n"); exit(1); }
{op} { fprintf(yyout, "operator: %s\n", yytext); BEGIN(OP); }
{pop} { printf("invalid expression\n"); exit(1); }
{pcl} { parencnt--; BEGIN(PARENCL); }
}
<OP>{
{op} { printf("invalid expression\n"); exit(1); }
{id} { fprintf(yyout, "identifier: %s\n", yytext); BEGIN(ID); }
{pop} { parencnt++; BEGIN(PARENOP); }
{pcl} { printf("invalid expression\n"); exit(1); }
}
<PARENOP>{
{id} { fprintf(yyout, "identifier: %s\n", yytext); BEGIN(ID);}
{op} { printf("invalid expression\n"); exit(1); }
{pop} { parencnt++; }
{pcl} { printf("invalid expression\n"); exit(1); /* does not take "()" as valid */ }
}
<PARENCL>{
{id} { printf("invalid expression\n"); exit(1); }
{op} { fprintf(yyout, "operator: %s\n", yytext); BEGIN(OP); }
{pop} { printf("invalid expression\n"); exit(1); }
{pcl} { parencnt--; }
}
%%

int yywrap()
{
    return 1;
}

int main()
{
    yylex();
    if (valid && !parencnt) 
        printf("valid expression\n");
    else
        printf("invalid expression\n");
    return 0;
}
