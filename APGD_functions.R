# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 11/5/19
stackAPGD<-function(inputfiles){
  all<-raster()  
  listus<-list('1996'=raster(), '1997'=raster(), '1998'=raster(), '1999'=raster(),'2000'=raster(), '2001'=raster(),
              '2002'=raster(), '2003'=raster(), '2004'=raster(),'2005'=raster())
  for(i in 1:length(inputfiles))
  {
    all<-addLayer(all, stack(inputfiles[[i]], varname='PRECIPITATION'))
  }
  all<-setZ(all, as.Date("1996-01-01")+0:(nlayers(all)-1))
  for(i in 1996:2005)
  {
    ids<-which((getZ(all) <= as.Date(paste0(paste0(toString(i),"-12-31"))))& (getZ(all) >= as.Date(paste0(toString(i),"-01-01"))))
    listus[[i-1995]]<-subset(all,ids)
  }
    #print(all)
    return(listus)
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

cropExtent<-function(ex, raster_list){
  #c<-matrix(nrow=20, ncol=23)
  for(i in 1:length(raster_list)){
    na_raster<-crop(raster_list[[i]], ex)
    values(na_raster)<-NA
    raster_list[[i]]<-merge(na_raster, raster_list[[i]], overlap=FALSE)
  }
  return(raster_list)
}