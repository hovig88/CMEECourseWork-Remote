import numpy as np
import dendropy

nsim = 1000

# INDEPENDENT CHARACTERS
br_lengths_ind = np.zeros((nsim, 5))

for i in range(nsim):
    tree = dendropy.Tree.get(file=open('ind_%d.tre' %i, 'r'), schema="nexus", rooting="force-unrooted")

    br_length = np.zeros(len(tree.nodes()))

    for idx, edge in enumerate(tree.postorder_edge_iter()): 
        br_length[idx] = edge.length

    br_length[2] = br_length[2]+br_length[5]
    br_length = br_length[:-2]

    br_lengths_ind[i] = br_length

# DEPENDENT CHARACTERS

br_lengths_dep = np.zeros((nsim, 5))

for i in range(nsim):
    tree = dendropy.Tree.get(file=open('dep_%d.tre' %i, 'r'), schema="nexus", rooting="force-unrooted")

    br_length = np.zeros(len(tree.nodes()))

    for idx, edge in enumerate(tree.postorder_edge_iter()): 
        br_length[idx] = edge.length

    br_length[2] = br_length[2]+br_length[5]
    br_length = br_length[:-2]

    br_lengths_dep[i] = br_length