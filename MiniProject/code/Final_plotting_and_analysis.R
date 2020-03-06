#!/usr/bin/env R

# This script first prepares the data points of each model using the estimated parameters found during NLLS fitting, and then
# plots them all on top of all the unique datasets.

# OUTPUT:
# 305 plots saved in one pdf file


# load required package and dataset
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)
library(grid, quietly = TRUE, warn.conflicts = FALSE)
library(gridExtra, quietly = TRUE, warn.conflicts = FALSE)

df = read.csv("../data/results.csv")
data = read.csv("../data/ModifiedLogisticGrowthData.csv")

#suppress warnings to avoid printing it out
options(warn=-1)

## PLOTTING ##

# opening a pdf file to save all plots inside it
pdf("../results/plots/data_with_models_ggplot.pdf", onefile = TRUE)

for(i in 1:length(unique(df$ID))){
  # creating a subset at each iteration based on the unique IDs
  data_subset = subset(data, data$ID == i)
  df_subset = subset(df, df$ID == i)
  
  # creating the vector of time values for the models
  t = seq(min(data_subset$Time), max(data_subset$Time)+1, by = 1)
  
  
  ## LINEAR EQUATION ##
  
  # saving the estimated parameters inside variables
  linear_B_0 = df_subset[1,4]
  linear_B_1 = df_subset[1,5]

  # pre-allocating the vector of abundance values for the linear model
  linear = rep(NA, length(t))
  
  # calculating the abundance values
  for(j in 1:length(t)){
    linear[j] = linear_B_0 + linear_B_1*t[j]
  }
  
  
  ## QUADRATIC EQUATION ##
  
  # saving the estimated parameters inside variables
  quadratic_B_0 = df_subset[2,4]
  quadratic_B_1 = df_subset[2,5]
  quadratic_B_2 = df_subset[2,6]
  
  # pre-allocating the vector of abundance values for the quadratic model
  quadratic = rep(NA, length(t))
  
  # calculating the abundance values
  for(k in 1:length(t)){
    quadratic[k] = quadratic_B_0 + quadratic_B_1*t[k] + quadratic_B_2*(t[k])^2
  }
  
  
  ## CUBIC EQUATION ##
  
  # saving the estimated parameters inside variables
  cubic_B_0 = df_subset[3,4]
  cubic_B_1 = df_subset[3,5]
  cubic_B_2 = df_subset[3,6]
  cubic_B_3 = df_subset[3,7]
  
  # pre-allocating the vector of abundance values for the cubic model
  cubic = rep(NA, length(t))
  
  # calculating the abundance values
  for(l in 1:length(t)){
    cubic[l] = cubic_B_0 + cubic_B_1*t[l] + cubic_B_2*(t[l])^2 + cubic_B_3*(t[l])^3
  }
  
  
  ## LOGISTIC MODEL ##
  
  # saving the estimated parameters inside variables
  logistic_N_max = df_subset[4,8]
  logistic_N_0 = df_subset[4,9]
  logistic_r_max = df_subset[4,10]
  #logistic_t_lag = df_subset[4, 11]
  
  # pre-allocating the vector of abundance values for the logistic model
  logistic = rep(NA, length(t))
  
  # calculating the abundance values
  for(m in 1:length(t)){
    logistic[m] = log10((logistic_N_0 * logistic_N_max) / (logistic_N_0 + (logistic_N_max - logistic_N_0) * exp(-logistic_r_max * t[m])))
  }
  
  
  ## GOMPERTZ MODEL ##
  
  # saving the estimated parameters inside variables
  gompertz_N_max = df_subset[5,8]
  gompertz_N_0 = df_subset[5,9]
  gompertz_r_max = df_subset[5,10]
  gompertz_t_lag = df_subset[5,11]
  
  # pre-allocating the vector of abundance values for the gompertz model
  gompertz = rep(NA, length(t))
  
  # calculating the abundance values
  for(n in 1:length(t)){
    gompertz[n] = gompertz_N_0 + (gompertz_N_max - gompertz_N_0) * exp(-exp(gompertz_r_max * exp(1) * (gompertz_t_lag - t[n])/((gompertz_N_max - gompertz_N_0) * log(10)) + 1))
  }
  
  
  ## BARANYI MODEL ##
  
  # saving the estimated parameters inside variables
  baranyi_N_max = df_subset[6,8]
  baranyi_N_0 = df_subset[6,9]
  baranyi_r_max = df_subset[6,10]
  baranyi_t_lag = df_subset[6,11]
  
  # pre-allocating the vector of abundance values for the gompertz model
  baranyi = rep(NA, length(t))
  
  # calculating the abundance values
  for(o in 1:length(t)){
    baranyi[o] = baranyi_N_max + log10((-1+exp(baranyi_r_max*baranyi_t_lag) + exp(baranyi_r_max*t[o]))/(exp(baranyi_r_max*t[o]) - 1 + exp(baranyi_r_max*baranyi_t_lag) * 10^(baranyi_N_max-baranyi_N_0)))
  }
  
  ## BUCHANAN MODEL ##
  
  # saving the estimated parameters inside variables
  buchanan_N_max = df_subset[7,8]
  buchanan_N_0 = df_subset[7,9]
  buchanan_r_max = df_subset[7,10]
  buchanan_t_lag = df_subset[7,11]
  
  # pre-allocating the vector of abundance values for the gompertz model
  buchanan = rep(NA, length(t))
  
  # calculating the abundance values
  for(p in 1:length(t)){
    buchanan[p] = buchanan_N_0 + (t[p] >= buchanan_t_lag) * (t[p] <= (buchanan_t_lag + (buchanan_N_max - buchanan_N_0) * log(10)/buchanan_r_max)) * buchanan_r_max * (t[p] - buchanan_t_lag)/log(10) + (t[p] >= buchanan_t_lag) * (t[p] > (buchanan_t_lag + (buchanan_N_max - buchanan_N_0) * log(10)/buchanan_r_max)) * (buchanan_N_max - buchanan_N_0)
  }
  
  ## PREPARING A DATAFRAME WITH THE PLOTTING VALUES OF THE MODELS TO FEED IT TO GGPLOT2 ##
  linear_data = data.frame(t, linear, rep('linear', length(t)))
  names(linear_data) = c('t', 'Abundance', 'model')
  
  quadratic_data = data.frame(t, quadratic, rep('quadratic', length(t)))
  names(quadratic_data) = c('t', 'Abundance', 'model')
  
  cubic_data = data.frame(t, cubic, rep('cubic', length(t)))
  names(cubic_data) = c('t', 'Abundance', 'model')
  
  logistic_data = data.frame(t, logistic, rep('logistic', length(t)))
  names(logistic_data) = c('t', 'Abundance', 'model')
  
  gompertz_data = data.frame(t, gompertz, rep('gompertz', length(t)))
  names(gompertz_data) = c('t', 'Abundance', 'model')
  
  baranyi_data = data.frame(t, baranyi, rep('baranyi', length(t)))
  names(baranyi_data) = c('t', 'Abundance', 'model')
  
  buchanan_data = data.frame(t, buchanan, rep('buchanan', length(t)))
  names(buchanan_data) = c('t', 'Abundance', 'model')
  
  model_data = rbind(linear_data, quadratic_data, cubic_data, logistic_data, gompertz_data, baranyi_data, buchanan_data)
  
  # plotting dataset with all the models overlaid
  print(ggplot(data = data_subset, aes(x = Time, y = PopBio_Log10)) +
    geom_point() +
    coord_cartesian(ylim=c(min(model_data$Abundance[!is.nan(model_data$Abundance)])-0.1, max(model_data$Abundance[!is.nan(model_data$Abundance)])+0.1)) +
    geom_line(data = model_data, aes(x = t, y = Abundance, col = model), size = 1) +
    theme(panel.background = element_rect(fill = 'white', colour = 'black'), aspect.ratio = 1) +
    labs(x = "Time (h)", y = "Abundance"))
}

