#!/usr/bin/env R

# similar to the PP_Regress.R script, with the addition of the Location parameter

# importing required packages
require(plyr, quietly = TRUE)
require(broom, quietly = TRUE)

rm(list=ls())

# suppress unnecessary warning messages
options(warn=-1)

# fixing dataset
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")] = MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000
MyDF$Prey.mass.unit[which(MyDF$Prey.mass.unit=="mg")] = "g"

# creating a subset of the original dataset, showing a combination between feeding type, predator lifestage, and location
subDF = data.frame("Feeding.type.X.Predator.lifestage.X.Location" = paste(MyDF$Type.of.feeding.interaction, MyDF$Predator.lifestage, MyDF$Location), "Predator.mass" = MyDF$Predator.mass, "Prey.mass" = MyDF$Prey.mass)

print("Calculating the needed results...", quote = FALSE)
results = ddply(subDF, .(Feeding.type.X.Predator.lifestage.X.Location), summarize,
              intercept = lm(log10(Predator.mass)~log10(Prey.mass))$coef[1],
              slope = lm(log10(Predator.mass)~log10(Prey.mass))$coef[2], 
              r.squared = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$r.squared,
              f.statistic = as.numeric(glance(lm(log10(Predator.mass)~log10(Prey.mass)))[4]),
              p.value = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$coefficients[8])

print("Writing the results into a csv file...", quote = FALSE)
write.csv(results, "../results/PP_Regress_loc_Results.csv", row.names = FALSE)

print("Done!", quote = FALSE)
