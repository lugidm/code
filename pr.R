# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19
getPR <- function(inputfile, day){

    nc_data<-nc_open(inputfile)
    lon <- ncvar_get(nc_data, "lon")
   # print(head(lon)) # look at the first few entries in the longitude vector
    lat <- ncvar_get(nc_data, "lat", verbose = F)
    t <- ncvar_get(nc_data, "time")
    pr.array <- ncvar_get(nc_data, "pr") # store the data in a 3-dimensional array
    #dim(pr.array)
    fillvalue <- ncatt_get(nc_data, "pr", "_FillValue")
    fillvalue
    nc_close(nc_data)
    pr.array[pr.array == fillvalue$value] <- NA
    pr.slice <- pr.array[, , day]
    #dim(pr.slice)
    #pr <- raster(inputfile, varname="pr")
#
#    projection(pr.array) <- mycrs
#    extent(pr.array) <- extent(plonlat)
 #


    #r <- raster(t(ndvi.slice), xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat), crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
    r <- raster(t(pr.slice),xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat), crs=CRS("+proj=longlat +datum=WGS84"))
    r <- flip(r, direction='y')
    #
    #
    #
   ' lat <- raster(inputfile, varname="lat")
    lon <- raster(inputfile, varname="lon")
    # Convert to points and match the lat and lons
    plat <- rasterToPoints(lat)
    plon <- rasterToPoints(lon)
    lonlat <- cbind(plon[,3], plat[,3])
    # Specify the lonlat as spatial points with projection as long/lat
    lonlat <- SpatialPoints(lonlat, proj4string = CRS("+proj=longlat +datum=WGS84"))

    mycrs <- CRS("+proj=lcc +lat_1=35 +lat_2=51 +lat_0=39 +lon_0=14 +k=0.684241 +units=m +datum=WGS84 +no_defs")
    plonlat <- spTransform(lonlat, CRSobj = mycrs)

    projection(r) <- mycrs
    extent(r) <- extent(plonlat)
    #
    #
    #

'

    plot(r)

    map(add=TRUE, col="black")
    return(r)
}