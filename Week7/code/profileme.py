#!/usr/bin/env python3

"""Some functions to explain the concept of profiling in Python"""

__appname__ = 'LV1.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## functions ##
def my_squares(iters):
    """This function takes an integer n and returns the 
    square of each all integers within the range of n."""
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """This function takes an integer n and a string and 
    returns n repeats of that string separated by commas."""
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """This function prints an integer n and a string, and then uses them to perform the functions 
    my_squares and my_join. To see their functionality, please refer to their documentations."""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")
