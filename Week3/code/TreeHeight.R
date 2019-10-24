#!/usr/bin/env R

# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)

  return (height)
}

TreesData = read.csv("../data/trees.csv")
print("Calculating tree heights...", quote = FALSE)
height = as.data.frame(TreeHeight(TreesData[,3], TreesData[,2])) # storing the values of the heights into a variable
colnames(height) = "Tree.Height.m"

print("Adding height column to original dataset...", quote = FALSE)
TreeHts = cbind(TreesData, height)
write.csv(TreeHts, "../results/TreeHts.csv", row.names = F) # saving the new dataset into a csv file

print("Done!", quote = FALSE)
