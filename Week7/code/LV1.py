#!/usr/bin/env python3

"""Calculating the consumer-resource population growth rate and producing 
two different plots using both consumer and resource density curves"""

__appname__ = 'LV1.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p
import matplotlib.pyplot as plt

## functions ##
def dCR_dt(pops, t=0):
    """This function returns the growth rate of consumer 
    and resource population at any given time step."""
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C

    return sc.array([dRdt, dCdt])

## constants ##
r = 1.
a = 0.1
z = 1.5
e = 0.75
t = sc.linspace(0, 15, 1000)
R0 = 10
C0 = 5
RC0 = sc.array([R0, C0])

# creating ordinary differential equations
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
print(infodict['message'])

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
plt.title('Consumer-Resource population dynamics')

# creating plot 2
plt.subplot(2, 1, 2)
plt.plot(pops[:,0], pops[:,1], 'r-')
plt.grid()
plt.xlabel('Resource density')
plt.ylabel('Consumer density')

# adjust subplots to avoid overlaps
plt.tight_layout()

# saving the figure to a pdf file
f1.savefig('../results/LV1_model.pdf')
print("Succesfully created and saved plots!")
