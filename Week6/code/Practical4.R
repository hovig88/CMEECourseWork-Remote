rm(list=ls())
setwd("~/Documents/CMEECourseWork/Week6/code/")

turtle_Data = as.matrix(read.csv("../data/turtle.csv", header = FALSE))
turtle_genotype_Data = as.matrix(read.csv("../data/turtle.genotypes.csv", header = FALSE))

calculate_FST = function(pop1, pop2){
    
    derived_freq_Pop1 = apply(pop1, 2, sum) / nrow(pop1)
    ancestral_freq_Pop1 = 1 - derived_freq_Pop1
    derived_freq_Pop2 = apply(pop2, 2, sum) / nrow(pop2)
    ancestral_freq_Pop2 = 1 - derived_freq_Pop2
    
    F_st = rep(NA, ncol(pop1))
    for(i in 1:ncol(pop1)){
      H_Subdivided = ((2 * derived_freq_Pop1[i] * ancestral_freq_Pop1[i]) + (2 * derived_freq_Pop2[i] * ancestral_freq_Pop2[i])) / 2
      delta_value = abs(derived_freq_Pop1 - derived_freq_Pop2)
      H_Total = H_Subdivided[i] + (((delta_value[i])^2) / 2)

      F_st[i] = (H_Total - H_Subdivided) / H_Total
    }
}

pop_A = turtle_Data[1:20,]
pop_B = turtle_Data[21:40,]
pop_C = turtle_Data[41:60,]
pop_D = turtle_Data[61:80,]