%{
    int id = 0;
%}

%x ID
%%
<INITIAL>{
(float|int|char|double|long|short) { BEGIN(ID); }
.|\n 
}
<ID>{
"(" { BEGIN(INITIAL); /* It's just a return type of a function */ }
"," id++;
";" { id++; BEGIN(INITIAL); }
.|\n
}
%%

int yywrap()
{
    return 1;
}

int main()
{
	yyin = fopen("exmpl.c","r");
	yylex();
	printf("number of identifiers: %d\n", id);
	return 0;
}


