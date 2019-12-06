# housekeeping
rm(list=ls())
setwd("~/Documents/Statistics_in_R/SparrowStats")
d=read.table("SparrowSize.txt", header=TRUE)
d1=subset(d, d$Wing!="NA")

library(pwr)
pwr.t.test(d=(5/sqrt(var(d1$Wing))), power = 0.8, sig.level = 0.05, type = "one.sample", alternative = "two.sided")
