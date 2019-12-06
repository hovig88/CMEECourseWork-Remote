#!/usr/bin/env python3

"""small script that includes a bug that needs to be fixed"""

__appname__ = 'debugme.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

def makeabug(x):
    """This function creates a bug and handles it with an error message."""
    y = x**4
    z = 0
    try:
        y = y/z
    except ZeroDivisionError:
        print("ZeroDivisionError: float division by zero")
    return y

makeabug(25)