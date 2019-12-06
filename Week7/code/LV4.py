#!/usr/bin/env python3

"""A version of the discrete-time model, implemented in LV3.py, simulation with a random gaussian fluctuation in resource's growth rate at each time-step"""

__appname__ = 'LV4.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import scipy as sc
import numpy as np
import matplotlib.pylab as p
import matplotlib.pyplot as plt
import sys

## functions ##
def inputs(args):
    """This function makes sure the script can handle 
    inputs, even if they are less than what is required."""
    if(len(args)) == 1:
        r = 1.
        a = 0.1
        z = 1.5
        e = 0.8
    elif(len(args)) == 2:
        r = float(args[1])
        a = 0.1
        z = 1.5
        e = 0.8
    elif(len(args)) == 3:
        r = float(args[1])
        a = float(args[2])
        z = 1.5
        e = 0.8
    elif(len(args)) == 4:
        r = float(args[1])
        a = float(args[2])
        z = float(args[3])
        e = 0.8
    elif(len(args)) >= 5:
        r = float(args[1])
        a = float(args[2])
        z = float(args[3])
        e = float(args[4])

    return r, a, z, e

def RC_t(t, R, C):
    """This function calculates a discrete-time version of the Lotka-Volterra model with a random gaussian fluctuation in resource's growth rate at each time-step"""
    for i in np.arange(0, len(t)-1):
        eps = np.random.normal(scale = 0.1)    
        R[i+1] = R[i] * (1 + (r + eps) * (1 - R[i] / K) - a * C[i])
        C[i+1] = C[i] * (1 - z + e * a * R[i])
    return sc.array([R, C])

def plots(t, R, C):
    """This function creates two plots which show consumer-resource population dynamics:
        - Plot 1: Resource and Consumer population density as a function of time
        - Plot 2: Resource density as a function of consumer density"""
    # creating a new figure
    f1 = p.figure()

    # creating plot 1
    plt.subplot(2, 1, 1)
    plt.plot(t, R, 'g-', label='Resource density')
    plt.plot(t, C, 'b-', label='Consumer density')
    plt.grid()
    plt.legend(loc='best')
    plt.xlabel('Time')
    plt.ylabel('Population density')
    plt.title('Consumer-Resource population dynamics \n r = %1.2f' %r + ', a = %1.2f' %a + ', z = %1.2f' %z + ', e = %1.2f' %e + ', K = %d' %K)

    # creating plot 2
    plt.subplot(2, 1, 2)
    plt.plot(R, C, 'r-')
    plt.grid()
    plt.xlabel('Resource density')
    plt.ylabel('Consumer density')

    # adjust subplots to avoid overlaps
    plt.tight_layout()

    return f1

## constants ##
r, a, z, e = inputs(sys.argv)
K = 35
t = sc.linspace(0, 15, 200) # dividing the range 0-15 into 200 equal intervals
R = sc.zeros(len(t), dtype = np.float64) # initialize the vector for the resource population abundance curve
R[0] = 10 # initialize the first value of the resource population abundance curve
C = sc.zeros(len(t), dtype = np.float64) # initialize the vector for the consumer population abundance curve
C[0] = 5 # initialize the first value of the consumer population abundance curve

## main function ##
def main(argv):
    """The main function runs 2 important tasks:
        - runs the discrete-time version of the Lotka-Volterra model with gaussian fluctuation in resource's growth rate at each time-step
        - creates and saves plots to a pdf file"""

    if(len(sys.argv)) == 1:
        print("No input parameters provided... assigning default values...")
    elif(len(sys.argv)) == 2:
        print("r parameter provided... assigning default values for a, z, and e...")
    elif(len(sys.argv)) == 3:
        print("r and a parameters provided... assigning default values for z and e...")
    elif(len(sys.argv)) == 4:
        print("r, a, and z parameters provided... assigning default values for e...")
    elif(len(sys.argv)) >= 5:
        print("Sufficient number of parameters provided... taking first four values...")
    
    # run the model
    print("Running the model...")
    RC_t(t, R, C)

    # create and save plots to pdf
    print("Creating and saving plots to pdf...")
    plots(t, R, C).savefig('../results/LV4_model.pdf')

    print("Done!")

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
