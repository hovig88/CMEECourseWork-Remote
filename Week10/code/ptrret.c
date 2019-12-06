#include <stdlib.h>
#include <stdio.h>

int *pos_first_odd(const int*, const unsigned long);

int *pos_first_odd(const int integers[], const unsigned long size)
{
    unsigned long int c = 0;
    int* ret = NULL; 

    // Implementation code
    ret = (int*)integers;

    while (*ret % 2 == 0 && c < size) {
        ++ret;
        ++c;
    }

    if (c == size) {
        --ret;
        if ((*ret % 2) == 0) {
            return NULL;
        }
    }
    return ret;
}

int main (void)
{
    int *res = NULL;
    int intarray[] = {2, 4, 10, 21, 30};

    res = pos_first_odd(intarray, 5);

    printf("res now points to: %i\n", *res);

    --(*res);

    res = pos_first_odd(intarray, 5);
    if (res != NULL) {
        printf("res now points to: %i\n", *res);
    }

}