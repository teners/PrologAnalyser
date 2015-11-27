#include "struct.h"

void yyerror(char * start, ...)
{
    va_list error_list;
    va_start(error_list, start);
    
    fprintf(stderr, "\nerror: ");
    vfprintf(stderr, start, error_list);
    fprintf(stderr, " on %d line\n", yylineno);
}

struct List * add_identifier(struct List * list, char * name, int args)
{
    struct List * ptr = malloc(sizeof(struct List));
    ptr->name = name;
    ptr->next = 0;
    ptr->args_count = args;
    if (!list)
    {
        return ptr;
    }
    else
    {
        struct List * iterator = list;

        while (iterator->next)
        {
            iterator = iterator->next;
        }

        iterator->next = ptr;

        return list;
    }
}

struct List * check_identifier(struct List * list, char * name)
{
    struct List * iterator = list;

    while (iterator && strcmp(name, iterator->name))
    {
       iterator = iterator->next; 
    }

    return iterator;
}

struct List * delete_table(struct List * list)
{
    struct List * ptr = list;

    while (list)
    {
        list = list->next;
        free(ptr->name);
        free(ptr);
        ptr = list;
    }
    
    return list;
}

int main(int argc, char ** argv)
{
    return yyparse();
}
