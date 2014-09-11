%{
int slc=0, mlc=0;
%}

%x MULTI_LINE_COMMENT
%x SINGLE_LINE_COMMENT
%x A_STRING
%%
<INITIAL>{
"/*"              BEGIN(MULTI_LINE_COMMENT);
"//"              BEGIN(SINGLE_LINE_COMMENT);
"\""              { ECHO; BEGIN(A_STRING); }
}
<MULTI_LINE_COMMENT>{
"*/"      { mlc++; BEGIN(INITIAL); }
. 
}
<SINGLE_LINE_COMMENT>{
\n        { slc++; ECHO; BEGIN(INITIAL); }
. 
}
<A_STRING>{
"\""      { ECHO; BEGIN(INITIAL); }
.         ECHO;
}
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