library(ncdf4)
library(ncdump)
library(maptools)
library(raster)
library(maps)
source("precip.R")
source("plot.R")
library(rgdal)
library(zoom)
#library(ggplot2)
#library(rasterVis)
input_file_sim <- "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc"
input_file_obs <- "../E-OBS/rr_ens_mean_0.1deg_reg_1995-2010_v20.0e.nc"
output_dir <- "../Results/"

nc_data<-nc_open(input_file_sim)
fillvalue <- ncatt_get(nc_data, "pr", "_FillValue")
nc_close(nc_data)

#pr <- getPrecipAtDay(input_file_sim, 100)
prs <- getPrecipAllDays(input_file_sim)
#obs <- getPrecipObs(input_file_obs)
mprs<-mean(prs)
plotJPG(mprs, "msim96.jpg", "eval annual mean percipitation 1996")
#pr <- getPR(input_file, 1)
#levelplot(pr)
#zoom(pr, ext=drawExtent(), maxpixels=100000)


#plot(obs, xlab="lon", ylab="lat")
#map(add=TRUE, col="red")

#zm()

#contour(pr, add=FALSE, nlevels=10)
#map(add=TRUE, col="red")
#zm()
