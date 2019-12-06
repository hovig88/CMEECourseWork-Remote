#!/usr/bin/env R

i <- 0 #Initialize i
while(i < Inf){
    if (i == 10) {
        print("i reached 10... breaking out of the while loop...", quote = FALSE)
        break
    } # Break out of the while loop!
    else {
        cat("i equals ", i, " \n")
        i <- i + 1 # Update i
    }
}
