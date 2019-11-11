rm(list=ls())
setwd("~/Documents/CMEECourseWork/Week6/code/")

bearsData = read.csv("../data/bears.csv", header=FALSE, stringsAsFactors = FALSE, colClasses = rep("character", 10000))
dim(bearsData)

# identifying the columns which contain SNPs
snps = vector()
for(i in seq(length(bearsData))){
  if(length(unique(bearsData[,i])) > 1)
    snps = c(snps, i)
}

# creating a subset of columns containing SNPs
snpData = bearsData[,snps]
colnames(snpData) = snps
dim(snpData)

# allele frequencies for each SNP
alleleFreq = matrix(nrow = 2, ncol = length(snpData))
for(i in seq(length(snpData))){
  freq1 = table(snpData[,i])[1]/nrow(snpData)
  freq2 = table(snpData[,i])[2]/nrow(snpData)
  alleleFreq[,i] = c(freq1, freq2)
}

colnames(alleleFreq) = snps

# genotype frequencies for each SNP
genotypeCounts = matrix(nrow = 3, ncol = length(snpData))

for(i in seq(length(snpData))){
  
  count1 = 0
  count2 = 0
  count3 = 0
  
  for(j in seq(1, nrow(snpData), by = 2)){
    k = j+1
    if(length(which(snpData[j:k,i] == unique(snpData[,i])[1])) == 2){
      count1 = count1 + 1
    } else if(length(which(snpData[j:k,i] == unique(snpData[,i])[1])) == 1){
        count2 = count2 + 1
      } else if(length(which(snpData[j:k,i] == unique(snpData[,i])[1])) == 0){
        count3 = count3 + 1
        }
  }
  
  genotypeCounts[,i] = c(count1, count2, count3)
}


    
    
