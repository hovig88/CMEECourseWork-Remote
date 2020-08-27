#!/usr/bin/env python3

""""""

__appname__ = 'simulation_method_dep.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## IMPORTS ##
import numpy as np
from scipy.linalg import expm as expm
import dendropy

# character states
states = np.array([0, 1])

### INPUT ###
s = "((A:0.2,B:0.05):0.025, (C:0.05,D:0.2):0.025);"
tree = dendropy.Tree.get(data=s, schema="newick")

val = 0
for nd in tree:
    if nd.taxon == None:
        nd.taxon = dendropy.datamodel.taxonmodel.Taxon(val)
        val = val + 1
# store nodes and descendents in postorder
nodes = np.array([dendropy.datamodel.treemodel.Node()] * len(tree.nodes()))
child_nodes = np.array([dendropy.datamodel.treemodel.Node()] * len(tree.nodes()))
parent_nodes = np.array([dendropy.datamodel.treemodel.Node()] * len(tree.nodes()))

for idx, nd in enumerate(tree.postorder_node_iter()):
    nodes[idx] = nd
    child_nodes[idx] = nd.child_nodes()
    parent_nodes[idx] = nd.parent_node

# EDGES
edge_lengths = np.zeros(len(tree.nodes()))
for idx, edge in enumerate(tree.postorder_edge_iter()):
    edge_lengths[idx] = edge.length

# rate matrix
Q = np.array([[-3,3],[3,-3]])
br_length = edge_lengths

# preallocate probability matrix
P = np.zeros((len(states)*len(br_length), len(states)))

# calculate probability matrix at each lineage
for i in range(len(tree.nodes())-1):
    P[len(states)*i:len(states)*(i+1)] = expm(Q*br_length[i])
# fill last trans matrix with ones on the diagonal
np.fill_diagonal(P[len(states)*(len(br_length)-1):len(states)*len(br_length)], 1)

# state frequencies
state_freq = np.array([0.5,0.5])

# characters
nchar = 500

# number of simulations
nsim = 1000

# simulations
for sim in range(nsim):
    # initialize sampled data
    sampled_data = np.zeros((len(tree.nodes()), nchar))

    # determine fraction of dependent characters
    frac = 0.2

    independent_chars = int(nchar - (nchar * frac))
    dependent_chars = int(nchar - independent_chars)

    index = np.zeros(nchar)
    index[0:independent_chars] = -1

    for i in range(len(index)):
        if index[i] != -1:
            index[i] = int(np.random.choice(independent_chars, 1))

    index_dep = index[independent_chars:nchar]

    # sampled character states at root
    sampled_data[len(tree.nodes())-1][0:independent_chars] = np.random.choice(states, size = independent_chars, p = state_freq)

    # sample data based on parent nodes
    for i in range(len(tree.nodes())-1)[::-1]:

        idx_parent = np.where(nodes == parent_nodes[i])[0][0]
        parent_data = sampled_data[idx_parent]

        for j in range(independent_chars):

            trans_matrix = P[len(states)*i:len(states)*(i+1)][int(parent_data[j])]
            sampled_data[i][j] = np.random.choice(states, size = 1, p = trans_matrix)

    ## MAPPING MUTATIONAL HISTORIES ##

    mutational_histories = []

    for i in range(len(tree.nodes())-1):
        for j in range(independent_chars): 
            
            # store child and parent states
            child_state = int(sampled_data[i][j])
            parent_state = int(sampled_data[np.where(nodes == parent_nodes[i])[0][0]][j])
            
            # store the rate in a variable to be used for sampling rate of mutations from an exponential distribution
            rate = Q[parent_state][parent_state] * -1
            
            # initialize vector for simulation of the mutations
            mutations = np.array([])
            mutations = np.append(mutations, parent_state)
            while mutations[len(mutations)-1] != child_state or len(mutations) == 1: # loops until last mutated state is equal to the child state. The second condition is to make sure the 'mutations' vector goes through the loop
                
                # initialize waiting time
                waiting_time = 0

                # draw the first waiting time
                waiting_time = waiting_time + np.random.exponential(scale = 1/rate)

                while waiting_time < br_length[i]: # loops until total mutation time is more than branch length
                    
                    # simulate a mutation
                    mutations = np.append(mutations, states[states != mutations[len(mutations)-1]])
                    waiting_time = waiting_time + np.random.exponential(scale = 1/rate)

                if len(mutations) == 1: # if the first waiting time was more than branch length, then no mutations occured between the parent and child states
                    mutations = np.append(mutations, child_state)
                    break
            
            # store the mutation of each character at each lineage in a variable
            mutational_histories.append(mutations)    

    ##################################

    ## DEPENDENT CHARACTERS ##

    # convert elements in sampled data into strings to enable entry of missing data 
    sampled_data = sampled_data.astype(int).astype(str)

    # sample dependent character states at root
    for i in range(dependent_chars):
        if sampled_data[len(tree.nodes())-1][int(index_dep[i])] == '0':
            sampled_data[len(tree.nodes())-1][i+independent_chars] = '-'
        else:
            sampled_data[len(tree.nodes())-1][i+independent_chars] = str(np.random.choice(states, size = 1, p = state_freq)[0])

    # sample dependent character states at the rest of the nodes
    for i in range(len(tree.nodes())-1):
        for j in range(dependent_chars):

            mutational_history = mutational_histories[independent_chars*i:independent_chars*(i+1)][int(index_dep[j])].astype(int).astype(str)

            for k in range(len(mutational_history)):
                if mutational_history[k] == '0':
                    sampled_data[i][j+independent_chars] = '-'
                else:
                    sampled_data[i][j+independent_chars] = str(np.random.choice(states, size = 1, p = state_freq)[0])

    ##########################

    # generating nexus files

    simulated_data = sampled_data[np.where(np.in1d(nodes,tree.leaf_nodes()))[0]]
    ntax = len(tree.leaf_nodes())

    # NEXUS file generator
    line1 = "#NEXUS\n\n"
    line2 = "BEGIN DATA;\n"
    line3 = "FORMAT DATATYPE = STANDARD MISSING = - SYMBOLS = \" 0 1 \"\n"
    line4 = ";\n\n"
    line5 = "MATRIX\n"
    line6 = ";\n"
    line7 = "END;\n"

    f = open("dep_%d.nex" %sim, "w+")
    f.writelines([line1, line2])
    f.write("DIMENSIONS NTAX=%d NCHAR=%d;\n" % (ntax, nchar))
    f.writelines([line3, line4, line5])

    for i in range(ntax):
        f.write("taxon_%d" %(i+1) + " " + ''.join(simulated_data[i]) + "\n")

    f.writelines([line6, line7])

    f.close()