#!/usr/bin/env R

# importing required packages
require(maps, quietly = TRUE)

# loading the GPDD data
load(file = '../data/GPDDFiltered.RData')

# creating a world map
map('world')
map.axes()

# localizing points on the map
points(x = gpdd$long, y  = gpdd$lat, pch = 8, cex = 0.25, col ='red')

print("The map produced from this script is biased since the data used claims to be a global representation, yet the majority of the samples in study come from European and North American countries.", quote = FALSE)
