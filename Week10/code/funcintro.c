#include <stdio.h>

int add_integers(int, int); // A function prototype
int add_four_integers(int, int, int, int); // Prototype with optional variable names

int add_four_integers(int a, int b, int c, int d)
{
    int result = 0;
    result = add_integers(a, b) + add_integers(c, d);

    return result;
}

int add_integers (int x, int y)
{
    int result = 0;

    result = x + y;

    return result;
    // return x + y; // Also possible    
}

int main (void)
{
    int a = 5;
    int b = 6;
    int result = 0;

    result = add_integers(a, b);

    printf("Sum of a and b: %i\n", result);
    printf("Sum of result and b: %i\n", add_integers(result, b));

    return 0;
}