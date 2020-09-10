####prepare string of col names to go in to lm()
ptm <- proc.time()

colNames <- colnames(for_lm_top10pct_journals)
colNames <- colNames[-1]
colNames <- colNames[-1]
###

#dataframeString <- ", for_lm_no_empty_cols"
yVar <- "TOTAL_COST ~ "

string_for_lm <- yVar
string_for_lm <- paste0(string_for_lm,colNames[1])

for (i in 2:length(colNames)){
  string_for_lm <- paste0(string_for_lm," + ",colNames[i])
}

############### multiple regression

#fit <- lm(actual.budget ~ Journal1 + Journal2 + Journal3 + Journal4 + Journal5, data=labData) #update
fit <- lm(eval(parse(text=string_for_lm)), data=for_lm_top10pct_journals)

summary <- data.frame(coef(summary(fit)))

time <- proc.time() - ptm