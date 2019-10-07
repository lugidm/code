
# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 03.10.19
getPrecipAtDay <- function(inputfile, day){
    lat <- raster(inputfile, varname="lat")
    lon <- raster(inputfile, varname="lon")

    lat <- rasterToPoints(lat)
    lon <- rasterToPoints(lon)
    hlonlat <- cbind(lon[,3], lat[,3])
    'print("mean lon = ")
    print(mean(lon[,3]))
    '
    # Specify the lonlat as spatial points with projection as long/lat
    lonlat <- SpatialPoints(hlonlat, proj4string = CRS("+proj=longlat +datum=WGS84"))

    # proj4string coordinate reference system arguments retrieved from min max of lon and lat
    crs <- CRS("+proj=lcc +lat_1=21.9873 +lat_2=72.585 +lat_0=47.286 +lon_0=10.22 +k=0.684241 +units=m +datum=WGS84 +no_defs")
    plonlat <- spTransform(lonlat, CRSobj = crs)


    #Set coords information for pr

    pr <- raster(inputfile, varname="pr", band=day)

    pr[pr==fillvalue$value]<-NA
    #plot(pr)
    #invisible(readline(prompt="Press [enter] to continue"))

    # Fix the projection and extent
    projection(pr) <- crs
    extent(pr) <- extent(plonlat)
    #plot(pr)
    #invisible(readline(prompt="Press [enter] to continue"))

    # Project to long lat grid
    r <- projectRaster(pr, crs=CRS("+proj=longlat +datum=WGS84"))

    return(r)
}
getPrecipAllDays <- function(inputfile){
    lat <- raster(inputfile, varname="lat")
    lon <- raster(inputfile, varname="lon")

    lat <- rasterToPoints(lat)
    lon <- rasterToPoints(lon)
    hlonlat <- cbind(lon[,3], lat[,3])
    'print("mean lon = ")
    print(mean(lon[,3]))
    '
    # Specify the lonlat as spatial points with projection as long/lat
    lonlat <- SpatialPoints(hlonlat, proj4string = CRS("+proj=longlat +datum=WGS84"))

    # proj4string coordinate reference system arguments retrieved from min max of lon and lat
    crs <- CRS("+proj=lcc +lat_1=21.9873 +lat_2=72.585 +lat_0=47.286 +lon_0=10.22 +k=0.684241 +units=m +datum=WGS84 +no_defs")
    plonlat <- spTransform(lonlat, CRSobj = crs)


    #Set coords information for pr

    pr <- stack(inputfile, varname="pr")
    #print(pr)
    pr[pr==fillvalue$value]<-NA
    #plot(pr)
    #invisible(readline(prompt="Press [enter] to continue"))

    # Fix the projection and extent
    projection(pr) <- crs
    extent(pr) <- extent(plonlat)
    #plot(pr)
    #invisible(readline(prompt="Press [enter] to continue"))

    # Project to long lat grid
    r <- projectRaster(pr, crs=CRS("+proj=longlat +datum=WGS84"))

    return(r)
}