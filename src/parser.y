%{
#include "struct.h"
%}

%union
{
    char *name;
    int number;
}

%token IS WRITE LINE SUCC INIT
%token NUMBER STRING 
%token <name> IDENTIFIER VARIABLE 
%token WEAK_OP STRONG_OP RELATION_OP
%token OPEN_PAR CLOSE_PAR OPEN_BRC CLOSE_BRC COMMA ASSIGN
%token DEFINE DOT CUT

%type <number> PROGRAM PREDICATES PREDICATE ARGUMENTS ARGUMENT LIST STATEMENTS STATEMENT SEQUENCE TERM GOALS GOAL

%%
PROGRAM: PREDICATES GOALS
{
    if ($1 >=0 && $2 >= 0 && ($1 == 2 || $1 == 1 || $2 == 2))
    {
        printf("OK.\n");
    }
    else
    {
        printf("Not OK.\n");
    }
}
;

PREDICATES: PREDICATES PREDICATE { $$ = $2; }
          | PREDICATE            { $$ = $1; }
          |                      { $$ = 0; }
;

PREDICATE: IDENTIFIER OPEN_PAR ARGUMENTS CLOSE_PAR DOT 
         { 
            struct List * id = check_identifier(table, identifier_parse($1));
            $$ = 1;
            table = add_identifier(table, identifier_parse($1), $3);
                   
         }
         | IDENTIFIER OPEN_PAR ARGUMENTS CLOSE_PAR DEFINE STATEMENTS DOT 
         { 
            struct List * id = check_identifier(table, identifier_parse($1));
            if ($6 == 3)
            {
                $$ = 3;
            }
            else
            {
                $$ = 1;
                table = add_identifier(table, identifier_parse($1), $3);
            }
            
         }
         | IDENTIFIER OPEN_PAR CLOSE_PAR DOT 
         {
            struct List * id = check_identifier(table, identifier_parse($1));
            $$ = 1;
            table = add_identifier(table, identifier_parse($1), 0);
            
         }
         | IDENTIFIER OPEN_PAR CLOSE_PAR DEFINE STATEMENTS DOT
         {
            struct List * id = check_identifier(table, identifier_parse($1));
            if ($5 == 3)
            {
                $$ = 3;
            }
            else
            {
                $$ = 1;
                table = add_identifier(table, identifier_parse($1), 0);
            }
         }
;

ARGUMENTS: ARGUMENTS COMMA ARGUMENT { $$ = $1 + 1; }
         | ARGUMENT                 { $$ = 1; }
;

ARGUMENT: VARIABLE { $$ = 0; }
        | NUMBER   { $$ = 0; }
        | STRING   { $$ = 0; }
        | LIST     { $$ = 0; }
;

LIST: OPEN_BRC CLOSE_BRC { $$ = 0; }
    | OPEN_BRC SEQUENCE CLOSE_BRC { $$ = 0; }
;
    
SEQUENCE: SEQUENCE COMMA TERM { $$ = 0; }
        | TERM                { $$ = 0; }
;

TERM: NUMBER   { $$ = 0; }
    | STRING   { $$ = 0; }
    | VARIABLE { $$ = 0; }
    | LIST     { $$ = 0; }
; 

STATEMENTS: STATEMENTS COMMA STATEMENT { if ($$ != 3) $$ = $3; }
          | STATEMENT                  { $$ = $1; }
;

STATEMENT: IDENTIFIER OPEN_PAR ARGUMENTS CLOSE_PAR 
         {
            struct List * id = check_identifier(table, identifier_parse($1));
            if (!id)
            {
                $$ = 3;
                yyerror("%s", "Using undefined predicate.");
            }
            else
            {
                if ($3 == id->args_count)
                {
                    $$ = 2;
                }
                else
                {
                    $$ = 3;
                    yyerror("%s", "Wrong arguments number.");
                }
            }
         }
         | WRITE OPEN_PAR SEQUENCE CLOSE_PAR               { $$ = 2; }
         | LINE                                            { $$ = 2; }
         | CUT                                             { $$ = 2; }
         | SUCC OPEN_PAR VARIABLE COMMA VARIABLE CLOSE_PAR { $$ = 2; } 
;

GOALS: GOALS GOAL { if ($$ != 3) $$ = $2; }
     | GOAL       { $$ = $1; }
     |            { $$ = 0; } 
;

GOAL: INIT OPEN_PAR STATEMENT CLOSE_PAR DOT { $$ = $3; } ;
%%
