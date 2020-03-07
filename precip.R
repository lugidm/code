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
getPrecipAll <- function(inputfiles){
    pr<-raster()
    for(inputfile in inputfiles)
    {
        if(ALP3 == TRUE)
        {
            pr<-addLayer(pr,stack(inputfile, varname = "TOT_PREC"))
        }else{
            pr<-addLayer(pr,stack(inputfile, varname = "pr"))
        }
    }
    pr<-setZ(pr, as.Date("1996-01-01")+0:(nlayers(pr)-1))
    print(pr)
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

getAPGDAnnualStack <- function(filenames){
    return(stack(filenames, varname="PRECIPITATION"))

}

#### FOR ALP3-REMAPPED ##########
getAnnualMean <- function(inputfiles, time_list, data_type){
    output_raster <- raster()
    for(i in 1:length(inputfiles))
    {
        prs <- getPrecip(inputfiles[[i]])
        print("MEAN")
        #cells<-cellFromXY(prs, cropMatrix(xmin=1, xmax=10, ymin=1,ymax=80))
        #for(j in 1:nlayers(prs)){prs[[j]][cells]<-NA}
        mprs <- calc((prs), fun=mean)
        names(mprs)<-time_list[i]
        output_raster<-addLayer(output_raster, mprs)
        lon <- raster(inputfiles[[i]], varname="lon")
        lat <- raster(inputfiles[[i]], varname="lat")
        plotJPGmean(raster=mprs, lon=lon, lat=lat, filename=paste0("mprs-", time_list[i],data_type,"-alp3.jpg"),plotmain=
        paste0("Mean precipitation[mm/day] in year ", time_list[i]," in ALP-3 ", data_type, "-data"), addMap=TRUE)
    }
    writeRaster(addLayer(addLayer(output_raster, lon), lat), paste0(output_dir,"mprs-alp3-", data_type,".nc"), overwrite=TRUE, format="CDF",
    varname="mprs", varunit="mm/day", longname="Annual mean precipitation", xname="X", yname="Y")
    return(addLayer(addLayer(output_raster, lon), lat))
}

getPR<-function(inputfiles, varname, mV_name){
  dummy<-nc_open(inputfiles[[1]])
  mV<-ncatt_get(dummy, varname, mV_name)$value
  nc_close(dummy)
  return_vals<- stack(inputfiles, varname=varname)
  return_vals[return_vals==mV]<-NA
  return(return_vals)
}
