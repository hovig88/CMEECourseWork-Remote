#!/usr/bin/env R

# This script prepares the raw dataset for NLLS fitting by dealing with negative values, creating IDs for each unique
# species/temperature/medium/citation/replicate, and logging the abundance values.

# OUTPUT:
# A modified dataset saved into a csv file


# load required package and dataset
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
data = read.csv("../data/LogisticGrowthData.csv", header = T)


## DEALING WITH NEGATIVE VALUES ##

# getting rid of very large negative value
data = data[-which(data$PopBio==min(data$PopBio)),]
  
# adding the smallest negative value to all data points
data$PopBio = data$PopBio + abs(min(data$PopBio))

# removing the smallest value (will be equal to zero)
data = data[-which(data$PopBio==min(data$PopBio)),]


## CREATING UNIQUE IDS FOR EACH SPECIES/TEMPERATURE/MEDIUM/CITATION/REPLICATE ##

# creating unique ids by glueing species/temperature/medium/citation/replicate together
tmp = data.frame("ID" = paste(data$Species, data$Temp, data$Medium, data$Rep, data$Citation), data)

#converting ID strings to numbers
data = within(tmp, ID <- factor(ID, labels = 1:length(unique(tmp$ID))))
row.names(data) = 1:nrow(data)

#rearranging the dataset and fixing some columns
data$Temp = as.factor(data$Temp)
data$PopBio_Log10 = log10(data$PopBio) # need to be logged for later as a requirement for the mechanistic model equations
data = data[,c(1:4, 12, 5:11)]
data = arrange(data, ID, Time)

## SAVING THE MODIFIED DATASET TO A CSV FILE ##
write.csv(data, file = "../data/ModifiedLogisticGrowthData.csv", row.names = FALSE)
