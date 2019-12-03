#include <stdio.h>

int main (void)
{
    char x = 'A';
    char y = x + 32;

    printf("The lowercase character of %c is %c.\n", x, y);

    return 0;
}