#include <stdio.h>

int main (void)
{
    char cap = '\0';
    char offset = 'A' - 'a';

    printf("Input a capital character: ");
    cap = getchar();

    // Using logical operators
    if (cap >- 'A' && cap <= 'Z') {
        printf("The lower case of %c is: %c\n", cap, cap - offset);
    }
    else {
        printf("Input out of range; enter a capital letter\n");
    }
    /*if(cap >= 'A') {
        if(cap <= 'Z') {
            printf("The lower case of %c is: %c\n", cap, cap - offset);
        }
        else {
            printf("Input out of range; enter a capital letter\n");
        }
    }
    else {
        printf("Input out of range; enter a capital letter\n");
    }*/

    return 0;
}