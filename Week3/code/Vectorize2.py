#!/usr/bin/env python3

"""A python version of Vectorize2.R"""

__appname__ = 'Vectorize2.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import scipy as sc
import numpy as np
import time
import sys

## functions ##
def stochrick (p0 = np.random.uniform(0.5,1.5,1000), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    """Runs a simulation of a stochastic Ricker model using nested for loops"""

    #initialize
    N = sc.zeros((numyears, len(p0)))
    N[0,:] = p0

    for pop in range(len(p0)): # loop through the populations
        for yr in np.arange(numyears-1)+1: # loop through the years
            N[yr,pop] = N[yr-1, pop] * np.exp(r * (1 - N[yr-1, pop] / K) + np.random.normal(0, sigma, 1))

    return(N)

def stochrickvect (p0 = np.random.uniform(0.5,1.5,1000), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    """Runs a simulation of a stochastic Ricker model using vectorization"""
    
    #initialize
    N = sc.zeros((numyears, len(p0)))
    N[0,:] = p0

    for yr in np.arange(numyears-1)+1:
        N[yr,:] = N[yr-1,:] * np.exp(r * (1 - N[yr-1,:] / K) + np.random.normal(0, sigma, 1)) # taking the whole row into consideration instead of row element by element

    return(N)

## main function ##
def main(argv):
    """The main function compares the computational speed of the stochrick 
    and stochrickvect functions."""

    # comparing the computational speeds of the two functions
    print("Using loops, the time taken is:")
    start_time1 = time.time()
    stochrick()
    elapsed_time1 = time.time() - start_time1
    print(round(elapsed_time1, 3))

    print("Using the in-built vectorized function, the time taken is:")
    start_time2 = time.time()
    stochrickvect()
    elapsed_time2 = time.time() - start_time2
    print(round(elapsed_time2, 3))

    # saving time values to be used later in the run_Vectorize.sh bash script
    f = open("../data/Vectorize2_py.txt", "w")
    f.write(str(round(elapsed_time1, 3)))
    f.write("\n")
    f.write(str(round(elapsed_time2, 3)))
    f.write("\n")
    f.close()

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
