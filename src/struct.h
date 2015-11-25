#pragma once

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
    int state;
    int line;
    int args_count;
    int def_count;
    struct list * next;
}

struct Pair
{
    char * first;
    char * second;
}

static struct List * table = 0;

struct List * add_identifier   (struct List * list, char * name);
struct List * check_identifier (struct List * list, char * name);
struct List * delete_table     (struct List * list);
char        * take_name        (char * string);
