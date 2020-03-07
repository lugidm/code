# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 11/5/19
stackAPGD<-function(inputfiles){
    all<-raster()
    for(i in 1:length(inputfiles))
    {
        all<-addLayer(all, stack(inputfiles[[i]]))
    }
    all<-setZ(all, as.Date("1996-01-01")+0:(nlayers(all)-1))
    print(all)
    return(all)
}
getMeanAPGD<-function(allDays, lon, lat){
    print("getAnnualMeanObs")
    #f<-freq(pr_by_year[[1]], digits = 2, cum = TRUE, valid=TRUE, total=TRUE)
    #f<-f[1:357,]
    ##### REALLY EXPENSIVE CALCULATION
    #values(pr_by_year)[values(pr_by_year) == fVal_obs$value]=NA
    #pr_by_year<-calc(pr_by_year, fun=mean)
    pr_by_year<-raster()
    for(i in 1996:2005){
        dummy <- subset(allDays, grep(toString(i), names(allDays), value = T))
        #### REALLY EXPENSIVE CALCULATION
        dummy[dummy==fVal_apgd$value] <- NA
        dummy<-calc(dummy,fun=mean)
        print("ok")
        names(dummy) <- toString(i)
        plotJPGmean(raster=dummy, lon=lon, lat=lat, paste0("mprs-apgd-", toString(i), ".jpg"), plotmain=
        paste0("Annual mean precipitation[mm/day] of APGD-Dataset in year ",toString(i)), addMap=TRUE)
        pr_by_year <- addLayer(pr_by_year, dummy)
    }
    writeRaster(addLayer(addLayer(pr_by_year, lon), lat), paste0(dump_file_mprs_apgd), overwrite=TRUE, format="CDF",
    varname="mprs", varunit="mm/day", longname="Annual mean precipitation", xname="X", yname="Y", )
    return(addLayer(addLayer(pr_by_year, lon), lat))
}

cropMatrix<-function(xmin, xmax, ymin, ymax){
    #c<-matrix(nrow=20, ncol=23)
    c<-cbind(xmin,c(ymin:ymax))
    for(i in (xmin+1):xmax){
        c<-rbind(c,cbind(i,c(ymin:ymax)))
    }
    return(c)
}

getAPGDinYear<-function(allDays, year){
    dummy <- subset(allDays, grep(toString(year), names(allDays), value = T))
    #### REALLY EXPENSIVE CALCULATION
    dummy[dummy==fVal_apgd$value] <- NA
    return(dummy)
}

getQuantileObs <- function(allDays){
  qt_by_year<-raster()
  for(i in 1996:2005){
    date_string_start <- paste0(toString(i), "-01-01")
    date_string_end <- paste0(toString(i+1), "-01-01")
    extract_ids <- which((getZ(allDays) < as.Date(date_string_end))& (getZ(allDays) >= as.Date(date_string_start)))
    dummy<-subset(allDays, extract_ids)
    #### REALLY EXPENSIVE CALCULATION
    qt_by_year <- addLayer(qt_by_year, calc(dummy,Q99))
    names(qt_by_year[[i-1995]])<-paste0(date_string_start,"..", date_string_end)
  }
  return(qt_by_year)
}