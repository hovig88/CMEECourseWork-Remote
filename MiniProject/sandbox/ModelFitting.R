rm(list = ls())
graphics.off()

setwd("~/Documents/CMEECourseWork/MiniProject/sandbox")

require("minpack.lm", quietly = TRUE) # for Levenberg-Marquardt nlls fitting

powMod = function(x, a, b) {
  return(a * x^b)
}

MyData = read.csv("GenomeSize.csv")
head(MyData)

Data2Fit = subset(MyData, Suborder == "Anisoptera")
Data2Fit = Data2Fit[!is.na(Data2Fit$TotalLength),] # remove NA's
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)

# same with ggplot
require(ggplot2, quietly = TRUE)
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) +
  geom_point(size = I(3), color = "red") + theme_bw() +
  labs(y = "Body mass (mg)", x = "Wing length (mm)")

PowFit = nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1))

summary(PowFit)

Lengths = seq(min(Data2Fit$TotalLength), max(Data2Fit$TotalLength), len=200)

coef(PowFit)["a"]
coef(PowFit)["b"]

Predic2PlotPow = powMod(Lengths, coef(PowFit)["a"], coef(PowFit)["b"])

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = "blue", lwd = 2.5)

confint(PowFit)