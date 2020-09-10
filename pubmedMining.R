rm(list=ls()) #clear workspace

library(RISmed) #super cool library!
search_topic <- ""
max_results = 20000
from = 2016
to = 2017
search_query <- EUtilsSummary(search_topic, retmax=max_results, mindate=from, maxdate=to)

summary(search_query)
records<- EUtilsGet(search_query)

pubmed_data <- data.frame('Title'=ArticleTitle(records), 'pubmedID'=PMID(records))

pubmed_data