#!/usr/bin/env python3

"""This Python script creates three different lists containing the latin names, common names, and mean body masses 
for each species in birds, respectively, using list comprehensions, as well as conventional for loops"""

__appname__ = 'lc1.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) List Comprehensions
latin_names = [row[0] for row in birds] # outputs the first element of each row in a list
common_names = [row[1] for row in birds] # outputs the second element of each row in a list
body_masses = [row[2] for row in birds] # outputs the third element of each row in a list

print("Using list comprehensions:")
print("Latin Names:")
print(latin_names)
print("Common Names:")
print(common_names)
print("Mean Body Masses:")
print(body_masses)
print("")

#(2) Conventional For Loops
latin_names = []
common_names = []
body_masses = []

for row in birds:
    latin_names.append(row[0])

for row in birds:
    common_names.append(row[1])

for row in birds:
    body_masses.append(row[2])

print("Using conventional for loops:")
print("Latin Names:")
print(latin_names)
print("Common Names:")
print(common_names)
print("Mean Body Masses:")
print(body_masses)
print("")

print("We get the same output as expected!")
