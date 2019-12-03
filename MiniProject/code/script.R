rm(list = ls())
graphics.off()

setwd("~/Documents/CMEECourseWork/MiniProject/code")

library(ggplot2)

LogisticGrowthData = read.csv("../data/LogisticGrowthData.csv", header = T)
LogisticGrowthData$Temp = as.factor(LogisticGrowthData$Temp)
temp = data.frame("ID" = paste(LogisticGrowthData$Species, LogisticGrowthData$Temp,
                               LogisticGrowthData$Medium, LogisticGrowthData$Citation),
                  LogisticGrowthData)
LogisticGrowthData = within(temp, ID <- factor(ID, labels = 1:length(unique(temp$ID))))

temp = select(LogisticGrowthData, ID, X, Species, Temp, Medium, PopBio, Time, Citation)
myData = arrange(temp, ID, Species, Temp, Medium, Citation)

##############################  PER SPECIES PER TEMPERATURE  ###################################
graphics.off()
pdf("../plots/per_Species_per_Temperature.pdf")
for(i in 1:length(unique(myData$Species))){
  subData = subset(myData, myData$Species == unique(myData$Species)[i])
  print(ggplot(subData, aes(subData$Time, subData$PopBio)) + 
    geom_point(aes(color = subData$Medium)) +
    facet_wrap(facets = vars(subData$Temp), nrow = 3, ncol = 2, scales = "free") +
    guides(col = guide_legend(nrow=1)) +
    xlab("Time") +
    ylab("Population Abundance") +
    labs(title = paste0(as.character(unique(subData$Species))), color = "Medium") +
    theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5)))
}
dev.off()
################################################################################################
graphics.off()
pdf("../plots/per_Species_Temperature_Medium_Citation.pdf")
for(i in 1:length(unique(myData$ID))){
  subData = subset(myData, myData$ID == unique(myData$ID)[i])
  print(ggplot(subData, aes(subData$Time, subData$PopBio)) +
    geom_point())
}
dev.off()
################################################################################################
per_Species_Temp = data.frame("X" = y$X, "Species_Temp" = paste(y$Species, y$Temp), "Medium" = y$Medium, "PopBio" = y$PopBio, "Time" = y$Time)
per_Species_Medium = data.frame("X" = y$X, "Species_Medium" = paste(y$Species, y$Medium), "Temp" = y$Temp, "PopBio" = y$PopBio, "Time" = y$Time)
per_Species_Temp_Medium = data.frame("X" = y$X, "Species_Temp_Medium" = paste(y$Species, y$Temp, y$Medium), "PopBio" = y$PopBio, "Time" = y$Time)
per_Species_Medium_Temp = data.frame("X" = y$X, "Species_Medium_Temp" = paste(y$Species, y$Medium, y$Temp), "PopBio" = y$PopBio, "Time" = y$Time)

##  PER SPECIES ##
graphics.off()
pdf(paste0("../plots/per_Species.pdf"))
for(i in seq(1, length(unique(LogisticGrowthData$Species)), per = 9)){
  par(mfrow=c(3,3))
  for(j in seq(0, 8)){
    #pdf(paste0("../plots/per_Species/",i,".pdf"),width=7,height=7)
    plot(LogisticGrowthData$Time[which(LogisticGrowthData$Species == unique(LogisticGrowthData$Species)[i+j])], LogisticGrowthData$PopBio[which(LogisticGrowthData$Species == unique(LogisticGrowthData$Species)[i+j])], main = unique(LogisticGrowthData$Species)[i+j], xlab = "Time", ylab = "Abundance")
  }
}
dev.off()

## PER SPECIES PER TEMPERATURE ##
graphics.off()
pdf(paste0("../plots/per_Species_Temp.pdf"))
for(i in seq(1, length(unique(per_Species_Temp$Species_Temp)), per = 16)){
  par(mfrow=c(4,4))
  for(j in seq(0, 15)){
    plot(per_Species_Temp$Time[which(per_Species_Temp$Species_Temp == unique(per_Species_Temp$Species_Temp)[i+j])], per_Species_Temp$PopBio[which(per_Species_Temp$Species_Temp == unique(per_Species_Temp$Species_Temp)[i+j])], main = unique(per_Species_Temp$Species_Temp)[i+j], xlab = "Time", ylab = "Abundance")
  }
}
dev.off()

