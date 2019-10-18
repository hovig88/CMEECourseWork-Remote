#!/usr/bin/env python3

"""This Python script takes two explicit input files and saves their best 
alignment along with the corresponding score in a text file. If there are 
multiple best alignments, then it saves them all in separate text files"""

__appname__ = 'align_seqs_better.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import sys # module to interface our program with the operating system
from align_seqs import calculate_score as cs
from align_seqs_fasta import inputs
import pickle

## constants ##

seq1, seq2 = inputs(sys.argv)

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
seq1 = seq1.readlines()[1:]
seq2 = seq2.readlines()[1:]

seq1 = ''.join(seq1)
seq2 = ''.join(seq2)

seq1 = seq1.replace("\n", "")
seq2 = seq2.replace("\n", "")

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = cs(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
    best_align = my_best_align
    seq1 = s1
    best_score = my_best_score
    with open("../results/best_result_better.txt", 'w') as file:
        file.write("The best alignments are: " + '\n' + best_align + '\n' 
        + seq1 + '\n' + "Score: " + str(best_score) + '\n') 
