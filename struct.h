#include <string.h>
#include <malloc.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdarg.h>

extern int yylineno;

void yyerror(char *s, ...);

struct list
{
    char * name;
    int state;
    int line;
    int args_count;
    struct list * next;
}
