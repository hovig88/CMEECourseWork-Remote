load("../data/KeyWestAnnualMeanTemperature.RData")

pdf("../results/Temp_Plot.pdf", height = 4)
plot(ats$Year, ats$Temp, main = "Temperature in Key West, Florida for the 20th Century", xlab = "Years", ylab = "Temperatures")
lines(ats$Year, ats$Temp)
graphics.off()

x_t0 = ats$Temp[-100]
x_t1 = ats$Temp[-1]

head(cbind(x_t0, x_t1))

print(cor(x_t0, x_t1))

temp_cor = rep(NA, 10000)
for(i in 1:10000){
    test = sample(ats$Temp, replace = FALSE)
    temp_cor[i] = cor(test[-100], test[-1])
}

pdf("../results/Temp_Hist.pdf")
hist(temp_cor, main = "Temperature Correlation", xlab = "Correlation")
abline(v = cor(x_t0, x_t1), lty = 2, col = "red")
graphics.off()

print(length(which(temp_cor > cor(x_t0, x_t1)))/length(which(temp_cor < cor(x_t0, x_t1))))