#!/usr/bin/env R

# compares the computational speed between functions containing nested for loops and vectorized functions

#initialize
M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){ # loop through the rows
    for (j in 1:Dimensions[2]){ # loop through the columns
      Tot <- Tot + M[i,j] # add value of element to total sum of elements
    }
  }
  return (Tot)
}

# comparing computational speeds 
print("Using loops, the time taken is:", quote = FALSE)
time1 = print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:", quote = FALSE)
time2 = print(system.time(sum(M)))

# saving time values to be used later in the run_Vectorize.sh bash script
write.table(c(time1[[3]], time2[[3]]), "../data/Vectorize1_R.txt", row.names = FALSE, col.names = FALSE)
