%option noyywrap nodefault yylineno

%{
#include "struct.h"
#include "parser.tab.h"
%}

%%
"is"        {return IS;}

"-"?[0-9]+ |
"-"?[0-9]+"."[0-9]+     {return NUMBER;} 
\'[A-Za-z0-9 \s\t]*\'   {return STRING;}

"*" | 
"/"  { return WEAK_OP;}
"-" | 
"+"  { return STRONG_OP;}

">"  |
"<"  { return RELATION_OP;}

"("	 { return OPEN_PAR;}
")"	 { return CLOSE_PAR;}
"["	 { return OPEN_BRACE;}
"]"	 { return CLOSE_BRAEC;}
","  { return COMMA;}
"="  { return ASSIGN;}
