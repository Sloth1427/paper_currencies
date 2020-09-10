


for (i in 1:nrow(journalFreqs)){
  journalFreqs$cumulative_freq[i] <- sum(journalFreqs$pct_of_total[1:i])
  
}
