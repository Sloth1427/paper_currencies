#script to test whether multiple linear regression analysis can be used to 
#estimate the total cost of producing different types of publications
#(e.g. papers in different journals.

#The number if papers published by a lab over a given period will be inputted, along
#with the total lab budget for that period. This data will be collected over many labs,
#so for each lab. Multiple linear regression analysis will then be carried out to 
#estimate the weight of each journal, i.e. how much it costs to produce one paper in that
#journal.

#In order to test this approach, date will be generated for virtual labs. Weights will be
#assigned to each journal (e.g. £500,000 for Nature, £400,000 for Cell, etc), and the number 
#of publications of each type that each virtual lab has will be randomly generated. The 
#theoretical budget over the period will then be calculated based on the journal weights 
#and the number of each publication type. Noise will then be added to this total budget.

#Multiple linear regression will then be performed on the budget with noise, and the number
#of papers of each type that each lab has. The estimated can then be compared with the weights 
#assigned to each journal.


rm(list=ls()) #clear workspace

#############################

numLabs <- 5000 #number of virtual labs being simulated

numJournals <- 1000 #number of vitual journals in publication lists, X1 ... Xn

labData <- data.frame(matrix(0, ncol = numJournals, nrow = numLabs))

colNames <- rep("", numJournals) #create empty character vector to put new colunm names into

#loop to create new column names
for (i in 1:numJournals){  
  colNames[i] <- paste0("Journal",i)
}
 
names(labData) <- colNames #rename columns

#seed labData with publication numbers  
for (i in 1:numJournals){
  labData[i] <- sample(0:5, numLabs,replace=TRUE)
}

#create vector of journal weights (price per publication in each journal)
journalWeights <- (sample(100000:600000, numJournals,replace=TRUE))

#total up theoretical budget for each lab
for (i in 1:numLabs){
  tempPub <- as.numeric(labData[i,1:numJournals])
  tempBudget <- tempPub*journalWeights
  labData$theoretical.budget[i] <- sum(tempBudget)
}

#add noise to theoretical budget to get 'actual' budget

noiseFactor <- 5000 #change to alter noise applied to theoretical budget
labData$actual.budget <- jitter(labData$theoretical.budget, factor = noiseFactor, amount = NULL)

plot(labData$theoretical.budget,labData$actual.budget,xlab="theoretical budget (£)",ylab="actual budget (£)")
title("Noise of actual budget compared to theoretical budget")

####prepare string of col names to go in to lm()

dataframeString <- ", data=labData"
yVar <- "actual.budget ~ "

string_for_lm <- yVar
string_for_lm <- paste0(string_for_lm,colNames[1])

for (i in 2:length(colNames)){
  string_for_lm <- paste0(string_for_lm," + ",colNames[i])
}

############### multiple regression
ptm <- proc.time()

#fit <- lm(actual.budget ~ Journal1 + Journal2 + Journal3 + Journal4 + Journal5, data=labData) #update
fit <- lm(eval(parse(text=string_for_lm)), data=labData)

time_for_lm <- proc.time() - ptm

summary <- data.frame(coef(summary(fit)))

weightEstimates <- summary[-(1:1),]
weightEstimates$JournalName <- weightEstimates$rownames


plot(journalWeights,weightEstimates$Estimate,xlab="theoretical journal weight (£)", ylab="estimated journal weight (£)")

journalWeights <- data.frame(journalWeights)
names(journalWeights[1]) <- "theoretical weights"

weightEstimates$theoretical <- journalWeights

weightEstimates$pct.Error <- (((weightEstimates$theoretical - weightEstimates$Estimate)/weightEstimates$theoretical)*100)

#barplot(weightEstimates$Estimate, names.arg=colNames, xlab="Journal",ylab="Cost per paper (£)")

forBarPlot <- data.frame(weightEstimates$Estimate,journalWeights)
forBarPlot <- t(forBarPlot)

barplot(as.matrix(forBarPlot),names.arg=colNames,main="Theoretical Journal costs per paper, vs estimate",xlab="Journal",ylab="Cost per paper (£)",beside = TRUE,col=c("black","gray"))
legend("topright",c("Estimate","True"),fill=c("black","gray"),bty="n")

print(paste0("Num labs: ",numLabs,". Num journals: ",numJournals))
print(time_for_lm)

#make better barplot with error bars for estimate

#