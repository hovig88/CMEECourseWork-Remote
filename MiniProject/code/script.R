library(ggplot2)

#plot(LogisticGrowthData$PopBio[which(LogisticGrowthData$ID==1)]~LogisticGrowthData$Time[which(LogisticGrowthData$ID==1)], 
#     type = "l", xlab = "Time (hrs)", ylab = "Abundance", xlim = c(0,700), ylim = c(0, 0.2))
#lines(LogisticGrowthData$PopBio[which(LogisticGrowthData$ID==2)]~LogisticGrowthData$Time[which(LogisticGrowthData$ID==2)], col = "red")
#lines(LogisticGrowthData$PopBio[which(LogisticGrowthData$ID==3)]~LogisticGrowthData$Time[which(LogisticGrowthData$ID==3)], col = "blue")
#lines(LogisticGrowthData$PopBio[which(LogisticGrowthData$ID==4)]~LogisticGrowthData$Time[which(LogisticGrowthData$ID==4)], col = "green")



############################################ PER ID ############################################
graphics.off()
pdf("../results/plots/per_ID.pdf")
for(i in unique(newdata$ID)){
  plot(newdata$Time[which(newdata$ID==i)], newdata$PopBio[which(newdata$ID==i)], xlab = "Time", ylab = "Abundance")
}
dev.off()
##############################  PER SPECIES PER TEMPERATURE  ###################################
graphics.off()
pdf("../results/plots/per_Species_per_Temperature.pdf")
for(i in 1:length(unique(LogisticGrowthData$Species))){
  subData = subset(LogisticGrowthData, LogisticGrowthData$Species == unique(LogisticGrowthData$Species)[i])
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
