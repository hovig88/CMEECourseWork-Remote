#!/usr/bin/env python3

"""A python version of Vectorize1.R"""

__appname__ = 'Vectorize1.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import numpy as np
import time
import sys

## functions ##
def SumAllElements(M):
    """This function sums all elements of a matrix"""
    Dimensions = M.shape # returns dimensions of matrix
    Tot = 0
    for i in np.arange(Dimensions[0]): # loop through the rows
        for j in np.arange((Dimensions[1])): # loop through the columns
            Tot = Tot + M.item(i, j) # add value of element to total sum of elements

    return(Tot)

## main function ##
def main(argv):
    """The main function compares the computational speed of the SumAllElements 
    function and the built-in numpy matrix sum function."""

    # initialize a matrix
    M = np.random.random((1000, 1000))
    M = np.matrix(M)
    
    # comparing computational speeds
    print("Using loops, the time taken is:")
    start_time1 = time.time()
    SumAllElements(M)
    elapsed_time1 = time.time() - start_time1
    print(round(elapsed_time1, 3))

    print("Using the in-built vectorized function, the time taken is:")
    start_time2 = time.time()
    np.matrix.sum(M)
    elapsed_time2 = time.time() - start_time2
    print(round(elapsed_time2, 3))

    # saving time values to be used later in the run_Vectorize.sh bash script
    f = open("../data/Vectorize1_py.txt", "w")
    f.write(str(round(elapsed_time1, 3)))
    f.write("\n")
    f.write(str(round(elapsed_time2, 3)))
    f.write("\n")
    f.close()

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
