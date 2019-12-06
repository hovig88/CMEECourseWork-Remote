#!/usr/bin/env python3

"""This Python script takes two explicit input files and saves their 
best alignment along with the corresponding score in a text file."""

__appname__ = 'align_seqs_fasta.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import sys # module to interface our program with the operating system
from align_seqs import calculate_score as cs

## constants ##
def inputs(args):
    """ This function makes sure the script can handle 
    inputs, whether there are none, 1, 2, or more"""
    if(len(args)) == 1:
        seq1 = open("../data/fasta/407228326.fasta", "r")
        seq2 = open("../data/fasta/407228412.fasta", "r")
    elif(len(args)) == 2:
        seq1 = open(args[1], "r")
        seq2 = open("../data/fasta/407228326.fasta", "r")
    elif(len(args)) == 3:
        seq1 = open(args[1], "r")
        seq2 = open(args[2], "r")
    elif(len(args)) >= 4:
        seq1 = open(args[1], "r")
        seq2 = open(args[2], "r")
    
    return seq1, seq2

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

def main(argv):
    """ Finds the best alignment and computes the correspondong best score """
    
    if(len(sys.argv)) == 1:
        print("No input files provided... taking default files...")
    elif(len(sys.argv)) >= 4:
        print("More than 2 input files provided... taking first two...")
    
    # now try to find the best match (highest score) for the two sequences
    my_best_align = None
    my_best_score = -1

    print("Computing score of best alignment...")
    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = cs(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    best_align = my_best_align
    seq1 = s1
    best_score = my_best_score

    print("Saving the result in a text file...")
    with open("../results/best_result_fasta.txt", 'w') as file:
        file.write("The best alignment is: " + '\n' + best_align + '\n' 
        + seq1 + '\n' + "Score: " + str(best_score) + '\n') 

    print("Done!")

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
