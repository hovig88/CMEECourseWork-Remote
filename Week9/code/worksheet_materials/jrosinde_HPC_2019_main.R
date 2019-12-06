# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Hovig Artinian"
preferred_name <- "Hovig"
email <- "ha819@ic.ac.uk"
username <- "ha819"
personal_speciation_rate <- 0.002341 # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
species_richness <- function(community){
  return(length(unique(community))) # returns the number of unique species present in the community vector
}

# Question 2
init_community_max <- function(size){
  return(seq(size)) # returns an initial community with 'size' number of different species
}

# Question 3
init_community_min <- function(size){
  return(rep(1, size)) # returns an initial state of a certain size of the community with the minimum possible number of each species
}

# Question 4
choose_two <- function(max_value){
  return(sample(max_value, size = 2, replace = FALSE, prob = NULL)) # returns two values from a uniform distribution between 1 and max_value without replacement and equal probabilities
}

# Question 5
neutral_step <- function(community){
  ind_two = choose_two(length(community)) # stores two randomly chosen values from the community vector in the variable ind_two, which will be used as indexes
  community[ind_two[1]] = community[ind_two[2]] # replace the value of the first index with the value of the second index, which signifies the replacement of a dead individual with the offspring of another individual
  return(community) # returns the new community vector
}

# Question 6
neutral_generation <- function(community){
  # randomly choose to round up or down when x is odd
  x = length(community)/2
  n = ifelse(x%%1 == 0.5, sample(c(ceiling, floor), 1)[[1]](x), x) # n will be the number of times the neutral_step function will run
  # the above if else function operates as follows:
  # - if x is odd, we will randomly choose to round it up or down (ceiling rounds up a decimal value, while floor rounds it down)
  # - else, we return the value of x itself
  for(i in 1:n){
    community = neutral_step(community) # we perform neutral_step n times, we expect to have n replacements in the community
  }
  return(community) # returns the new community vector
}

# Question 7
neutral_time_series <- function(community = init_community_max(7), duration = 20)  {
  diversity = length(unique(community)) # calculates the species richness of the community in its initial state
  for(i in 1:duration){ # repeats the neutral model simulation for a certain number of generations (20 by default)
    community = neutral_generation(community) # for each generation, replace the old community vector with its new state (after it has been run through the simulation)
    diversity[i+1] = length(unique(community)) # add the species richness value of each generation to the diversity vector
  }
  return(diversity) # returns the diversity vector, whose elements are the species richness of 'duration' generations
}

# Question 8
question_8 <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  generations = 200 # number of generations, which will indicate the number of times the simulation will run
  richness = neutral_time_series(community = init_community_max(100), duration = generations) # stores the species richness vector using the neutral_time_series function for 100 individuals during 200 generations
  plot(0:generations, richness, # we start from 0 because we want the x and y vectors to have equal lengths
       col = "red", type = "l", xlab = "Generation", ylab = "Species diversity", main = "Time Series of Neutral Model Simulation") 
  return(print("We expect the system to always converge to 1 if we wait long enough. This is because we expect, at each generation, the replacement of some individuals with others. On the long run, this will cause decline in the species diversity. Therefore, eventually, we will be left with one type of species.", quote = FALSE))
}

# Question 9
neutral_step_speciation <- function(community = init_community_max(7), speciation_rate = 0.2)  {
  ind_two = choose_two(length(community)) # stores two randomly chosen values from the community vector in the variable ind_two, which will be used as indexes
  community[ind_two[1]] = ifelse(runif(1) > speciation_rate, community[ind_two[2]], max(community)+1)
  # the above if else function operates as follows:
  # - if the random uniform number is greater than the rate of speciation, replace the dead species with an offspring of another existing species (as we do in the neutral_step function)
  #  else, we replace the dead species with a new species (this indicates speciation)
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community = init_community_max(7), speciation_rate = 0.2)  {
  # randomly choose to round up or down when x is odd
  x = length(community)/2
  n = ifelse(x%%1 == 0.5, sample(c(ceiling, floor), 1)[[1]](x), x) # n will be the number of times the neutral_step function will run
  # the above if else function operates as follows:
  # - if x is odd, we will randomly choose to round it up or down (ceiling rounds up a decimal value, while floor rounds it down)
  # - else, we return the value of x itself
  for(i in 1:n){
    community = neutral_step_speciation(community, speciation_rate) # we perform neutral_step_speciation n times, we expect to have n replacements in the community
  }
  return(community) # returns the new community vector
}

# Question 11
neutral_time_series_speciation <- function(community = init_community_max(7), speciation_rate = 0.2, duration = 5)  {
  diversity = length(unique(community)) # calculates the species richness of the community in its initial state
  for(i in 1:duration){ # repeats the neutral model simulation for a certain number of generations (20 by default)
    community = neutral_generation_speciation(community, speciation_rate) # for each generation, replace the old community vector with its new state (after it has been run through the simulation with the possibility of speciation)
    diversity[i+1] = length(unique(community)) # add the species richness value of each generation to the diversity vector
  }
  return(diversity) # returns the diversity vector, whose elements are the species richness of 'duration' generations
}

