rm(list=ls())
setwd("~/Documents/Statistics_in_R/SparrowStats")

d=read.table("SparrowSize.txt", header=TRUE)
d1=subset(d, d$Tarsus!="NA")
seTarsus=sqrt(var(d1$Tarsus)/length(d1$Tarsus))
print(seTarsus)

d12001=subset(d1, d1$Year==2001)
seTarsus2001=sqrt(var(d12001$Tarsus)/length(d12001$Tarsus))
print(seTarsus2001)

ciTarsus=1.96*seTarsus
ciTarsus2001=1.96*seTarsus2001

setMass=subset(d, d$Mass!="NA")
seMass=sqrt(var(setMass$Mass)/length(setMass$Mass))
print(seMass)

ciMass=1.96*seMass

setWing=subset(d, d$Wing!="NA")
seWing=sqrt(var(setWing$Wing)/length(setWing$Wing))
print(seWing)

ciWing=1.96*seWing

setBill=subset(d, d$Bill!="NA")
seBill=sqrt(var(setBill$Bill)/length(setBill$Bill))
print(seBill)

ciBill=1.96*seBill