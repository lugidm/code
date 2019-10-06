# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 03.10.19
getPrecipAtDay <- function(inputfile, day){
    lat <- raster(inputfile, varname="lat")
    lon <- raster(inputfile, varname="lon")
    # Convert to points and match the lat and lons
    plat <- rasterToPoints(lat)
    plon <- rasterToPoints(lon)
    lonlat <- cbind(plon[,3], plat[,3])
    # Specify the lonlat as spatial points with projection as long/lat
    lonlat <- SpatialPoints(lonlat, proj4string = CRS("+proj=longlat +datum=WGS84"))

    # My best guess at the proj4 string from the information given
    mycrs <- CRS("+proj=lcc +lat_1=35 +lat_2=51 +lat_0=39 +lon_0=14 +k=0.684241 +units=m +datum=WGS84 +no_defs")
    plonlat <- spTransform(lonlat, CRSobj = mycrs)
    # Take a look
    plonlat

    extent(plonlat)

    # Yay! Now we can properly set the coordinate information for the raster
    pr <- raster(inputfile, varname="pr")
    # Fix the projection and extent
    projection(pr) <- mycrs
    extent(pr) <- extent(plonlat)
    # Take a look
    print(pr)
    pr[pr==MISSING_VALUE]<-NA
    plot(pr)
    invisible(readline(prompt="Press [enter] to continue"))
    # Project to long lat grid
    r <- projectRaster(pr, crs=CRS("+proj=longlat +datum=WGS84"))
    # Take a look
    r
    plot(r)
    # Add contours
    contour(r, add=TRUE)

    # Add country lines
    library("maps")
    map(add=TRUE, col="black")
    return(pr)
}