#!/usr/bin/env python3

"""Building a food web network by generating an adjacency list and a matrix of
species names/ids and properties, and saving the network plot to a pdf file"""

__appname__ = 'DrawFW.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

## functions ##
def GenRdmAdjList(N = 2, C = 0.5):
    """This function generates a random adjacency list of who eats whom: a matrix
    with consumer name/id in 1st column, and resource name/id in 2nd column."""
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C: # take a uniform random number between 0 and 1 and see if it is less than C
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
                ALst.append(Lnk)
    return ALst

MaxN = 30
C = 0.75

AdjL = sc.array(GenRdmAdjList(MaxN, C))
AdjL

Sps = sc.unique(AdjL) # get species ids

SizRan = ([-10,10]) #use log10 scale
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
Sizs

p.hist(Sizs) #log10 scale
p.hist(10 ** Sizs) #raw scale

# plotting the network
f1 = p.figure()

f1, ax = p.subplots() # this is a way to include axes
# In the current version of the networkx package, the axes 
# are turned off by default because they are not that meaningful 
# when we're dealing with networks
pos = nx.circular_layout(Sps)
G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL))
NodSizs = 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs))
nx.draw_networkx(G, pos, node_size = NodSizs, node_color = "red", ax = ax)
ax.tick_params(left = True, bottom = True, labelleft = True, labelbottom = True)

# saving the plot to a pdf file
f1.savefig('../results/DrawFW.pdf')
