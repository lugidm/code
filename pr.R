# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19
getPR <- function(inputfile, day){

    nc_data<-nc_open(inputfile)
    lon <- ncvar_get(nc_data, "lon")
    print(head(lon)) # look at the first few entries in the longitude vector
    lat <- ncvar_get(nc_data, "lat", verbose = F)
    t <- ncvar_get(nc_data, "time")
    ndvi.array <- ncvar_get(nc_data, "pr") # store the data in a 3-dimensional array
    dim(ndvi.array)
    fillvalue <- ncatt_get(nc_data, "pr", "_FillValue")
    fillvalue
    nc_close(nc_data)
    ndvi.array[ndvi.array == fillvalue$value] <- NA
    ndvi.slice <- ndvi.array[, , day]
    dim(ndvi.slice)
    r <- raster(t(ndvi.slice), xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat), crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
    #r <- flip(r, direction='y')
    plot(r)

    map(add=TRUE, col="black")
    return(r)
}