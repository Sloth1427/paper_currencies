data <- RePORTER_PRJ_C_FY2015


dataClean <- subset(data, ACTIVITY == "R01")

dataClean <- data.frame(dataClean$FULL_PROJECT_NUM, dataClean$PI_IDS, dataClean$PI_NAMEs, dataClean$TOTAL_COST)

dataClean$YEAR <- 2015

write.csv(dataClean, file = "R01_2015.csv")