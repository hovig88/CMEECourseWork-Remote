#!/usr/bin/env python3

"""small script to explain the concept of sys.argv"""

__appname__ = 'sysargv.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import sys

print(sys.argv)
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: ", str(sys.argv))
