#!/usr/bin/env R

# A generic version of TreeHeight.R, where it takes any input file as a dataset

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)

  return (height)
}

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  print("No input file provided... taking default file...", quote = FALSE)
  args[1] = "../data/trees.csv"
} else if (length(args)==1) {
  print("Required input file provided...", quote = FALSE)
} else if (length(args) >= 2) {
  print("More than one file provided... taking the first one...", quote = FALSE)
}

TreesData = read.csv(args[1]) # storing the csv file in a variable

print("Calculating tree heights...", quote = FALSE)
height = as.data.frame(TreeHeight(TreesData[,3], TreesData[,2])) # storing the values of the heights into a variable
colnames(height) = "Tree.Height.m"

print("Adding height column to original dataset...", quote = FALSE)
TreeHts = cbind(TreesData, height)

print("Saving the new dataset into a csv file...", quote = FALSE)
InputFileName = sub(pattern = "(.*)\\..*$", replacement= "\\1", basename(args[1])) # stripping the extension and relative path from the file name
write.csv(TreeHts, paste0("../results/", InputFileName, "_treeheights.csv"), row.names = F)

print("Done!", quote = FALSE)
