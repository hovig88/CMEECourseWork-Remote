#!/usr/bin/env python3

"""This Python script populates a dictionary by mapping order names to sets of taxa"""

__appname__ = 'dictionary.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

taxa_dic={}
x = 0
for row in taxa: # loops over each tuple
        if row[1] not in taxa_dic.keys(): # populates unique dictionary keys
                taxa_dic[row[1]] = []
                x = x + 1

        for key in taxa_dic.keys(): # loops over each key value
                if key == row[1]: # if the key value matches the second string in the tuple 
                        taxa_dic[key].append(row[0]) # add the first string as a value to the key

# printing out dictionary keys with their corresponding values 
print("Order Names :    Taxa")
print("-----------      ----")
for key,val in taxa_dic.items():
        print(key, ":   ", val)
