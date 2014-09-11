%{
 #include <stdio.h>
 #include <ctype.h>
 int valid = 1;
%}

%token NUM
%left '+' '-'
%left '*' '/'
%left '(' ')'
%%
expr : E {
    if (valid)
        printf("ThE Reuslt of thE Expression is : %d\n", $1);
    }
E : E '+' E { $$ = $1 + $3; }
E : E '-' E { $$ = $1 - $3; }
E : E '*' E { $$ = $1 * $3; }
E : E '/' E {
    if ($3 == 0)
        printf("Invalid : Divide By Zero\n"); 
    else
        $$ = $1/$3;
    }
E : '-' E { $$ = -$2; }
E : '(' E ')' { $$ = $2; }
E : NUM { $$ = $1;}
%%

int yyerror(char* s)
{
  valid = 0;
}

int yywrap()
{
  return 1;
}

int main()
{
  printf("Enter expression to evaluate:\n");
  yyparse();
  return 0;
}
