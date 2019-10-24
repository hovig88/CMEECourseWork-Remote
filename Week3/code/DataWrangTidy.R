#!/usr/bin/env R

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############### import packages ###############

require(dplyr, warn.conflicts = FALSE, quietly = TRUE)
require(tidyr, warn.conflicts = FALSE, quietly = TRUE)

############# Load the dataset ###############

# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############

print("Inspecting the dataset:", quote = FALSE)
glimpse(MyData)

############# Transpose ###############
# To get those species into columns and treatments into rows

MyData <- t(MyData) 

############# Replace species absences with zeros ###############

MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############

MyWrangledData <- gather(TempData, key = "Species", value = "Count", colnames(TempData[,-(1:4)]),factor_key = TRUE) 
# compresses all columns referring to a species into one column and generates a count value for each species, storing them in a new column

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

print("Inspecting the wrangled dataset:",  quote = FALSE)
glimpse(MyWrangledData)
