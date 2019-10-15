
# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 03.10.19

getAnnualMeanObs <- function(allDays)
{
    print("meancalc")
    pr_by_year<-calc(subset(allDays, which(getZ(allDays)<as.Date('1996-01-01'))), mean)
    for(i in 1996:1998){
        date_string_start <- paste0(toString(i), "-01-01")
        date_string_end <- paste0(toString(i+1), "-01-01")
        extract_ids <- which((getZ(allDays) < as.Date(date_string_end))& (getZ(allDays) >= as.Date(date_string_start)))
        pr_by_year <- addLayer(pr_by_year, calc(subset(allDays, extract_ids),mean))
    }
    return(pr_by_year)
}

getPrecipObs <- function(inputfile, layers){

    pr <- stack(inputfile, varname="rr")
    pr <- subset(pr, which(getZ(pr) < as.Date('2006-01-01')))
    print("rastered and subset")
    #print(pr)
    #pr[pr==fVal_obs$value]<-NA
    return(pr)
}

getPrecip <- function(inputfile){
    pr<-stack(inputfile, varname = "pr")
    pr[pr==fVal_sim$value]<-NA
    return(pr)
}