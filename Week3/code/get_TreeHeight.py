#!/usr/bin/env python3

"""A python version of get_TreeHeight.R"""

__appname__ = 'get_TreeHeight.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import math
import sys
import csv
import numpy as np

## functions ##
def TreeHeight(degrees, distance):
    """This function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula."""
    radians = degrees * math.pi / 180
    tan_radians = np.array([math.tan(radians[i]) for i in range(len(radians))])
    height = distance * tan_radians
    return height.tolist()

def InputFile(args):
    """This function makes sure the script can handle input files, even if none are provided"""
    if(len(args)) == 1:
        print("No input file provided... taking default file...")
        file = "../data/trees.csv"
    elif(len(args)) == 2:
        print("Required input provided...")
        file = args[1]
    elif(len(args) >= 3):
        print("More than one file provided... taking the first one...")
        file = args[1]
    return file

file = InputFile(sys.argv)

TreesData = []

# Saving the file into a list
with open(file) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter = ',')
    for row in csv_reader:
        TreesData.append(row)

print("Calculating tree heights...")
distance = np.array([float(TreesData[i][1]) for i in np.arange(len(TreesData)-1)+1])
degrees = np.array([float(TreesData[i][2]) for i in np.arange(len(TreesData)-1)+1])
height = TreeHeight(degrees, distance)

print("Adding height column to original dataset...")
for i in np.arange(len(TreesData)-1)+1:
    TreesData[i].append(height[i-1])

TreesData[0].append('Tree.Height.m')

print("Saving the new dataset into a csv file...")
InputFileName = file.split('/')[2].split('.')[0]
with open("../results/" + InputFileName + "_treeheights_py.csv", "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerows(TreesData)

print("Done!")
