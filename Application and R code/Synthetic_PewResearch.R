library(synthpop)
library(RCurl)

# Read data - 
originaldata <- read.csv(text = getURL("https://raw.githubusercontent.com/manslarsen/Synthetic-Data-Project/main/DataClean.csv"))

# creating syntheticic data
synthdata <- syn(originaldata)  
synthdata <- synthdata$syn

#comapre by graph
compare(synthdata, originaldata, vars ='sstate')