# Question 12
question_12 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  generations = 200 # number of generations, which will indicate the number of times the simulation will run
  richness_max = neutral_time_series_speciation(community = init_community_max(100), speciation_rate = 0.1, duration = generations) # stores the species richness vector using the neutral_time_series function for 100 individuals during 200 generations
  richness_min = neutral_time_series_speciation(community = init_community_min(100), speciation_rate = 0.1, duration = generations)
  plot(0:generations, richness_max, # we start from 0 because we want the x and y vectors to have equal lengths
       col = "red", type = "l", xlab = "Generation", ylab = "Species diversity", main = "Time Series of Neutral Model Simulation")
  lines(0:generations, richness_min, col = "blue")
  legend(120, 99, legend = c("initialise_max", "initialise_min"), col = c("red", "blue"), lty = 1)
  return("We find that initial conditions don't really matter very much because after a certain time, both will converge to a low value for species diversity. In the case where we start with maxium possible value for the species diversity...")
}

# Question 13
species_abundance <- function(community = c(1,5,3,6,5,6,1,1))  {
  abundance = as.numeric(table(community)) # gives the counts (abundance) of each species in the community
  return(sort(abundance, decreasing = TRUE)) # returns the abundance vector of species in decreasing order
}

# Question 14
octaves <- function(abundance_vector = c(100, 64, 63, 5, 4, 3, 2, 2, 1, 1, 1, 1)) {
  return(tabulate(floor(log2(abundance_vector))+1))
}

# Question 15
sum_vect <- function(x = c(1,3), y = c(1, 0, 5, 2)) {
  if(length(x) > length(y)){
    y = append(y, rep(0, abs(length(x)-length(y))), length(y)) # the abs(length(x)-length(y)) function is needed to know how many zeros are to be added to y to make its length equal to that of x
  } else if(length(x) < length(y)) {
    x = append(x, rep(0, abs(length(x)-length(y))), length(x)) # same function with x being the shorter vector
  }
  return(x+y) # returns the sum of the two vectors
}

# Question 16 
question_16 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  generations = 200 # number of generations, which will indicate the number of times the simulation will run
  richness_max = neutral_time_series_speciation(community = init_community_max(100), speciation_rate = 0.1, duration = generations) # stores the species richness vector using the neutral_time_series function for 100 individuals during 200 generations
  richness_min = neutral_time_series_speciation(community = init_community_min(100), speciation_rate = 0.1, duration = generations)
  
  return("type your written answer here")
}

# Question 17
cluster_run <- function(speciation_rate = 0.1, size = 100, wall_time = 0.1, interval_rich = 1, interval_oct = 10, burn_in_generations = 200, output_file_name = "my_test_file_1.rda")  {
  community = init_community_min(size)
  ptm = proc.time() # saving start time
  gen_count = 0
  burn_in_rich = integer()
  species_abundance_octaves = list()
  while (as.numeric((proc.time() - ptm)[3]) <= (wall_time*60)) {
    if((gen_count %% interval_rich == 0) & (gen_count <= burn_in_generations)){
      burn_in_rich = c(burn_in_rich, species_richness(community))
    }
    
    if(gen_count %% interval_oct == 0){
      species_abundance_octaves = c(species_abundance_octaves, list(octaves(species_abundance(community))))
    }
    gen_count = gen_count + 1
    
    community = neutral_generation_speciation(community, speciation_rate)
  }
  
  save(burn_in_rich, species_abundance_octaves, community, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = output_file_name)
  return(0)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  rda_files = list.files(path = ".", pattern = "results_")
  octaves_500 = 0; octaves_1000 = 0; octaves_2500 = 0; octaves_5000 = 0
  count_500 = 0; count_1000 = 0; count_2500 = 0; count_5000 = 0
  for(i in rda_files){
    load(i)
    burn_in = burn_in_generations / interval_oct
    print(burn_in)
    octaves_without_burn_in = species_abundance_octaves[-seq(burn_in)]
    print(octaves_without_burn_in)
    if(size == 500){
      for(j in 1:length(octaves_without_burn_in)){
        octaves_500 = sum_vect(octaves_500, octaves_without_burn_in[[j]])
        count_500 = count_500 + 1
      }  
    } else if(size == 1000){
        for(j in 1:length(octaves_without_burn_in)){
          print(j)
          octaves_1000 = sum_vect(octaves_1000, octaves_without_burn_in[[j]])
          count_1000 = count_1000 + 1
        }
      } else if(size == 2500){
          for(j in 1:length(octaves_without_burn_in)){
              octaves_2500 = sum_vect(octaves_2500, octaves_without_burn_in[[j]])
              count_2500 = count_2500 + 1
          }
        } else if(size == 5000){
            for(j in 1:length(octaves_without_burn_in)){
              octaves_5000 = sum_vect(octaves_5000, octaves_without_burn_in[[j]])
              count_5000 = count_5000 + 1
            }
          }  
  }
  
  mean_500 = octaves_500 / count_500; mean_1000 = octaves_1000 / count_1000
  mean_2500 = octaves_2500 / count_2500; mean_5000 = octaves_5000 / count_5000
  
  par(mfrow=c(2,2))
  barplot(mean_500)
  barplot(mean_1000)
  barplot(mean_2500)
  barplot(mean_5000)
  combined_results <- list(mean_500, mean_1000, mean_2500, mean_5000) #create your list output here to return
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  fractal_dim = list((log(8)/log(3)), print("One unit of the object is enlarged by 3 and repeated 8 times in total which gives us the equation 3^x = 8, where x is the fractal dimension. To find x, we log both sides of the equation. x = log(8)/log(3).", quote = FALSE))  
  return(fractal_dim)
}

