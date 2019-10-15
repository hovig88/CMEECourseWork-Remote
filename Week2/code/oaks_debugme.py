#!/usr/bin/env python3

""" This Python program loops over the TestOaksData.csv file and writes the tree 
species that belong to the oak tree family into a new file JustOaksData.csv """

__appname__ = 'oaks_debugme.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import csv
import sys
import doctest

## constants ##

## functions ##

# This function checks if the tree is an oak
def is_an_oak(name):
    """ Returns True if name starts with 'quercus' 

    >>> is_an_oak('quercus cerris')
    True

    >>> is_an_oak('Quercus cerris')
    True

    >>> is_an_oak('Fagus sylvatica')
    False

    >>> is_an_oak('Quercuss cerris')
    False

    >>> is_an_oak('Quercusus cerris')
    False

    """
    return name.lower().split()[0] == 'quercus'
    #if there is a typo, this function does not accept it

def main(argv):
    """ This function prints out pairs of [Genus , species], 
    specifying the ones that are oaks. It also outputs the 
    ones that are oaks into a new file """ 

    f = open('../data/TestOaksData.csv','r')
    g = open('../results/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    #oaks = set() - this part is commented out because it is not used
    for row in taxa:
        if 'Genus' in row:
            csvwrite.writerow([row[0], row[1]])
            continue
        print(row)
        print("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    
    
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()   # To run with embedded tests
