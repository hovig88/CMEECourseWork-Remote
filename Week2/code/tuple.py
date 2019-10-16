#!/usr/bin/env python3

"""This Python script takes a tuple and outputs the rows in separate blocks according to species."""

__appname__ = 'tuple.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

x = 1
for row in birds:
    print("Species " + str(x) + ":")
    print(row[0] + ", " + row[1] + ", " + str(row[2]))
    print()
    x = x + 1