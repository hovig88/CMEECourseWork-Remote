require(ggplot2)

rm(list=ls())
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")] = MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000
MyDF$Prey.mass.unit[which(MyDF$Prey.mass.unit=="mg")] = "g"

ggplot(data = MyDF, aes(MyDF$Prey.mass, MyDF$Predator.mass)) +
geom_point(shape=I(3), aes(color = MyDF$Predator.lifestage)) +
facet_wrap(~ MyDF$Type.of.feeding.interaction, nrow=5, ncol=1, strip.position = "right") +
geom_smooth(method = "lm", fullrange = TRUE, size = 0.5, aes(color = MyDF$Predator.lifestage)) +
xlab("Prey Mass in grams") +
ylab("Predator mass in grams") +
theme_bw() +
guides(col = guide_legend(nrow=1)) +
theme(panel.grid.minor = element_line(color = "gray96"), legend.title = element_text(size = 10, face = "bold"), legend.position = "bottom", 
      legend.key.size = unit(2, "line"), legend.text = element_text(size = 10), plot.margin=unit(c(1,3,1,3), "cm")) +
scale_x_continuous(trans="log10") +
scale_y_continuous(trans="log10")

ggsave("../results/PP_Regress.pdf", plot = last_plot(), width = unit(5, "in"), height = unit(10.4, "in"), dpi = 500)

subDF = data.frame("Feeding.type.X.Predator.lifestage" = paste(MyDF$Type.of.feeding.interaction, MyDF$Predator.lifestage), "Predator.mass" = MyDF$Predator.mass, "Prey.mass" = MyDF$Prey.mass)


require(plyr)
require(broom)
table = ddply(subDF, .(Feeding.type.X.Predator.lifestage), summarize,
              intercept = lm(log10(Predator.mass)~log10(Prey.mass))$coef[1],
              slope = lm(log10(Predator.mass)~log10(Prey.mass))$coef[2], 
              r.squared = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$r.squared,
              f.statistic = as.numeric(glance(lm(log10(Predator.mass)~log10(Prey.mass)))[4]),
              p.value = summary(lm(log10(Predator.mass)~log10(Prey.mass)))$coefficients[8])

write.csv(table, "../results/PP_Regress_Results.csv", row.names = FALSE)