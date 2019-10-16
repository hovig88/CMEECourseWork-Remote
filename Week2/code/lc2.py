#!/usr/bin/env python3

"""This Python script creates two different lists of month,rainfall tuples where the amount of rain was greater 
than 100mm and less than 50mm, respectively, using list comprehensions, as well as conventional for loops."""

__appname__ = 'lc2.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

#(1) > 100mm
greater_than_100 = [i for i in rainfall if i[1] > 100]
#(2) < 50mm
less_than_50 = [i[0] for i in rainfall if i[1] < 50]

print("Using list comprehensions:")
print("Greater than 100:")
print(greater_than_100)
print("Less than 100:")
print(less_than_50)
print("")

#(3) using for loops
greater_than_100 = []
for i in rainfall:
    if i[1] > 100:
        greater_than_100.append(i)

less_than_50 = []
for i in rainfall:
    if i[1] < 50:
        less_than_50.append(i[0])

print("Using conventional for loops:")
print("Greater than 100:")
print(greater_than_100)
print("Less than 100:")
print(less_than_50)
print("")

print("We get the same output as expected!")
