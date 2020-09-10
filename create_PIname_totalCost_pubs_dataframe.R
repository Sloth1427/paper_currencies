#create the dataframe of PI_NAME,total cost, and journals
library(plyr) #use counting package

##create initial empty dataframe
# N.rows <- length(authors_with_US_pubs)
# 
# for_lm <- as.data.frame(matrix(0,nrow=N.rows,ncol=2 + length(pub_list)))
# 
# colnames(for_lm) <- pub_list


for (i in 1:nrow(for_lm)){
  print(i)
  tempName <- for_lm$PI_NAME[i]
  
  subsetName <- subset(PIs_and_pubs, PI_NAME == eval(tempName))
  
  tempJournalCounts <- count(subsetName,"ISSN_journal_ID")
  
  for (j in 1:nrow(tempJournalCounts)){
    tempColName <- as.character(tempJournalCounts$ISSN_journal_ID[j])
    tempColIndex <- as.numeric(grep(eval(tempColName),colnames(for_lm)))
    #print(tempJournalCounts$freq[j])
    for_lm[i,tempColIndex] <- tempJournalCounts$freq[j]
  }
  
}










#