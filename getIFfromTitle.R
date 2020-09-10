getIFfromTitle <- function(title){
  
  title <- gsub(" ","+",title)
  
  url <- paste0("https://www.google.co.uk/#q=",title,"+impact+factor")
  lines <- readLines(url, warn = FALSE, encoding = "unknown")
  
#   EMPTYCHECK <- length(grep("<eSearchResult><Count>0<\\/Count>", lines)) != 0 #nifty logical thingy!
#   MULTICHECK <- length(grep("<title>", lines)) != 1 #nifty logical thingy!
#   
#   if (EMPTYCHECK) {
#     print("NO RESULTS FOUND")
#     title <- NA
#     #res$Id <- character(0)
#     #res$Count <- 0
#   }
#   
#   if (MULTICHECK){
#     print("MORE THAN ONE RESULT FOUND")
#     title <- NA
#   }
#   
#   
#   titleLine <- lines[grep("<title>",lines)] #title line
#   title <- gsub("(^.+<title>+)(.+)(\\s-\\sNLM.+$)", "\\2", titleLine)
#   #print(title)
#   
  #return(title)
  return(lines)
}

print(getIFfromTitle("Nature"))
