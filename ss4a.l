%{
#include "y.tab.h"
%}
%%
[1-9][0-9]* {return NUMBER;}
[a-zA-Z][0-9a-zA-Z]* {return ID;}
[\n] {return 0;}
[\t ] ;
. {return yytext[0];}
%%
