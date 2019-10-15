# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 15.10.19
library(ncdf4)
library(ncdump)
library(maptools)
library(raster)
library(maps)
library(fields)
source("precip.R")
source("plot.R")
source("files.R")
library(rgdal)
library(zoom)
library(RColorBrewer)
library(rasterVis)
library(pbdDMAT)
#library(ggplot2)
#library(rasterVis)
input_file_sim <- "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc"
input_file_obs <- "../E-OBS/rr_ens_mean_0.1deg_reg_1995-2010_v20.0e.nc"
output_dir <- "../Results/"
input_files_eval_pr <- getEUR11evalPR()
time_list_eval <- c("1996", "2000", "2001", "2002", "2003", "2004", "2005")
input_files_hist_pr <- getEUR11histPR()
time_list_hist <- c("1986", "1987", "1988", "1989", "2000", "2001", "2002", "2003", "2004", "2005")
input_files_rcp_pr <- getEUR11rcp85PR()
time_list_rcp <- c("2090", "2091", "2092", "2093", "2094", "2095", "2096", "2097", "2098", "2099")


nc_data<-nc_open(input_files_eval_pr[[1]])
fillvalue <- ncatt_get(nc_data, "pr", "_FillValue")
nc_close(nc_data)

#pr <- getPrecipAtDay(input_file_sim, 100)
prs <- getPrecipAtDay2(input_files_eval_pr[[1]])
prs$pr <- prs$pr*3600*24
plotJPGSoph(prs, paste0(paste0("msim", time_list_eval[1]),".jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
time_list_eval[1])," in EUR-11 evaluation-data"), addMap=TRUE)
#obs <- getPrecipObs(input_file_obs)
#mean_eval<-list()
'for(i in 1:7)
{

    prs <- getPrecipAllDays(input_files_eval_pr[[i]])
    prs <- prs*3600*24 # to get mm from kg/m2*s
    mprs<-mean(prs)
    #mean_eval<-c(mean_eval, mprs)
    plotJPG(mprs, paste0(paste0("msim", time_list_eval[i]),"e.jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
    time_list_eval[i])," in EUR-11 evaluation-data"), addMap=TRUE)
}'
#mean_hist<-list()
'for(i in 6:10)
{
    prs <- getPrecipAllDays(input_files_hist_pr[[i]])
    prs <- prs*3600*24 # to get mm from kg/m2*s
    mprs<-mean(prs)
    #mean_hist<-c(mean_hist, mprs)
    plotJPG(mprs, paste0(paste0("msim",time_list_hist[i]),"h.jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
    time_list_hist[i])," in EUR-11 evaluation-data"), addMap=TRUE)
}
mean_rcp <- list()
for(i in 1:10)
{
    prs <- getPrecipAllDays(input_files_rcp_pr[[i]])
    prs <- prs*3600*24 # to get mm from kg/m2*s
    mprs<-mean(prs)
    mean_rcp <- c(mean_rcp, mprs)
    plotJPG(mprs, paste0(paste0("msim",time_list_rcp[i]),"r.jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
    time_list_rcp[i])," in EUR-11 evaluation-data"), addMap=TRUE)
}

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
'
