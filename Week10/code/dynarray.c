#include <stdlib.h>
#include <stdio.h>

int main (void)
{
    int numsites = 30;
    int *sppcounts = NULL;

    sppcounts = (int*)malloc(numsites * sizeof(int));
    // Check that malloc succeeded and returned a valid pointer
    if (sppcounts == NULL) {
        printf("Insufficient memory for operation!\n");
        return 1;
    }

    sppcounts[20] = 44;

    int i = 0;
    for (i = 0; i < numsites; ++i) {
        printf("data in site %i is: %i\n", i, *(sppcounts + i));
    }

    // Free memory, return it to the system before overwriting the
    // pointer to that memory:
    free(sppcounts); // every time you memory allocate, you have to clean it afterwards to avoid slowing down
    sppcounts = NULL;

    sppcounts = (int*)calloc(numsites, sizeof(int));
    if (sppcounts == NULL) {
        printf("Insufficient memory for operation!\n");
        return 1;
    }

    sppcounts[20] = 44;

    for (i = 0; i < numsites; ++i) {
        printf("data in site %i is: %i\n", i, sppcounts[i]);
    }

    free(sppcounts);
    sppcounts = NULL;

    return 0;
}