library(ncdf4)
library(ncdump)
library(maptools)
library(raster)
library(maps)
source("precip.R")
source("pr.R")
library(rgdal)
MISSING_VALUE=1.00000002004088e+20
input_file <- "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc"
output_dir <- "../Results/"
#pr <- getPrecipAtDay(input_file, 1)
pr <- getPR(input_file, 1)

#image(pr$x, pr$y,pr$z)
#data$dim$lon$vals -> lon
#data$dim$lat$vals -> lat
#data$dim$time$vals -> time
#data$dim$level$vals -> lev
#pr[pr=="1.00000002004088e+20"] <- NA
'data$dim$y$vals -> lat
data$dim$x$vals -> lon
pr1<-pr[,,1]
image(lon,lat,pr1)
data(wrld_simpl)
image(lon,lat,pr1)
plot(wrld_simpl,add=TRUE)'