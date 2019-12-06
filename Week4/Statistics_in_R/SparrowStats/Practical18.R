rm(list=ls())
setwd("~/Documents/Statistics_in_R/SparrowStats/")

a = read.table("../HandOutsandData'18/ObserverRepeatability.txt", header = TRUE)

require(dplyr, quietly = TRUE, warn.conflicts = FALSE)

a %>%
  group_by(StudentID) %>%
  summarise(count=length(StudentID))

a %>%
  group_by(StudentID) %>%
  summarise(count=length(StudentID)) %>%
    summarise(length(StudentID))

a %>%
  group_by(StudentID) %>%
  summarise(count=length(StudentID)) %>%
    summarise(sum(count))

length(a$StudentID)

a %>%
  group_by(StudentID) %>%
  summarise(count=length(StudentID)) %>%
  summarise(sum(count^2))

mod=lm(Tarsus~StudentID, data=a)
anova(mod)

mod=lm(Tarsus~Leg+Handedness+StudentID, data=a)
anova(mod)

require(lme4, quietly = TRUE)

lmm=lmer(Tarsus~Leg+Handedness+(1|StudentID), data=a)
summary(lmm)

var(a$Tarsus)
3.03+1.71
