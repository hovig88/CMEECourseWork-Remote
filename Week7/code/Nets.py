#!/usr/bin/env python3

"""A python version of the network created in Nets.R"""

__appname__ = 'Nets.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import networkx as nx
import numpy as np
import matplotlib.pyplot as p
from matplotlib.lines import Line2D
import csv

def csvToList(filename):
    """This function opens a csv file and returns each line in that file in a list"""
    with open(filename) as csv_file:
        csvread = csv.reader(csv_file, delimiter = ',')

        return list(csvread)

## EDGES ##
links = np.array(csvToList('../data/QMEE_Net_Mat_edges.csv'))
links_m = np.array(links[1:, :], dtype='i4')
links_mat = np.matrix(links_m) # convert to matrix to be able to calculate the adjacency list

# calculating the adjacency list
AdjList_temp = np.nonzero(links_mat)
AdjList = np.array([tuple(i) for i in np.transpose(AdjList_temp)])

ids = np.unique(AdjList)

## EDGE WEIGHTS ##
weights = np.array([links_mat[i,j] for i,j in AdjList]) # extracts the non-zero values in the matrix
width = 1 + weights / 10 # setting edge width based on weight (PhD Students)

## NODES ##
nodes = csvToList('../data/QMEE_Net_Mat_nodes.csv')

# color-coding the nodes
nodes_color = np.array([nodes[i+1][1] for i in range(len(nodes)-1)]) # initialize as list first in order to be able to append 
nodes_color[nodes_color == 'University'] = 'blue'                                                                                                                                                                          
nodes_color[nodes_color == 'Hosting Partner'] = 'green'                                                                                                                                                                  
nodes_color[nodes_color == 'Non-Hosting Partners'] = 'red'
nodes_color = nodes_color.tolist()

## NODE LABELS ##

labels = [nodes[i+1][0] for i in range(len(nodes)-1)]
labels_dict = {i: labels[i] for i in range(len(labels))}

## NETWORK PLOT ##
f1 = p.figure()

G = nx.DiGraph()
pos = nx.spring_layout(ids, seed = 100) # set seed to avoid getting different versions of the network everytime the script executed
G.add_nodes_from(ids)
G.add_edges_from(tuple(AdjList))
nx.draw_networkx(G, pos, width = width, arrows = True, arrowsize = 1, with_labels = True,
                node_size = 1800, node_color = nodes_color, edge_color = 'grey',
                labels = labels_dict, font_size = 10)

# creating legends
legend_elements = [Line2D([0], [0], marker = 'o', color = 'black', label = 'University', markerfacecolor = 'b', markersize = 10),
                   Line2D([0], [0], marker = 'o', color = 'black', label = 'Hosting Partner', markerfacecolor = 'g', markersize = 10),
                   Line2D([0], [0], marker = 'o', color = 'black', label = 'Non-Hosting Partners', markerfacecolor = 'r', markersize = 10)]

# adding legends to the figure
p.legend(handles = legend_elements, loc = 'upper left', framealpha = 0, fontsize = 'x-small')

# removing frame
p.axis('off')

# saving figure to a svg file
f1.savefig('../results/Nets.svg')

