#!/usr/bin/env R

# this script creates three lattice graphs by feeding interaction type for predator mass, prey mass, and size ratio of prey mass over predator mass.
# It also calculates the mean and median predator mass, prey mass, and size rato to a csv file

# importing required packages
library(lattice)

# fixing dataset
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")] = MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000 # converting all prey massses to same unit
MyDF$Prey.mass.unit[which(MyDF$Prey.mass.unit=="mg")] = "g"

print("Saving lattice graphs into pdf files...", quote = FALSE)
pdf("../results/Pred_Lattice.pdf")
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF)
graphics.off()
pdf("../results/Prey_Lattice.pdf")
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF)
graphics.off()
pdf("../results/SizeRatio_Lattice.pdf")
densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data=MyDF)
graphics.off()

print("Calculating mean and median...", quote = FALSE)
Feeding.Type=names(table(MyDF$Type.of.feeding.interaction))
Predator.Mass.Mean=tapply(log(MyDF$Predator.mass), MyDF$Type.of.feeding.interaction, mean)
Predator.Mass.Median=tapply(log(MyDF$Predator.mass), MyDF$Type.of.feeding.interaction, median)
Prey.Mass.Mean=tapply(log(MyDF$Prey.mass), MyDF$Type.of.feeding.interaction, mean)
Prey.Mass.Median=tapply(log(MyDF$Prey.mass), MyDF$Type.of.feeding.interaction, median)
SizeRatio.Mean=tapply(log(MyDF$Prey.mass/MyDF$Predator.mass), MyDF$Type.of.feeding.interaction, mean)
SizeRatio.Median=tapply(log(MyDF$Prey.mass/MyDF$Predator.mass), MyDF$Type.of.feeding.interaction, median)

# constructing the dataframe with the mean and median values
d = as.data.frame(cbind(Feeding.Type, Predator.Mass.Mean, Predator.Mass.Median, Prey.Mass.Mean, Prey.Mass.Median, SizeRatio.Mean, SizeRatio.Median))

print("Saving the results into a csv file...", quote = FALSE)
write.csv(d, "../results/PP_Results.csv", row.names = FALSE, quote = FALSE)

print("Done!", quote = FALSE)
