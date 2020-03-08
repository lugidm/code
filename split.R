# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 11/13/19
library(rlist)
splitMonthlyOBS<-function(all_days, lon, lat, new_filename){
    ids_by_month<-list(1,2,3,4,5,6,7,8,9,10,11,12)
    for(i in 1996:2005){
        for(months in 1:12)
        {
            if(months==12)
            {
                date_string_start <- paste0(toString(i), "-",toString(months), "-01")
                date_string_end <- paste0(toString(i+1), "-01-01")
            }else{
                date_string_start <- paste0(toString(i), "-",toString(months), "-01")
                date_string_end <- paste0(toString(i), "-", toString(months+1), "-01")
            }
            ids_by_month[[months]] <- list(unlist(ids_by_month[[months]]), which((getZ(all_days) < as.Date(date_string_end))& (getZ(all_days) >= as.Date(date_string_start))))
            ids_by_month[[months]]<-unlist(ids_by_month[[months]])
        }
    }
    for(i in 1:12){ids_by_month[[i]]<-ids_by_month[[i]][-1]} # DELETE FIRST ELEMENT (JUST THE INITIATION VALUE)
    #return(ids_by_month)
    everything<- raster()
    for(months in 1:12)
    {
        raster_by_month<-subset(all_days, unlist(ids_by_month[months]))
        #raster_by_month[raster_by_month==fVal_obs$value] <- NA
        names(raster_by_month)<-rep(toString(months), length(ids_by_month[[months]]))
        writeRaster(addLayer(addLayer(raster_by_month, lon), lat), paste0(output_dir,new_filename, toString(months), ".nc"), overwrite=TRUE, format="CDF",
        varname="pr", varunit="mm/day", longname="Precipitation", xname="X", yname="Y", zname="Time")
    }
}

splitMonthlySim<-function(allInputfiles, lon, lat, new_filename){
    ids_by_month<-list(1,2,3,4,5,6,7,8,9,10,11,12)
    all_days<-getPrecipAll(allInputfiles)
    for(i in 1996:2005){
        for(months in 1:12)
        {
            if(months==12)
            {
                date_string_start <- paste0(toString(i), "-",toString(months), "-01")
                date_string_end <- paste0(toString(i+1), "-01-01")
            }else{
                date_string_start <- paste0(toString(i), "-",toString(months), "-01")
                date_string_end <- paste0(toString(i), "-", toString(months+1), "-01")
            }
            ids_by_month[[months]] <- list(unlist(ids_by_month[[months]]), which((getZ(all_days) < as.Date(date_string_end))& (getZ(all_days) >= as.Date(date_string_start))))
            ids_by_month[[months]]<-unlist(ids_by_month[[months]])
        }
    }
    for(i in 1:12){ids_by_month[[i]]<-ids_by_month[[i]][-1]} # DELETE FIRST ELEMENT (just the initialization value)
    everything<- raster()
    for(months in 1:12)
    {
        raster_by_month<-subset(all_days, unlist(ids_by_month[months]))
        names(raster_by_month)<-rep(toString(months), length(ids_by_month[[months]]))
        writeRaster(addLayer(addLayer(raster_by_month, lon), lat), paste0(output_dir,new_filename, toString(months), ".nc"), overwrite=TRUE, format="CDF",
        varname="pr", varunit="mm/day", longname="Precipitation", xname="X", yname="Y")
    }
}

splitSeasons<-function(allInputfiles, lon, lat, new_filename){
  seasons<-list(spring=NULL, summer=NULL, autumn=NULL, winter=NULL)
  ids<-list(spring=list(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
            summer=list(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
            autumn=list(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
            ,winter=list(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL))
  #all_days<-getPrecipAll(allInputfiles)
  all_days<-allInputfiles
  spring_start <- "-03-20"
  spring_end<- "-06-20"
  summer_start <- "-06-20"
  summer_end <- "-09-22"
  autumn_start <- "-09-22"
  autumn_end <- "-12-22"
  winter_start <- "-12-22"
  winter_end <- "-03-20"
  for(i in 1996:2005){
    ids$spring[[i-1995]]<-which((getZ(all_days[[i-1995]]) < as.Date(paste0(i,spring_end)))& (getZ(all_days[[i-1995]]) >= as.Date(paste0(i,spring_start))))
    ids$summer[[i-1995]]<-which((getZ(all_days[[i-1995]]) < as.Date(paste0(i,summer_end)))& (getZ(all_days[[i-1995]]) >= as.Date(paste0(i,summer_start))))
    ids$autumn[[i-1995]]<-which((getZ(all_days[[i-1995]]) < as.Date(paste0(i,autumn_end)))& (getZ(all_days[[i-1995]]) >= as.Date(paste0(i,autumn_start))))
    ids$winter[[i-1995]]<-which((getZ(all_days[[i-1995]]) < as.Date(paste0(i,winter_end)))| (getZ(all_days[[i-1995]]) >= as.Date(paste0(i,winter_start))))
  }
 
  for(season in 1:4)
  {
    raster_by_season<-NULL
    raster_by_season<-raster()
    for(i in 1:10){
      print(length(ids[[season]][[i]]))
      print(nlayers(all_days[[i]]))
      raster_by_season<-addLayer(raster_by_season, subset(all_days[[i]], ids[[season]][[i]]))
      
    }
    extent(raster_by_season)<-extent(lon)
    extent(lat)<-extent(lon)
    writeRaster(addLayer(addLayer(raster_by_season, lon), lat), paste0(output_dir,new_filename, toString(names(ids[season])), ".nc"), overwrite=TRUE, format="CDF",
                varname="pr", varunit="mm/day", longname="Precipitation", xname="X", yname="Y", zname="Time")
    seasons[[season]]<-raster_by_season
  }
  return(seasons)
}