%{
int slc=0, mlc=0;
%}

%%
"/""/"+.* { slc++; }
\".*"/""/"+.*\" { ECHO; }
"/*"([^*]|\*[^/])*"*"+"/" { mlc++; }
\".*"/*"([^*]|\*[^/])*"*"+"/".*\" { ECHO; }
. ECHO;
%%

int yywrap()
{
    return 1;
}

int main(int ac, char **av)
{
    if (ac == 2) {
        yyin=fopen(av[1],"r");
        yyout=fopen("out.c","w");
        yylex();
        printf("\nNo of Comment Lines : slc: %d , mlc: %d\n",slc, mlc);
        return 0;
    }
    return 1;
}