## PER SPECIES PER MEDIUM ##
graphics.off()
pdf(paste0("../plots/per_Species_Medium.pdf"))
for(i in seq(1, length(unique(per_Species_Medium$Species_Medium)), per = 9)){
  
  par(mfrow=c(3,3))
  for(j in seq(0, 8)){
    if((i+j) > length(unique(per_Species_Medium$Species_Medium)))
      break
    plot(per_Species_Medium$Time[which(per_Species_Medium$Species_Medium == unique(per_Species_Medium$Species_Medium)[i+j])], per_Species_Medium$PopBio[which(per_Species_Medium$Species_Medium == unique(per_Species_Medium$Species_Medium)[i+j])], main = unique(per_Species_Medium$Species_Medium)[i+j], xlab = "Time", ylab = "Abundance")
  }
  
}
dev.off()

## PER SPECIES PER MEDIUM PER TEMPERATURE ##
## PER SPECIES PER TEMPERATURE PER MEDIUM ##

## PER SPECIES PER MEDIUMTEMPERATURE ##
graphics.off()
pdf(paste0("../plots/per_Species_Temp_Medium.pdf"))
for(i in seq(1, length(unique(per_Species_Temp_Medium$Species_Temp_Medium)), per = 9)){
  
  par(mfrow=c(3,3))
  for(j in seq(0, 8)){
    if((i+j) > length(unique(per_Species_Temp_Medium$Species_Temp_Medium)))
      break
    plot(per_Species_Temp_Medium$Time[which(per_Species_Temp_Medium$Species_Temp_Medium == unique(per_Species_Temp_Medium$Species_Temp_Medium)[i+j])], per_Species_Temp_Medium$PopBio[which(per_Species_Temp_Medium$Species_Temp_Medium == unique(per_Species_Temp_Medium$Species_Temp_Medium)[i+j])], main = unique(per_Species_Temp_Medium$Species_Temp_Medium)[i+j], xlab = "Time", ylab = "Abundance")
  }
  
}
dev.off()

#################### MODELS ####################

## POLYNOMIAL EQUATION ##
b0 = 1
b1 = 1
b2 = 1
b3 = 1
b4 = 1
x = 1:50
y1 = b0 + b1*x
y2 = b0 + b1*x + b2*(x^2)
y3 = b0 + b1*x + b2*(x^2) + b3*(x^3)
y4 = b0 + b1*x + b2*(x^2) + b3*(x^3) + b4*(x^4)
par(mfrow=c(2,2))
plot(x, y1)
plot(x, y2)
plot(x, y3)
plot(x, y4)
######## GROWTH RATE MODEL ############
graphics.off()
N = integer()
N0 = 1
t = 1:50
Nmax = 100
rmax = 2
par(mfrow=c(3,3))
for(j in 1:9){
  rmax = rmax/2
  for(i in t){
    N[i] = (N0 * Nmax * exp(rmax * i)) / (Nmax + N0 * (exp(rmax*i) - 1))
  }
  plot(t, N)
}
######################### GOMPERTZ MODEL #########################
graphics.off()
N = integer()
A = Nmax / N0
rmax = 0.5
t = 1:400
tlag = 100
N[t] = A * exp(-exp(((rmax * exp(1) * (tlag - t)) / A) + 1))
plot(t, N)
##################################################################






gompertz_model <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (N_max - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((N_max - N_0) * log(10)) + 1)))
}

baranyi_model <- function(t, r_max, N_max, N_0){  # Baranyi model (Baranyi 1993)
  A[t] = t + (1 / r_max) * log((exp(-r_max * t) + h_0) / (1 + h_0))
  N[t] = log(N_0) + r_max * A[t] - log(1 + ((exp(r_max * A[t]) - 1) / (exp(log(N_max) - log(N_0)))))
  
  return(N)
  #return(N_max + log10((-1+exp(r_max*t_lag) + exp(r_max*t))/(exp(r_max*t) - 1 + exp(r_max*t_lag) * 10^(N_max-N_0))))
}

buchanan_model <- function(t, r_max, N_max, N_0, t_lag){ # Buchanan model - three phase logistic (Buchanan 1997)
  return(N_0 + (t >= t_lag) * (t <= (t_lag + (N_max - N_0) * log(10)/r_max)) * r_max * (t - t_lag)/log(10) + (t >= t_lag) * (t > (t_lag + (N_max - N_0) * log(10)/r_max)) * (N_max - N_0))
}

  
#################################################
## MODEL-FITTING ##
require("minipack.lm")




