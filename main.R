library(ncdf4)
library(maptools)
library(raster)
library(maps)
library(fields)
library(rgdal)
library(zoom)
library(RColorBrewer)
library(rasterVis)
library(pbdDMAT)
library(lfstat)
source("precip.R")
source("plot.R")
source("files.R")
#library(ggplot2)
#library(rasterVis)
input_file_obs <- "../E-OBS/rr_ens_mean_0.1deg_reg_1995-2010_v20.0e.nc"
time_list_obs <- c("1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
output_dir <- "../Results/"
input_files_eval_pr <- getEUR11evalPR()
time_list_eval <- c("1996","1997","1998","1999", "2000", "2001", "2002", "2003", "2004", "2005")
input_files_hist_pr <- getEUR11histPR()
time_list_hist <- c("1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
input_files_rcp_pr <- getEUR11rcp85PR()
time_list_rcp <- c("2090", "2091", "2092", "2093", "2094", "2095", "2096", "2097", "2098", "2099")

### GLOBAL VARIABLES
nc_data<-nc_open(input_files_eval_pr[[1]])
fVal_sim <- ncatt_get(nc_data, "pr", "_FillValue")
nc_close(nc_data)
nc_data<-nc_open(input_file_obs)
fVal_obs <- ncatt_get(nc_data, "rr", "_FillValue")
nc_close(nc_data)
###

### HELPER FUNCTIONS
Q99 <- function(x){quantile(x,probs = c(.90,.99), na.rm=TRUE)}

###


#pr <- getPrecipAtDay(input_file_sim, 100)


###OBSERVATION

'obs <- getPrecipObs(input_file_obs)
mobs<-getAnnualMeanObs(obs)
for(i in 1:11)
{
    plotJPGobs(mobs[[i]], paste0(paste0("mprs", time_list_obs[i]),"obs.jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
    time_list_obs[i])," in observation data"), addMap=TRUE)
    writeRaster(mobs, paste0("../Results/mprs", time_list_obs[i], "obs.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
'
'
###EVAL DATA
for(i in 1:10)
{
    prs <- getPrecip(input_files_eval_pr[[i]])
    mprs <- calc((prs*3600*24), fun=mean)
    lon <- raster(input_files_eval_pr[[i]], varname="lon")
    lat <- raster(input_files_eval_pr[[i]], varname="lat")
    print(paste("lon lat and mean for", time_list_eval[i], "done"))
    mprs<-addLayer(mprs, lon)
    mprs<-addLayer(mprs, lat)
    plotJPGmean(mprs, paste0("msim", time_list_eval[i],"eval.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_eval[i]," in EUR-11 evaluation-data"), addMap=TRUE)
    writeRaster(mprs, paste0("../Results/mprs", time_list_eval[i], "eval.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}

for(i in 1:11)
{
    prs <- getPrecip(input_files_hist_pr[[i]])
    mprs <- calc((prs*3600*24), fun=mean)
    lon <- raster(input_files_hist_pr[[i]], varname="lon")
    lat <- raster(input_files_hist_pr[[i]], varname="lat")
    mprs<-addLayer(mprs, lon)
    mprs<-addLayer(mprs, lat)
    plotJPGmean(mprs, paste0("msim", time_list_hist[i],"hist.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_hist[i]," in EUR-11 historical-data"), addMap=TRUE)
    writeRaster(mprs, paste0("../Results/mprs", time_list_hist[i], "hist.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}


#mean_rcp <- list()
for(i in 1:10)
{
    prs <- getPrecip(input_files_rcp_pr[[i]])
    mprs <- calc((prs*3600*24), fun=mean)
    lon <- raster(input_files_rcp_pr[[i]], varname="lon")
    lat <- raster(input_files_rcp_pr[[i]], varname="lat")
    mprs<-addLayer(mprs, lon)
    mprs<-addLayer(mprs, lat)
    plotJPGmean(mprs, paste0(paste0("msim", time_list_rcp[i]),"rcp85.jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
    time_list_rcp[i])," in EUR-11 rcp85-data"), addMap=TRUE)
    writeRaster(mprs, paste0("../Results/mprs", time_list_rcp[i], "rcp85.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
'

### Q99 calculations in OBSERVATION DATA
obs <- getPrecipObs(input_file_obs)
qobs<-getAnnualQuantileObs(obs)
for(i in 1:11)
{
    plotJPGobs(qobs[[(i*2)-1]], paste0("q90", time_list_obs[i],"obs.jpg"), paste0("90. Quantile of percipitation[mm/day] in year",
    time_list_obs[i]," in observation data"), addMap=TRUE)
    plotJPGobs(qobs[[(i*2)]], paste0("q99", time_list_obs[i],"obs.jpg"), paste0("99. Quantile of percipitation[mm/day] in year",
    time_list_obs[i]," in observation data"), addMap=TRUE)
    writeRaster(subset(qobs, c((i*2)-1,i*2)), paste0("../Results/q90q99", time_list_obs[i], "obs.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
###
### Q99 calculations EVAL
'for(i in 1:10)
{
    prs <- getPrecip(input_files_eval_pr[[i]])
    print("Q99")
    qprs <- calc((prs*3600*24), fun=Q99)
    lon <- raster(input_files_eval_pr[[i]], varname="lon")
    lat <- raster(input_files_eval_pr[[i]], varname="lat")
    print(paste("lon lat and q99 for", time_list_eval[i], "done"))
    qprs<-addLayer(qprs, lon)
    qprs<-addLayer(qprs, lat)
    plotJPGq90(subset(qprs, c(1,3,4)), paste0("q90sim", time_list_eval[i],"eval.jpg"), paste0("90. Quantile of percipitation[mm/day] in year ",
    time_list_eval[i]," in EUR-11 evaluation-data"), addMap=TRUE)
    plotJPGq99(subset(qprs, c(2,3,4)), paste0("q99sim", time_list_eval[i],"eval.jpg"), paste0("99. Quantile of percipitation[mm/day] in year ",
    time_list_eval[i]," in EUR-11 evaluation-data"), addMap=TRUE)
    writeRaster(qprs, paste0("../Results/q90q99prs", time_list_eval[i], "eval.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}'
###

#mprs<-mean(prs)
#mprs<-mprs*3600*24 # to get mm

#plotJPG(mprs, "msim96.jpg", "Annual mean percipitation[mm/day] 1996 in EUR-11 evaluation-data", addMap=TRUE)

#pr <- getPR(input_file, 1)
#levelplot(pr)
#zoom(pr, ext=drawExtent(), maxpixels=100000)


#plot(obs, xlab="lon", ylab="lat")
#map(add=TRUE, col="red")

#zm()

#contour(pr, add=FALSE, nlevels=10)
#map(add=TRUE, col="red")
#zm()
