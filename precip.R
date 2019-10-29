# Title     : precip.R
# Objective : precipcalculaction
# Created by: lugi
# Created on: 03.10.19


getPrecipObs <- function(inputfile, layers){

    pr <- stack(inputfile, varname="rr")
    pr <- subset(pr, which(getZ(pr) < as.Date('2006-01-01')))
    print("rastered and subset")
    #print(pr)
    #pr[pr==fVal_obs$value]<-NA
    return(pr)
}

getPrecip <- function(inputfile){
    if(ALP3 == TRUE)
    {
        pr<-stack(inputfile, varname = "TOT_PREC")
    }else{
        pr<-stack(inputfile, varname = "pr")
    }
    #values(pr)[values(pr) == fVal_sim$value]=NA
    #print("fillValue Done")
    return(pr)
}

getAnnualQuantileObs <- function(allDays){
    print("quantilecalc")
    #f<-freq(qt_by_year[[1]], digits = 2, cum = TRUE, valid=TRUE, total=TRUE)
    #f<-f[1:357,]
    qt_by_year<-subset(allDays, which(getZ(allDays)<as.Date('1996-01-01')))
    ##### REALLY EXPENSIVE CALCULATION
    values(qt_by_year)[values(qt_by_year) == fVal_obs$value]=NA
    qt_by_year<-calc(qt_by_year, Q99)
    for(i in 1996:2005){
        date_string_start <- paste0(toString(i), "-01-01")
        date_string_end <- paste0(toString(i+1), "-01-01")
        extract_ids <- which((getZ(allDays) < as.Date(date_string_end))& (getZ(allDays) >= as.Date(date_string_start)))
        dummy<-subset(allDays, extract_ids)
        #### REALLY EXPENSIVE CALCULATION
        dummy[dummy==fVal_obs$value] <- NA
        qt_by_year <- addLayer(qt_by_year, calc(dummy,Q99))
    }
    return(qt_by_year)
}