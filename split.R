# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 11/13/19
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