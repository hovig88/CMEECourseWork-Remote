# housekeeping
rm(list=ls())
setwd("~/Documents/Statistics_in_R/SparrowStats")
d=read.table("SparrowSize.txt", header=TRUE)

# visualization
boxplot(d$Mass~d$Sex.1, col = c("red", "blue"), ylab = "Body mass (g)")

# t-test
t.test1=t.test(d$Mass~d$Sex.1)
print(t.test1)

# reducing dataset to see if we get similar result
d1=as.data.frame(head(d, 50))
length(d1$Mass)

t.test2=t.test(d1$Mass~d1$Sex)
print(t.test2)

# wing length 2001 vs wing length total
meanWing = mean(d$Wing, na.rm = TRUE)
set2001=subset(d, d$Year == 2001)
t.test.Wing = t.test(set2001$Wing, mu = meanWing, na.rm = TRUE)
print(t.test.Wing)

# male wing length 2001 vs female wing length 2001
t.test.Wing.Sex.2001 = t.test(set2001$Wing~set2001$Sex.1, na.rm = TRUE)
print(t.test.Wing.Sex.2001)

# male wing length total vs female wing length total
t.test.Wing.Sex = t.test(d$Wing~d$Sex.1, na.rm = TRUE)
print(t.test.Wing.Sex)

# male tarsus length total vs female tarsus length total
t.test.Tarsus.Sex = t.test(d$Tarsus~d$Sex.1, na.rm = TRUE)
print(t.test.Tarsus.Sex)