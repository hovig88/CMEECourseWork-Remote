rm(list=ls())
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")] = MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000
MyDF$Prey.mass.unit[which(MyDF$Prey.mass.unit=="mg")] = "g"

subDF = data.frame("Feeding.type.X.Predator.lifestage.X.Location" = paste(MyDF$Type.of.feeding.interaction, MyDF$Predator.lifestage, MyDF$Location), "Predator.mass" = MyDF$Predator.mass, "Prey.mass" = MyDF$Prey.mass)


require(plyr)
require(broom)
table = ddply(subDF, .(Feeding.type.X.Predator.lifestage.X.Location), summarize,
              intercept = lm(log10(Predator.mass)~log10(Prey.mass))$coef[1],
              slope = lm(log10(Predator.mass)~log10(Prey.mass))$coef[2], 
              r.squared = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$r.squared,
              f.statistic = as.numeric(glance(lm(log10(Predator.mass)~log10(Prey.mass)))[4]),
              p.value = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$coefficients[8])

write.csv(table, "../results/PP_Regress_loc_Results.csv", row.names = FALSE)