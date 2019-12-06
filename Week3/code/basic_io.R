#!/usr/bin/env R

# a simple script to illustrate R input-output.
# Run line by line and check inputs outputs to understand what is happening

options(warn=-1)

print("Importing trees.csv file...", quote = FALSE)
MyData <- read.csv("../data/trees.csv", header = TRUE) # import with headers

print("Writing it out as a new file...", quote = FALSE)
write.csv(MyData, "../results/MyData.csv") #write it out as a new file

print("Modifying dataset...", quote = FALSE)
write.table(MyData[1,], file = "../results/MyData.csv", append=TRUE) # Append to it
write.csv(MyData, "../results/MyData.csv", row.names=TRUE) # write row names
write.table(MyData, "../results/MyData.csv", col.names=FALSE) # ignore column names

print("Done!", quote = FALSE)
