rm(list=ls())
setwd("~/Documents/CMEECourseWork/Week6/code/")

North_Whale_Data = as.matrix(read.csv("../data/killer_whale_North.csv", header = FALSE, stringsAsFactors = FALSE))
South_Whale_Data = as.matrix(read.csv("../data/killer_whale_South.csv", header = FALSE, stringsAsFactors = FALSE))

# Tajima's estimate
# calculating pairwise sequences
North_countMutations = 0
South_countMutations = 0

for(i in 1:(nrow(North_Whale_Data)-1)){
  for(k in (i+1):nrow(North_Whale_Data)){
    North_countMutations = North_countMutations + sum(abs(North_Whale_Data[i,]-North_Whale_Data[k,]))
  }
}

for(i in 1:(nrow(South_Whale_Data)-1)){
  for(k in (i+1):nrow(South_Whale_Data)){
    South_countMutations = South_countMutations + sum(abs(South_Whale_Data[i,]-South_Whale_Data[k,]))
  }
}

North_pi = North_countMutations / ((nrow(North_Whale_Data)*(nrow(North_Whale_Data)-1))/2)
South_pi = South_countMutations / ((nrow(South_Whale_Data)*(nrow(South_Whale_Data)-1))/2)

North_effPopSize_Tajima = North_pi / (4 * 1e-08 * 50000) # we need to multiply the mutation rate by number of sites because the mutation rate given is per site per generation
South_effPopSize_Tajima = South_pi / (4 * 1e-08 * 50000)

# Watterson's estimate
North_snps = vector()
for(i in 1:ncol(North_Whale_Data)){
  if(length(unique(North_Whale_Data[,i])) > 1)
    North_snps = c(North_snps, i)
}

South_snps = vector()
for(i in 1:ncol(South_Whale_Data)){
  if(length(unique(South_Whale_Data[,i])) > 1)
    South_snps = c(South_snps, i)
}

denominator = 0
for(i in 1:(nrow(North_Whale_Data)-1)){
  denominator = denominator + (1/i)
}  

North_theta_Watterson = length(North_snps) / denominator
South_theta_Watterson = length(South_snps) / denominator

North_effPopSize_Watterson = North_theta_Watterson / (4 * 1e-08 * 50000)
South_effPopSize_Watterson = South_theta_Watterson / (4 * 1e-08 * 50000)

# site frequency spectrum
North_freq = vector()
for(i in 1:ncol(North_Whale_Data)){
  North_freq[i] = length(which(North_Whale_Data[,i] == 1))
}

North_freq = North_freq[which(North_freq != 0)]

North_sfs = vector()
for(i in 1:(nrow(North_Whale_Data)-1)){
  North_sfs = c(North_sfs, length(which(North_freq == i)))
}


South_freq = vector()
for(i in 1:ncol(South_Whale_Data)){
  South_freq[i] = length(which(South_Whale_Data[,i] == 1))
}

South_freq = South_freq[which(South_freq != 0)]

South_sfs = vector()
for(i in 1:(nrow(South_Whale_Data)-1)){
  South_sfs = c(South_sfs, length(which(South_freq == i)))
}

# plot
barplot(t(cbind(North_sfs,South_sfs)), beside = TRUE, names.arg = 1:19, legend = c("North", "South"))
