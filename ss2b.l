%%
.*" "(?i:and|or|but|so|because|for|nor|yet)" ".* {fprintf(yyout, "A compound sentence");}
.* {fprintf(yyout, "A simple sentence");}
%%

int yywrap()
{
    return 1;
}

int main(int argc, char **argv)
{
    yylex();
    return 0;
}