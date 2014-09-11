%{
int c=0;
int w=0;
int nl=0;
int s=0;
%}

%%
" " {c++, s++;}
\n {nl++, c++;}
[^ \n\t]+ {w++, c += yyleng;}
. {c++;}
%%

int yywrap()
{
    return 1;
}

int main(int argc, char **argv)
{
    if (argc == 2)
    {
        yyin=fopen(argv[1],"r");
        yylex();
        printf("No of Characters : %d\n", c);
        printf("No of Spaces     : %d\n", s);
        printf("No of Words      : %d\n", w);
        printf("No of Lines      : %d\n", nl);
        return 0;
     }
     printf("Enter one filename as argument");
     return 1;
}
