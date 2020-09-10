#Turn author names from "surname, firstname middleinitial" to "surname initials", e.g. "Bloggs JR"

#remove any leading " "
trim.leading <- function (x)  sub("^\\s+", "", x)
trim.trailing <- function (x) sub("\\s+$", "", x)
#trim.leading(R01data2005_2015_mainPI_Only$SURNAME_INITALS)
trim.trailing(R01data2005_2015_mainPI_Only$SURNAME_INITALS)

#get rid of anything after 2nd comma, if name contains more than one commma

# for (i in 1:nrow(R01data2005_2015_mainPI_Only){
#   if which(R01data2005_2015_mainPI_Only$PI_NAMEs


#get surname and initials from name

# for (i in 1:nrow(R01data2005_2015_mainPI_Only)){
#   print(paste0("working on row ", i))
#   print(paste0("author  :", R01data2005_2015_mainPI_Only$PI_NAMEs[i]))
#   
#   tempAuthorName <- strsplit(R01data2005_2015_mainPI_Only$PI_NAMEs[i], " ", fixed = FALSE, perl = FALSE, useBytes = FALSE)
# 
#   tempAuthorName <- unlist(tempAuthorName, recursive = TRUE, use.names = TRUE)
#   print(tempAuthorName)
#   
#   test <- which(tempAuthorName == "")
#   if (length(test) > 0){
#     tempAuthorName <- tempAuthorName[-(which(tempAuthorName == ""))]
#   }
#   
#   tempString <- tempAuthorName[1]
#   for (j in 2:length(tempAuthorName)){
#     tempInitial <- as.character(tempAuthorName[j])
#     tempString <- paste0(tempString, " ", substring(tempInitial,1,1))
#   }
#   
#   R01data2005_2015_mainPI_Only$SURNAME_INITALS[i] <- tempString
#   
# }


#if num initials is > 2, remove all but first two initials
R01data2005_2015_mainPI_Only$SURNAME_INITALS3 <- R01data2005_2015_mainPI_Only$SURNAME_INITALS2

for (i in 1:nrow(R01data2005_2015_mainPI_Only)){
  tempSurnameInitials2 <- strsplit(R01data2005_2015_mainPI_Only$SURNAME_INITALS2[i], " ", fixed = FALSE, perl = FALSE, useBytes = FALSE)
  tempSurnameInitials2 <- unlist(tempSurnameInitials2, recursive = TRUE, use.names = TRUE)

  if (nchar(tempSurnameInitials2[2]) > 2){
    #print("temp[2] > 2")
    tempSurnameInitials2[2] <- substr(tempSurnameInitials2[2], 1,2)
    R01data2005_2015_mainPI_Only$SURNAME_INITALS3[i] <- paste0(tempSurnameInitials2[1]," ",tempSurnameInitials2[2])
  }

}

#