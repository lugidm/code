
# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 03.10.19


getPrecipObs <- function(inputfile, layers){


    pr <- brick(inputfile, varname="rr")
    #print(pr)
    nc_data<-nc_open(inputfile)
    fillvalue <- ncatt_get(nc_data, "rr", "_FillValue")
    nc_close(nc_data)
    #pr[pr==fillvalue$value]<-NA

    return(pr)
}

getPrecipAtDay2 <- function(inputfile){
    pr<-list()
    pr$lon <- raster(inputfile, varname="lon")
    pr$lat <- raster(inputfile, varname="lat")
    pr$pr <- raster(inputfile, varname="pr")

    pr$pr[pr$pr==fillvalue$value]<-NA
    print("aHA")
    return(pr)
}