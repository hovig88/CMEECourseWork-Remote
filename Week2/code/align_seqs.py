#!/usr/bin/env python3

"""This Python program takes two DNA sequences as input and saves their best 
alignment along with the corresponding score in a single text file."""

__appname__ = 'align_seqs.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import sys # module to interface our program with the operating system
import csv

## constants ##

with open("../data/seq.csv", 'r') as file:# csv file containing two example sequences
    seq = file.read().replace(',', '').split()

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
l1 = len(seq[0])
l2 = len(seq[1])
if l1 >= l2:
    s1 = seq[0]
    s2 = seq[1]
else:
    s1 = seq[1]
    s2 = seq[0]
    l1, l2 = l2, l1 # swap the two lengths

## functions ##

def calculate_score(s1, s2, l1, l2, startpoint):
    """ This function computes a score by returning the number of matches 
    starting from an arbitrary startpoint (chosen by user) """
    
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

## functions ##

def main(argv):
    """ finds the best alignment and computes the correspondong best score """
    
    # now try to find the best match (highest score) for the two sequences
    my_best_align = None
    my_best_score = -1
    
    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    best_align = my_best_align
    seq1 = s1
    best_score = my_best_score
    with open("../results/file.txt", 'w') as file:
        file.write("The best alignment is: " + '\n' + best_align + '\n' 
        + seq1 + '\n' + "Score: " + str(best_score) + '\n') 
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)