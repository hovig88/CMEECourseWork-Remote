#!/usr/bin/env python3

"""Some functions showing different usage of conditionals with numerical operations"""

__appname__ = 'cfexercises1.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import sys # module to interface our program with the operating system

## constants ##

## functions ##

def foo_1(x):
    """This function takes an input number and returns its 0.5th power"""
    return x ** 0.5

def foo_2(x, y):
    """This function takes two input numbers and returns the higher one"""
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    """This function takes three input numbers and switches their values 
    when the one on the left is higher than the one on the right"""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    """This function takes an input number and computes the factorial 
    by multiplying consecutive numbers in an increasing order"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x): # a recursive function that calculates the factorial of x
    """This function takes an input number and computes the factorial recursively"""
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x): # Calculate the factorial of x in a different way
    """This function takes an input number and computes the factorial 
    by multiplying consecutive numbers in a decreasing order"""
    facto = 1
    while x>= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print("foo_1 test input: 2")
    print("foo_1 test result: " + str(foo_1(2)) + "\n")
    print("foo_2 test inputs: 33, 23")
    print("foo_2 test result: " + str(foo_2(33, 23)) + "\n")
    print("foo_3 test input: [120, 5, 2]")
    print("foo_3 test result: " + str(foo_3(120, 5, 2)) + "\n")
    print("foo_4 test input: 4")
    print("foo_4 test result: " + str(foo_4(4)) + "\n")
    print("foo_5 test input: 3")
    print("foo_5 test result: " + str(foo_5(3)) + "\n")
    print("foo_6 test input: 5")
    print("foo_6 test result: " + str(foo_6(5)))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
