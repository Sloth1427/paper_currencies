#script to separate out contact PI ID and name from others, in cases where joint application made

#split ID and author name based on ";", and then return then string containing "contact" to the dataframe

#R01_jointGrants <- R01data2005_2015[grep("ontact",R01data2005_2015$dataClean.PI_IDS),]

#loop to put contact PI ID into ID column
R01_jointGrantsTidy <-R01_jointGrants
R01_jointGrantsTidy$dataClean.PI_IDS <- as.character(R01_jointGrantsTidy$dataClean.PI_IDS)

for (i in 1:nrow(R01_jointGrantsTidy)){
  tempAuthorID <- strsplit(R01_jointGrantsTidy$dataClean.PI_IDS[i], ";", fixed = FALSE, perl = FALSE, useBytes = FALSE)
  
  tempAuthorID <- unlist(tempAuthorID, recursive = TRUE, use.names = TRUE)
  
  
  index <- grep(pattern = "ontact)", tempAuthorID)
  
  index <- as.numeric(index)
  
  R01_jointGrantsTidy$dataClean.PI_IDS[i] <- tempAuthorID[index]
  
}

R01_jointGrantsTidy$dataClean.PI_IDS <- gsub(pattern=" \\(contact\\)", "", R01_jointGrantsTidy$dataClean.PI_IDS)


#Tidy up author names
#NOTE! ";" is not consistently the separator! sometimes "," is used, which is also use between initials...


R01_jointGrantsTidy$dataClean.PI_NAMEs <- as.character(R01_jointGrantsTidy$dataClean.PI_NAMEs)  


for (i in 1:nrow(R01_jointGrantsTidy)){
  print(paste0("working on row ", i))
  print(paste0("author  ", R01_jointGrantsTidy$dataClean.PI_NAMEs[i]))
  
  tempAuthorName <- strsplit(R01_jointGrantsTidy$dataClean.PI_NAMEs[i], ";", fixed = FALSE, perl = FALSE, useBytes = FALSE)
  
  tempAuthorName <- unlist(tempAuthorName, recursive = TRUE, use.names = TRUE)
  
  
  index <- grep(pattern = "ontact)", tempAuthorName)
  
  index <- as.numeric(index)
  
  R01_jointGrantsTidy$dataClean.PI_NAMEs[i] <- tempAuthorName[index]
  
}
  
R01_jointGrantsTidy$dataClean.PI_NAMEs <- gsub(pattern=" \\(contact\\)", "", R01_jointGrantsTidy$dataClean.PI_NAMEs)