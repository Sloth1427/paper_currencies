library(RISmed) #super cool library!

#colClasses <- c("factor","numeric","character","character")
#PIs_and_pubs <- read.csv(text="ISSN_journal_ID,Year,Country,PI_NAME", colClasses=colClasses)

for (i in 39790:nrow(R01data2005_2015_mainPI_Only_aggregate_NAMES)){ 

  Sys.sleep(0.5) #attempt to stop NCBI blocking access
  print(paste("working on row/PI ",i, " of ", nrow(R01data2005_2015_mainPI_Only_aggregate_NAMES)))
  
  authorName <- R01data2005_2015_mainPI_Only_aggregate_NAMES$PI_NAME[i]
  search_topic <- paste0(authorName,"[Author - Last]")
  #print(search_topic)
  print(authorName)
  max_results = 100
  from = 2005
  to = 2015
  search_query <- EUtilsSummary(search_topic, retmax=max_results, mindate=from, maxdate=to)

  #summary(search_query)
  records<- EUtilsGet(search_query)

  pubmed_data <- data.frame('ISSN_journal_ID'=ISSN(records),'Year'=YearPubmed(records),'Country'=Country(records))
  
  pubmed_data$Country <- as.character(pubmed_data$Country)
  pubmed_data <- subset(pubmed_data, Country == "United States")
  #pubmed_data$PI_NAME <- authorName
  
  print(paste0("num pubs from US: ",nrow(pubmed_data)))
  if (nrow(pubmed_data) != 0){
    pubmed_data$PI_NAME <- authorName
    PIs_and_pubs <- rbind(PIs_and_pubs,pubmed_data)
  }
  
  #save every 1000 PIs
  if (i/1000 == round(i/1000)){
    write.csv(PIs_and_pubs,file="PIs_and_pubs.csv")
    print(paste("file written"))
  }
  
}
  
write.csv(PIs_and_pubs,file="PIs_and_pubs.csv")pub