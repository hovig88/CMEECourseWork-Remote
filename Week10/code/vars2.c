#include <stdio.h>

int main (void)
{
    int a = 7;
    int b = 2;
    float c = 0;
    int d = 0;
    int e = 0;

    c = (float)7/2;
    d = a/b;
    e = (float)7/2;

    printf("Result of literal expression: %f\n", c);
    printf("Result of variable expression: %i\n", d);
    printf("Result of variable expression passed into int: %i\n", e);

    return 0;
}