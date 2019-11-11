rm(list=ls())
setwd("~/Documents/CMEECourseWork/Week6/code/")

bent_toed_gecko_Data = read.csv("../data/bent-toed_gecko.csv", header=FALSE, stringsAsFactors = FALSE, colClasses = rep("character", 20000))
leopard_gecko_Data = read.csv("../data/leopard_gecko.csv", header=FALSE, stringsAsFactors = FALSE, colClasses = rep("character", 20000))
western_banded_gecko_Data = read.csv("../data/western_banded_gecko.csv", header=FALSE, stringsAsFactors = FALSE, colClasses = rep("character", 20000))

# identifying the columns which contain SNPs
bt_snps = vector()
for(i in seq(length(bent_toed_gecko_Data))){
  if(length(unique(bent_toed_gecko_Data[,i])) > 1)
    bt_snps = c(bt_snps, i) # 62
}

l_snps = vector()
for(i in seq(length(leopard_gecko_Data))){
  if(length(unique(leopard_gecko_Data[,i])) > 1)
    l_snps = c(l_snps, i) # 47
}

wb_snps = vector()
for(i in seq(length(western_banded_gecko_Data))){
  if(length(unique(western_banded_gecko_Data[,i])) > 1)
    wb_snps = c(wb_snps, i) # 58
}

bt_l_gecko_Data = rbind(bent_toed_gecko_Data, leopard_gecko_Data)
bt_wb_gecko_Data = rbind(bent_toed_gecko_Data, western_banded_gecko_Data)
l_wb_gecko_Data = rbind(leopard_gecko_Data, western_banded_gecko_Data)

bt_l_Data = bt_l_gecko_Data[,-sort(c(bt_snps, wb_snps))]
bt_wb_Data = bt_wb_gecko_Data[,-sort(c(bt_snps, wb_snps))]
l_wb_Data = l_wb_gecko_Data[,-sort(c(l_snps, wb_snps))]



bt_l_diverged_sites = vector()
for(i in 1:length(bt_l_Data)){
  if(length(unique(bt_l_Data[,i]))>1)
    bt_l_diverged_sites = c(bt_l_diverged_sites, i)
}

bt_wb_diverged_sites = vector()
for(i in 1:length(bt_wb_Data)){
  if(length(unique(bt_wb_Data[,i]))>1)
    bt_wb_diverged_sites = c(bt_wb_diverged_sites, i)
}

l_wb_diverged_sites = vector()
for(i in 1:length(l_wb_Data)){
  if(length(unique(l_wb_Data[,i]))>1)
    l_wb_diverged_sites = c(l_wb_diverged_sites, i)
}

bt_l_genetic_divergence = length(bt_l_diverged_sites) / ncol(bt_l_Data)
bt_wb_genetic_divergence = length(bt_wb_diverged_sites) / ncol(bt_wb_Data)
l_wb_genetic_divergence = length(l_wb_diverged_sites) / ncol(l_wb_Data)



