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

# plotting figure 1
f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density')
p.plot(t, pops[:,1], 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')

f1.savefig('../results/LV_model.pdf')

# plotting figure 2
f2 = p.figure()
p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')

f2.savefig('../results/LV_model2.pdf')