# Question 22
question_22 <- function()  {
  fractal_dim = list((log(20)/log(3)), print("One unit of the object is enlarged by 3 and repeated 20 times in total which gives us the equation 3^x = 20, where x is the fractal dimension. To find x, we log both sides of the equation. x = log(20)/log(3).", quote = FALSE))
  return(fractal_dim)
}

# Question 23
chaos_game <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(0,0)
  
  midpoint_coords <- function(a, b) {
    coords = c((a[1]+b[1])/2, (a[2]+b[2])/2)
    return(coords)
  }
  
  plot(X[1], X[2], cex = 0.2, xlim = c(0, 4.1), ylim = c(0, 4.1))
  
  for(i in 1:100000){
    choose_point = sample(list(A, B, C), size = 1)[[1]]
    X = midpoint_coords(X, choose_point)
    points(X[1], X[2], cex = 0.2)
  }
  return("type your written answer here")
}

# Question 24
turtle <- function(start_position, direction, length)  {
  endpoint = integer()
  endpoint[1] = length * cos(direction) + start_position[1]
  endpoint[2] = length * sin(direction) + start_position[2]
  lines(c(start_position[1], endpoint[1]), c(start_position[2], endpoint[2]))
  return(endpoint) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  start_position_2 = turtle(start_position, direction, length)
  direction_2 = direction - (pi/4)
  length_2 = length * 0.95
  endpoint_2 = turtle(start_position_2, direction_2, length_2)
  lines(c(start_position_2[1], endpoint_2[1]), c(start_position_2[2], endpoint_2[2]))
}

# Question 26
spiral <- function(start_position = c(0,1), direction = (pi/2), length = 2)  {
  start_position_2 = turtle(start_position, direction, length)
  direction_2 = direction - (pi/4)
  length_2 = length * 0.95
  if(length_2 >= 1e-10) {
    endpoint_2 = spiral(start_position_2, direction_2, length_2)
  } else {
      return("line gets too small to be drawn")
    }
}

# Question 27
draw_spiral <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  plot.window(xlim = c(0,5), ylim = c(0,5))
  axis(1)
  axis(2)
  spiral()
}

# Question 28
tree <- function(start_position = c(0,0), direction = (pi/2), length = 2)  {
  start_position_2 = turtle(start_position, direction, length)
  direction_left = direction + (pi/4)
  direction_right = direction - (pi/4)
  length_2 = length * 0.65
  if(length_2 >= 0.01) {
    endpoint_left = tree(start_position_2, direction_left, length_2)
    endpoint_right = tree(start_position_2, direction_right, length_2)
  } else {
    return("line gets too small to be drawn")
  }
}
draw_tree <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  plot.window(xlim = c(-4,4), ylim = c(0,5))
  axis(1)
  axis(2)
  tree()
}

# Question 29
fern <- function(start_position = c(0,0), direction = (pi/2), length = 2)  {
  start_position_2 = turtle(start_position, direction, length)
  direction_left = direction + (pi/4)
  if(length >= 0.01) {
    endpoint_left = fern(start_position_2, direction_left, length*0.38)
    endpoint_straight = fern(start_position_2, direction, length*0.87)
  } else {
    return("line gets too small to be drawn")
  }
}
draw_fern <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  plot.window(xlim = c(-4,4), ylim = c(0,15))
  axis(1)
  axis(2)
  fern()
}

# Question 30
fern2 <- function(start_position = c(0,0), direction = (pi/2), length = 2, dir = -1)  {
  start_position_2 = turtle(start_position, direction, length)
  if(length >= 0.01) {
    endpoint_left_right = fern2(start_position_2, direction - dir * (pi/6), length*0.38, dir)
    endpoint_straight = fern2(start_position_2, direction, length*0.87, dir*-1)
  } else {
    return("line gets too small to be drawn")
  }
}

draw_fern2 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  plot.window(xlim = c(-4,4), ylim = c(0,15))
  axis(1)
  axis(2)
  fern2()
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


