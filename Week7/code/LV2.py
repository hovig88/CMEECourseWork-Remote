#!/usr/bin/env python3

"""Similar functionality as LV1.py with the addition of prey density dependence in the model"""

__appname__ = 'LV2.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import scipy as sc
import scipy.integrate as integrate
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
        e = 0.75
    elif(len(args)) == 2:
        r = float(args[1])
        a = 0.1
        z = 1.5
        e = 0.75
    elif(len(args)) == 3:
        r = float(args[1])
        a = float(args[2])
        z = 1.5
        e = 0.75
    elif(len(args)) == 4:
        r = float(args[1])
        a = float(args[2])
        z = float(args[3])
        e = 0.75
    elif(len(args)) >= 5:
        r = float(args[1])
        a = float(args[2])
        z = float(args[3])
        e = float(args[4])

    return r, a, z, e

def dCR_dt(pops, t=0):
    """This function returns the growth rate of consumer 
    and resource population at any given time step."""
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R / K) - a * R * C
    dCdt = -z * C + e * a * R * C

    return sc.array([dRdt, dCdt])

def plots(t, pops):
    """This function creates two plots which show consumer-resource population dynamics:
        - Plot 1: Resource and Consumer population density as a function of time
        - Plot 2: Resource density as a function of consumer density"""
    # creating a new figure
    f1 = p.figure()

    # creating plot 1
    plt.subplot(2, 1, 1)
    plt.plot(t, pops[:,0], 'g-', label='Resource density')
    plt.plot(t, pops[:,1], 'b-', label='Consumer density')
    plt.grid()
    plt.legend(loc='best')
    plt.xlabel('Time')
    plt.ylabel('Population density')
    plt.title('Consumer-Resource population dynamics \n r = %1.2f' %r + ', a = %1.2f' %a + ', z = %1.2f' %z + ', e = %1.2f' %e + ', K = %d' %K)

    # creating plot 2
    plt.subplot(2, 1, 2)
    plt.plot(pops[:,0], pops[:,1], 'r-')
    plt.grid()
    plt.xlabel('Resource density')
    plt.ylabel('Consumer density')

    # adjust subplots to avoid overlaps
    plt.tight_layout()

    return f1

## constants ##
r, a, z, e = inputs(sys.argv)
K = 50
t = sc.linspace(0, 25, 1000) # dividing the range 0-25 into 1000 equal intervals
R0 = 10 # initialize the first value of the resource population abundance curve
C0 = 5 # initialize the first value of the consumer population abundance curve
RC0 = sc.array([R0, C0])

## main function ##
def main(argv):
    """The main function runs 2 important tasks:
        - creates ordinary differential equations
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

    # creating ODEs
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
    print(infodict['message'])

    # printing the values where the resource and consumer population density curves converge to
    if (pops[len(pops)-1][0] != 0) and (pops[len(pops)-1][1] != 0):
        print('The final value of the resource population density curve is %d' %pops[len(pops)-1][0])
        print('The final value of the consumer population density curve is %d' %pops[len(pops)-1][1])
    
    # saving the figure to a pdf file
    plots(t, pops).savefig('../results/LV2_model.pdf')

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
