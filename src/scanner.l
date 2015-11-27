%option noyywrap nodefault yylineno

%{
#include "struct.h"
#include "parser.tab.h"
%}

%%
"is"     { return IS; }
"write"  | 
"writef" { return WRITE; }
"ln"     { return LINE; }
"succ"   { return SUCC; }
":-init" { return INIT; }

"-"?[0-9]+ |
"-"?[0-9]+"."[0-9]+   { return NUMBER; } 
\'[,A-Za-z0-9 \s\t%\\]*\' { return STRING; }

"*" | 
"/" { return WEAK_OP; }
"-" | 
"+" { return STRONG_OP; }

">" |
"<" { return RELATION_OP; }

"("	{ return OPEN_PAR; }
")"	{ return CLOSE_PAR; }
"["	{ return OPEN_BRC; }
"]"	{ return CLOSE_BRC; }
"," { return COMMA; }
"=" { return ASSIGN; }

":-" { return DEFINE; }
"!"  { return CUT; }
"."  { return DOT; }

[a-z][A-Za-z]*  {yylval.name = yytext; return IDENTIFIER;}
[A-Z][A-Za-z_]* {yylval.name = yytext; return VARIABLE;}

[ \t\n] 

. {printf("Unrecognized symbol.\n");}
%%
