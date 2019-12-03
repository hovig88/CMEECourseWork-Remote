#!/usr/bin/env python3

"""Printing out Kingdom, Phylum, and Species names for each species found in the blackbirds.txt file"""

__appname__ = 'blackbirds.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import re

# Read the file (using a different, more python 3 way, just for fun!)
with open('../data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.

# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (easier!), or a single one (harder!)

match_Kingdom = re.findall(r'Kingdom\s(\w*)', text) # stores kingdom names in a list
match_Phylum = re.findall(r'Phylum\s(\w*)', text) # stores phylum names in a list
match_Species = re.findall(r'Species\s(\w*\s\w*)', text) # stores species names in a list

species = [['Kingdom', 'Phylum', 'Species']] # initialize a list with a header
for i in range(len(match_Kingdom)):
    species.append([match_Kingdom[i], match_Phylum[i], match_Species[i]]) # add the information of each species to the list
    print("Species "  + str(i+1) + ":\nKingdom - " + species[i+1][0] + "\nPhylum - " + species[i+1][1] + "\nSpecies - " + species[i+1][2] + "\n") # print out the stored information neatly