# close all graphics devices
invisible(dev.off())


## ANALYSIS ##
info_criteria = vector(mode = "list", length = 305)
for(i in 1:length(unique(df$ID))){
  # creating a subset at each iteration based on the unique IDs
  df_subset = subset(df, df$ID == i)
  
  # VERY CRUCIAL! if some models did not converge, make sure to remove their corresponding rows, otherwise they might end up being selected as AIC_min
  # (e.g. when the rest of the AIC values are positive)
  if(length(which(df_subset$AIC.AIC_c==0))!=0 | length(which(df_subset$AIC.AIC_c==Inf))!=0){
    df_subset = df_subset[-c(which(df_subset$AIC.AIC_c==0), which(df_subset$AIC.AIC_c==Inf)),]
  }
  
  # calculate AIC/AIC_c values and AIC differences
  info_criteria[[i]] = data.frame("index" = df_subset$model_ID, "AIC.AIC_c" = df_subset$AIC.AIC_c, "delta_AIC.AIC_c" = df_subset$AIC.AIC_c - min(df_subset$AIC.AIC_c))
  
  # calculate likelihood of models and their respective akaike weights
  likelihood_model = exp(-0.5*info_criteria[[i]]$delta_AIC.AIC_c)
  akaike_weight = likelihood_model / sum(likelihood_model)
  
  # add to dataframe and reorder them based on best-to-worst model ranking
  info_criteria[[i]] = cbind(info_criteria[[i]], likelihood_model, akaike_weight)
  info_criteria[[i]] = info_criteria[[i]][order(info_criteria[[i]]$delta_AIC.AIC_c),]
  
  # calculate evidence ratios
  evidence_ratio = info_criteria[[i]]$akaike_weight[1] / info_criteria[[i]]$akaike_weight
  
  # add to dataframe
  info_criteria[[i]] = cbind(info_criteria[[i]], evidence_ratio)
}

