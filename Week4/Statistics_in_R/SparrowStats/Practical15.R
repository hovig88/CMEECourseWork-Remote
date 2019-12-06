rm(list(ls()))
setwd("~/Documents/Statistics_in_R/HandOutsandData'18")

daphnia <- read.delim("daphnia.txt")
summary(daphnia)

par(mfrow = c(1, 2))
plot(Growth.rate ~ Detergent, data = daphnia)
plot(Growth.rate ~ Daphnia, data = daphnia)

require(dplyr)

daphnia %>%
    group_by(Detergent) %>%
    summarise(variance=var(Growth.rate))

daphnia %>%
    group_by(Daphnia) %>%
    summarise(variance=var(Growth.rate))

hist(daphnia$Growth.rate)

seFun <- function(x) {
    sqrt(var(x)/length(x))
}
detergentMean <-with(daphnia, tapply(Growth.rate, INDEX = Detergent, FUN = mean))
detergentSEM <- with(daphnia, tapply(Growth.rate, INDEX = Detergent, FUN = seFun))
cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean))
cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))

par(mfrow=c(2,1), mar=c(4,4,1,1))
barMids <- barplot(detergentMean, xlab ="Detergent type", ylab = "Population growth rate", ylim = c(0, 5))
arrows(barMids, detergentMean - detergentSEM, barMids, detergentMean + detergentSEM, code = 3, angle = 90)
barMids <- barplot(cloneMean, xlab = "Daphnia clone", ylab = "Population growth rate", ylim = c(0, 5))
arrows(barMids, cloneMean - cloneSEM, barMids, cloneMean + cloneSEM, code = 3, angle = 90)

daphniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
anova(daphniaMod)
summary(daphniaMod)

detergentMean - detergentMean[1]
cloneMean - cloneMean[1]

daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaANOVAMod)

daphniaModHSD <- TukeyHSD(daphniaANOVAMod)
daphniaModHSD

par(mfrow=c(2,1),mar=c(4,4,1,1))
plot(daphniaModHSD)

par(mfrow=c(2,2))
plot(daphniaMod)

timber <- read.delim("timber.txt")
summary(timber)

par(mfrow = c(2,2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)

var(timber$volume)
var(timber$girth)
var(timber$height)

t2<-as.data.frame(subset(timber, timber$volume!="NA"))
t2$z.girth<-scale(timber$girth)
t2$z.height<-scale(timber$height)
var(t2$z.girth)
var(t2$z.height)
plot(t2)

par(mfrow=c(2 2))
hist(t2$volume)
hist(t2$girth)
hist(t2$height)

pairs(timber)
cor(timber)

summary(lm(girth ~ height, data = timber))

VIF <- 1/(1-0.27)
VIF
sqrt(VIF)

pairs(timber)
cor(timber)

pairs(t2)
cor(t2)

timberMod <- lm(volume ~ girth + height, data = timber)
anova(timberMod)
summary(timberMod)
plot(timberMod)

plantGrowth <- read.delim("ipomopsis.txt")
summary(plantGrowth)
