#!/usr/bin/env R

# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list=ls())

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)){#loop through the populations
    
    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr,pop] <- N[yr-1,pop] * exp(r * (1 - N[yr - 1,pop] / K) + rnorm(1,0,sigma))
    
    }
  
  }
 return(N)

}

# same function as above, but with improved performance

stochrickvect<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
    
  for (yr in 2:numyears){ #for each pop, loop through the years
    N[yr,] <- N[yr-1,] * exp(r * (1 - N[yr - 1,] / K) + rnorm(1,0,sigma)) # taking the whole row into consideration instead of row element by element
  }
 
  return(N)

}

s1 = system.time(res1<-stochrick())[3] # store elapsed time of stochrick() function in a variable s1
print(paste("Non-vectorized Stochastic Ricker takes", as.numeric(s1), "seconds."), quote = FALSE)

s2 = system.time(res2<-stochrickvect())[3] # store elapsed time of stochrickvect() function in variable s2
print(paste("Vectorized Stochastic Ricker takes", as.numeric(s2), "seconds."), quote = FALSE)

ratio = s1/s2 # calculates the ratio of the elapsed times of the two functions
ratio = as.numeric(format(round(ratio, 2), nsmall = 2)) # formatting the ratio value to output only two digits after the decimal point
print(paste("Vectorizing the function reduced its speed by a magnitude of", ratio), quote = FALSE)
