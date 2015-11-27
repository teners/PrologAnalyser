#include <string.h>
#include <malloc.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdarg.h>

extern int yylineno;

void yyerror(char *s, ...);

struct List
{
    char * name;
    int args_count;
    struct list * next;
};

static struct List * table = 0;

struct List * add_identifier   (struct List * list, char * name, int args);
struct List * check_identifier (struct List * list, char * name);
struct List * delete_table     (struct List * list);
