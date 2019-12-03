# to check which species has the most temperature changes
#maxLen = 0
#for(i in unique(myData$Species)){
#  len = length(unique(myData$Temp[which(myData$Species == i)]))
#  if(len > maxLen)
#    maxLen = len
#}
#print(maxLen)

# to check if PopBio units are the same within Species
#for(i in unique(LogisticGrowthData$Species)){
#    print(unique(LogisticGrowthData$PopBio_units[which(LogisticGrowthData$Species == i)]))
#}