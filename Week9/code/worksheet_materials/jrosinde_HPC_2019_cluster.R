# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice
graphics.off() # good practice

# Loading the main R file which includes the needed functions
source("jrosinde_HPC_2019_main.R")

#iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

do_simulation = function(iter){
  # set random seed as iter
  set.seed(iter)
  
  # select your simulation parameters
  if(iter %% 4 == 1){
    size = 500
  } else if(iter %% 4 == 2){
    size = 1000
  } else if(iter %% 4 == 3){
    size = 2500
  } else if(iter %% 4 == 0){
    size = 5000
  }
  speciation_rate = personal_speciation_rate
  wall_time = 11.5 * 60
  interval_rich = 1
  interval_oct = size/10
  burn_in_generations = 8*size
  output_file_name = paste0(c("results_",iter,".rda"), collapse = "")
  
  # run the simulation
  cluster_run(speciation_rate = speciation_rate, size = size, wall_time = wall_time, interval_rich = interval_rich, 
              interval_oct = interval_oct, burn_in_generations = burn_in_generations, output_file_name = output_file_name)
}

#do_simulation(iter)

# to run locally instead of on the cluster, uncomment this part and comment the code: iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
for(iter in 1:100){
  do_simulation(iter)
}


