%{
int id_cnt=0;
char ch;
%}
key ("int"|"float"|"double"|"char")
%%
[\t\n]+ ;
{key}" "+.*"(".*")" {ECHO; }
{key}" "+ {	char ch; 
			ch=input();
			while (ch!=';')	{
			   if(ch==',')
                   id_cnt++;
               ch=input();
            }
            id_cnt++;
        }
. { }
%%
int main(int argc,char **argv)
{
    yyin=fopen(argv[1],"r");
    yylex();
    printf("\n total number of identifiers are %d\n", id_cnt);
    return 0;
}
