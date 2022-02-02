library(synthpop)
library(RCurl)

# Read data
originaldata <- read.csv(text = getURL("https://raw.githubusercontent.com/manslarsen/Synthetic-Data-Project/main/HIV-DATA%20.csv"))
originaldata <- originaldata[, c(2,3,4,5, 6, 7, 8)]

#Synthesize data
synthdata <- syn(originaldata)  
synthdata <- synthdata$syn

#comapre by graph
compare(synthdata, originaldata, vars ='HIV.Positive')


