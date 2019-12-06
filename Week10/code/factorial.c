#include <stdio.h>

int calculate_factorial(int x)
{
    int y;
    
    while(x){
        y = calculate_factorial(x-1);
        return x * y;
    }

    return 1;
}

int main (void)
{
    int a = 5;
    int b = 0;

    b = calculate_factorial(a);
    printf("Factorial of %i is: %i\n", a, b);
    return 0;
}