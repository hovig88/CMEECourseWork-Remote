#include <stdio.h>

int main (void)
{
    char charray[] = {'A', ' ', 's', 't', 'r', 'i', 'n', 'g', '!', '\0'};
    char string1[] = "A string!";

    printf("The 9th element of charray: %i\n", charray[9]);
    printf("The 9th element of string1: %i\n", string1[9]);

    return 0;
}