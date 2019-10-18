# without pre-allocation
a <- NA
print(system.time(
    for (i in 1:10000) {
        a <- c(a, i)
        # print(a)
        # print(object.size(a))
    }
))


# with pre-allocate
a <- rep(NA, 10000)
print(system.time(
    for (i in 1:10000) {
    a[i] <- i
    # print(a)
    # print(object.size(a))
    }
))