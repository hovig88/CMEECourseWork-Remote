load("../data/KeyWestAnnualMeanTemperature.RData")

plot(ats$Year, ats$Temp)
lines(ats$Year, ats$Temp)

cor(ats$Year, ats$Temp)

x_t0 = ats$Temp[-100]
x_t1 = ats$Temp[-1]

length(x_t0)
length(x_t1)

head(cbind(x_t0, x_t1))

plot(x_t0, x_t1)
print(cor(x_t0, x_t1))

acf(ats$Temp, plot = TRUE)

temp_cor = rep(NA, 10000)
for(i in 1:10000){
    test = sample(ats$Temp, replace = FALSE)
    temp_cor[i] = cor(test[-100], test[-1])
}

hist(temp_cor, breaks = 5)
abline(v = cor(x_t0, x_t1), lty = 2, col = "red")
# non-random - since the line is far off from the normal distribution

print(length(which(temp_cor > cor(x_t0, x_t1)))/length(which(temp_cor < cor(x_t0, x_t1))))