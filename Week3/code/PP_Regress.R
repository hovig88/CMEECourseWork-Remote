#!/usr/bin/env R

# this script draws and saves a pdf file of an exact copy of a figure found in the chapter, and writes the accompanying regression results to a formatted table in csv

# import required packages
require(ggplot2, warn.conflicts = FALSE, quietly = TRUE)
require(plyr, quietly = TRUE)
require(broom, quietly = TRUE)

rm(list=ls())

# suppress unnecessary warning messages
options(warn=-1)

# fixing dataset
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")] = MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000 # converting all prey massses to same unit
MyDF$Prey.mass.unit[which(MyDF$Prey.mass.unit=="mg")] = "g"

print("Plotting and saving the graph in a pdf file...", quote = FALSE)
ggplot(data = MyDF, aes(MyDF$Prey.mass, MyDF$Predator.mass)) +
geom_point(shape=I(3), aes(color = MyDF$Predator.lifestage)) +
facet_wrap(~ MyDF$Type.of.feeding.interaction, nrow=5, ncol=1, strip.position = "right") + # equivalent to the lattice command in qplot
geom_smooth(method = "lm", fullrange = TRUE, size = 0.5, aes(color = MyDF$Predator.lifestage)) + # draws a linear regression line
xlab("Prey Mass in grams") +
ylab("Predator mass in grams") +
theme_bw() + # black and white background
guides(col = guide_legend(nrow=1)) + # aligns the legends in 1 row
theme(panel.grid.minor = element_line(color = "gray96"), legend.title = element_text(size = 8, face = "bold"), legend.position = "bottom", 
      legend.key.size = unit(1, "line"), legend.text = element_text(size = 8), plot.margin=unit(c(1,3,1,3), "cm")) + # fixing the legend area
scale_x_continuous(trans="log10") + # scaling x
scale_y_continuous(trans="log10") + # scaling y
labs(color="Predator.lifestage") # remaming legend title

ggsave("../results/PP_Regress.pdf", plot = last_plot(), width = unit(7, "in"), height = unit(10, "in"), dpi = 500)

# creating a subset of the original dataset, showing a combination between feeding type and predator lifestage
subDF = data.frame("Feeding.type.X.Predator.lifestage" = paste(MyDF$Type.of.feeding.interaction, MyDF$Predator.lifestage), "Predator.mass" = MyDF$Predator.mass, "Prey.mass" = MyDF$Prey.mass)

print("Calculating the needed results...", quote = FALSE)
results = ddply(subDF, .(Feeding.type.X.Predator.lifestage), summarize,
              intercept = lm(log10(Predator.mass)~log10(Prey.mass))$coef[1],
              slope = lm(log10(Predator.mass)~log10(Prey.mass))$coef[2], 
              r.squared = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$r.squared,
              f.statistic = as.numeric(glance(lm(log10(Predator.mass)~log10(Prey.mass)))[4]), # from broom package
              p.value = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$coefficients[8])

print("Writing the results into a csv file...", quote = FALSE)
write.csv(results, "../results/PP_Regress_Results.csv", row.names = FALSE)

print("Done!", quote = FALSE)
