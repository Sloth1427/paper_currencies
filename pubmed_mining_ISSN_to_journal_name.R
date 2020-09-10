#searching pubmed NLM database to get journal name from ISSN

#rm(list=ls()) #clear workspace

library(RISmed) #super cool library!
search_topic <- "0036-8075[ISSN]"
max_results = 100
from = 2005
to = 2015
search_query <- EUtilsSummary(search_topic, retmax=max_results,db="nlmcatalog")

summary <- summary(search_query)
records<- EUtilsGet(search_query)

pubmed_data <- data.frame('Title'=Title(records),'ISSN'=ISSN(records),'Country'=Country(records))

print(pubmed_data)

print(QueryTranslation(search_query))