## PLOTS TO INCLUDE IN THE REPORT ##
representative_models = c(12, 52, 68, 146, 242)

for(i in representative_models){
  
  # opening a pdf file to save plot inside
  pdf(paste0("../results/data_with_best_models_", i, ".pdf"))
  
  # creating a subset at each iteration based on the unique IDs
  data_subset = subset(data, data$ID == i)
  df_subset = subset(df, df$ID == i)
  
  # creating the vector of time values for the models
  t = seq(min(data_subset$Time), max(data_subset$Time)+1, by = 1)
  
  
  ## LINEAR EQUATION ##
  
  # saving the estimated parameters inside variables
  linear_B_0 = df_subset[1,4]
  linear_B_1 = df_subset[1,5]
  
  # pre-allocating the vector of abundance values for the linear model
  linear = rep(NA, length(t))
  
  # calculating the abundance values
  for(j in 1:length(t)){
    linear[j] = linear_B_0 + linear_B_1*t[j]
  }
  
  
  ## QUADRATIC EQUATION ##
  
  # saving the estimated parameters inside variables
  quadratic_B_0 = df_subset[2,4]
  quadratic_B_1 = df_subset[2,5]
  quadratic_B_2 = df_subset[2,6]
  
  # pre-allocating the vector of abundance values for the quadratic model
  quadratic = rep(NA, length(t))
  
  # calculating the abundance values
  for(k in 1:length(t)){
    quadratic[k] = quadratic_B_0 + quadratic_B_1*t[k] + quadratic_B_2*(t[k])^2
  }
  
  
  ## CUBIC EQUATION ##
  
  # saving the estimated parameters inside variables
  cubic_B_0 = df_subset[3,4]
  cubic_B_1 = df_subset[3,5]
  cubic_B_2 = df_subset[3,6]
  cubic_B_3 = df_subset[3,7]
  
  # pre-allocating the vector of abundance values for the cubic model
  cubic = rep(NA, length(t))
  
  # calculating the abundance values
  for(l in 1:length(t)){
    cubic[l] = cubic_B_0 + cubic_B_1*t[l] + cubic_B_2*(t[l])^2 + cubic_B_3*(t[l])^3
  }
  
  
  ## LOGISTIC MODEL ##
  
  # saving the estimated parameters inside variables
  logistic_N_max = df_subset[4,8]
  logistic_N_0 = df_subset[4,9]
  logistic_r_max = df_subset[4,10]
  #logistic_t_lag = df_subset[4, 11]
  
  # pre-allocating the vector of abundance values for the logistic model
  logistic = rep(NA, length(t))
  
  # calculating the abundance values
  for(m in 1:length(t)){
    logistic[m] = log10((logistic_N_0 * logistic_N_max) / (logistic_N_0 + (logistic_N_max - logistic_N_0) * exp(-logistic_r_max * t[m])))
  }
  
  
  ## GOMPERTZ MODEL ##
  
  # saving the estimated parameters inside variables
  gompertz_N_max = df_subset[5,8]
  gompertz_N_0 = df_subset[5,9]
  gompertz_r_max = df_subset[5,10]
  gompertz_t_lag = df_subset[5,11]
  
  # pre-allocating the vector of abundance values for the gompertz model
  gompertz = rep(NA, length(t))
  
  # calculating the abundance values
  for(n in 1:length(t)){
    gompertz[n] = gompertz_N_0 + (gompertz_N_max - gompertz_N_0) * exp(-exp(gompertz_r_max * exp(1) * (gompertz_t_lag - t[n])/((gompertz_N_max - gompertz_N_0) * log(10)) + 1))
  }
  
  
  ## BARANYI MODEL ##
  
  # saving the estimated parameters inside variables
  baranyi_N_max = df_subset[6,8]
  baranyi_N_0 = df_subset[6,9]
  baranyi_r_max = df_subset[6,10]
  baranyi_t_lag = df_subset[6,11]
  
  # pre-allocating the vector of abundance values for the gompertz model
  baranyi = rep(NA, length(t))
  
  # calculating the abundance values
  for(o in 1:length(t)){
    baranyi[o] = baranyi_N_max + log10((-1+exp(baranyi_r_max*baranyi_t_lag) + exp(baranyi_r_max*t[o]))/(exp(baranyi_r_max*t[o]) - 1 + exp(baranyi_r_max*baranyi_t_lag) * 10^(baranyi_N_max-baranyi_N_0)))
  }
  
  ## BUCHANAN MODEL ##
  
  # saving the estimated parameters inside variables
  buchanan_N_max = df_subset[7,8]
  buchanan_N_0 = df_subset[7,9]
  buchanan_r_max = df_subset[7,10]
  buchanan_t_lag = df_subset[7,11]
  
  # pre-allocating the vector of abundance values for the gompertz model
  buchanan = rep(NA, length(t))
  
  # calculating the abundance values
  for(p in 1:length(t)){
    buchanan[p] = buchanan_N_0 + (t[p] >= buchanan_t_lag) * (t[p] <= (buchanan_t_lag + (buchanan_N_max - buchanan_N_0) * log(10)/buchanan_r_max)) * buchanan_r_max * (t[p] - buchanan_t_lag)/log(10) + (t[p] >= buchanan_t_lag) * (t[p] > (buchanan_t_lag + (buchanan_N_max - buchanan_N_0) * log(10)/buchanan_r_max)) * (buchanan_N_max - buchanan_N_0)
  }
  
  ## PREPARING A DATAFRAME WITH THE PLOTTING VALUES OF THE MODELS TO FEED IT TO GGPLOT2 ##
  linear_data = data.frame(t, linear, rep('linear', length(t)), rep(1, length(t)))
  names(linear_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  quadratic_data = data.frame(t, quadratic, rep('quadratic', length(t)), rep(2, length(t)))
  names(quadratic_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  cubic_data = data.frame(t, cubic, rep('cubic', length(t)), rep(3, length(t)))
  names(cubic_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  logistic_data = data.frame(t, logistic, rep('logistic', length(t)), rep(4, length(t)))
  names(logistic_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  gompertz_data = data.frame(t, gompertz, rep('gompertz', length(t)), rep(5, length(t)))
  names(gompertz_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  baranyi_data = data.frame(t, baranyi, rep('baranyi', length(t)), rep(6, length(t)))
  names(baranyi_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  buchanan_data = data.frame(t, buchanan, rep('buchanan', length(t)), rep(7, length(t)))
  names(buchanan_data) = c('t', 'Abundance', 'model', 'model_ID')
  
  model_data = rbind(linear_data, quadratic_data, cubic_data, logistic_data, gompertz_data, baranyi_data, buchanan_data)
  
  if(i != 68){
    model_index = info_criteria[[i]][-which(info_criteria[[i]]$delta_AIC.AIC_c > 10),]$index
    model_data = model_data[model_data$model_ID==model_index, ]
  }
  
  # plotting dataset with all the models overlaid
  print(ggplot(data = data_subset, aes(x = Time, y = PopBio_Log10)) +
          geom_point() +
          #coord_cartesian(ylim=c(min(model_data$Abundance[!is.nan(model_data$Abundance)])-0.1, max(model_data$Abundance[!is.nan(model_data$Abundance)])+0.1)) +
          geom_line(data = model_data, aes(x = t, y = Abundance, col = model), size = 1) +
          theme(panel.background = element_rect(fill = 'white', colour = 'black'), aspect.ratio = 1) +
          labs(x = "Time (h)", y = expression(paste(log[10], "(Abundance)")), 
               title = paste0("Population Growth Curve of ", as.character(unique(data_subset$Species))),
               subtitle = paste0("Temperature = ", as.character(unique(data_subset$Temp)), ", Medium = ", as.character(unique(data_subset$Medium)))))
  
  # close all graphics devices
  invisible(dev.off())
}
