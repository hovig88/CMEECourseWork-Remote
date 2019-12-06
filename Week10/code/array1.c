#include <stdio.h>

int main (void)
{
    int i = 0; // Interpretation: reserve memory with a read/write size of an int
    char c = 'c'; // Reserve memory with a read/write size of a char
    double pi = 3.14; // Reserve memory with a read/write size of double

    int intarray[4]; // Explicitly sized declaration
    int intarray2[] = {0, 0, 1, 4};

    int matrix[2][4]; // Matrices can be specified
    int nmatrix[2][4][3]; // Matrices can be n-dimensional

    // Reading and writing from/to arrays:

    // Example: read from an unitialised array:
    // Reading/writing in C is zero-based:

    j = intarray[0];
    printf("intarray at position 0: %i\n", j);

    return 0;
}