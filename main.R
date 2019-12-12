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
library(diffeR)
source("~/Bacc/code/precip.R")
source("~/Bacc/code/plot.R")
source("~/Bacc/code/files.R")
source("~/Bacc/code/compare.R")
source("~/Bacc/code/OBS_functions.R")
source("~/Bacc/code/APGD_functions.R")
source("~/Bacc/code/split.R")
source("~/Bacc/code/monthly.R")

#library(ggplot2)
#library(rasterVis)


ALP3=TRUE
varname = c("longitude.coordinate", "latitude.coordinate")
input_file_obs <- "../E-OBS/rr_ens_mean_0.1deg_reg_1995-2010_v20.0e.nc"
input_file_obs_remapped <- "../E-OBS/pr_remapped_obs412424.nc"
input_file_obs_remapped_alp3 <- "../E-OBS/pr_obs_remapped_ALP3.nc"
input_files_APGD <- getAPGD()
dump_file_mprs_obs_eur11 <- "../Results/mean_obs_remapped_eur11.nc"
dump_file_mprs_hist_eur11 <- "../Results/mprs_hist_eur11.nc"
dump_file_mprs_rcp_eur11 <- "../Results/mprs_rcp85_eur11.nc"
dump_file_mprs_eval_eur11 <- "../Results/mprs_eval_eur11.nc"
dump_file_mprs_hist_alp3 <- "../Results/mprs-alp3-historical.nc"
dump_file_mprs_eval_alp3 <- "../Results/mprs-alp3-evaluation.nc"
dump_file_mprs_apgd <- "../Results/mprs-apgd.nc"


time_list_obs <- c("1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
output_dir <- "~/Bacc/Results/"
if(ALP3==TRUE)
{
    input_files_eval_pr <- getALP3regriddedevalPR()
    time_list_eval <- c("1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
    input_files_hist_pr <- getALP3regriddedhistPR()
    time_list_hist <- c("1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
    input_files_rcp_pr <- getALP3regriddedrcp85PR()
    time_list_rcp <- c("2090", "2091", "2092", "2093", "2094", "2095", "2096", "2097", "2098", "2099")
    filename_obs_monthly <- "ALP3/monthly_obs_alp-3,"
    filename_eval_monthly <- "ALP3/monthly_eval_alp-3,"
    filename_hist_monthly <- "ALP3/monthly_hist_alp-3,"
    
}else
{
    filename_obs_monthly <- "EUR11/monthly_obs_remapped_eur-11,"
    filename_eval_monthly <- "EUR11/monthly_eval_remapped_eur-11,"
    filename_hist_monthly <- "EUR11/monthly_hist_remapped_eur-11,"
    input_files_eval_pr <- getEUR11evalPR()
    time_list_eval <- c("1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
    input_files_hist_pr <- getEUR11histPR()
    time_list_hist <- c("1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
    input_files_rcp_pr <- getEUR11rcp85PR()
    time_list_rcp <- c("2090", "2091", "2092", "2093", "2094", "2095", "2096", "2097", "2098", "2099")
}

###############################
### GLOBAL VARIABLES ##########
nc_data<-nc_open(input_files_eval_pr[[2]])
if(ALP3 == TRUE)
{
    fVal_sim <- ncatt_get(nc_data, "TOT_PREC", "_FillValue")
}else{
    fVal_sim <- ncatt_get(nc_data, "pr", "_FillValue")
}
nc_close(nc_data)
nc_data<-nc_open(input_file_obs)
fVal_obs <- ncatt_get(nc_data, "rr", "_FillValue")
nc_close(nc_data)
nc_data<-nc_open(input_files_APGD[[4]])
fVal_apgd <- ncatt_get(nc_data, "PRECIPITATION", "_FillValue")
nc_close(nc_data)
################################
### HELPER FUNCTIONS ###########
Q99 <- function(x){quantile(x, probs = c(.90,.99), na.rm=TRUE)}
GREATESTDIFF <- function(x){
    if(length(which.max( abs(unlist(na.omit(x)))) == 0)){return(NA)}
    return_val=x[which.max( abs(unlist(na.omit(x))))]}
################################

########################################################################################################################
########################### NOT REMAPPED OBSERVATION MEAN CALCULATIONS #################################################
########################################################################################################################
'
obs <- getPrecipObs(input_file_obs)
mobs<-getAnnualMeanObs(obs)
for(i in 1:11)
{
    plotJPGobs(mobs[[i]], paste0(paste0("mprs", time_list_obs[i]),"obs.jpg"), paste0(paste0("Annual mean percipitation[mm/day] ",
    time_list_obs[i])," in observation data"), addMap=TRUE)
    writeRaster(mobs, paste0("../Results/mprs", time_list_obs[i], "obs.nc"), overwrite=TRUE, format="CDF",
    varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
'
########################################################################################################################
########################### NOT REMAPPED OBSERVATION Q90Q99 CALCULATIONS ###############################################
########################################################################################################################

'
obs <- getPrecipObs(input_file_obs)
qobs<-getAnnualQuantileObs(obs)
for(i in 1:11)
{
    plotJPGobsq90(qobs[[(i*2)-1]], paste0("q90", time_list_obs[i],"obs.jpg"), paste0("90. Quantile of percipitation[mm/day] in year",
    time_list_obs[i]," in observation data"), addMap=TRUE)
    plotJPGobsq99(qobs[[(i*2)]], paste0("q99", time_list_obs[i],"obs.jpg"), paste0("99. Quantile of percipitation[mm/day] in year",
    time_list_obs[i]," in observation data"), addMap=TRUE)
    writeRaster(subset(qobs, c((i*2)-1,i*2)), paste0("../Results/q90q99", time_list_obs[i], "obs.nc"), overwrite=TRUE, format="CDF",
    varname="90and99Quantile", varunit="mm", longname="90and99Quantile", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
'

########################################################################################################################
######################################## EUR -11 ++MEAN ++ CALCULATIONS #################################################
########################################################################################################################

#######################################################
#################  EVAL DATA  #########################
#######################################################
'
lon <- raster(input_files_eval_pr[[1]], varname="lon")
lat <- raster(input_files_eval_pr[[1]], varname="lat")
names(lon)<-"lon"
names(lat)<-"lat"
mprs_stack <- raster()
for(i in 1:length(time_list_eval))
{
    prs <- getPrecip(input_files_eval_pr[[i]])
    mprs <- calc(prs*3600*24, fun=mean)
    names(mprs)<-time_list_eval[i]
    print(paste("mean for", time_list_eval[i], "done"))
    plotJPGmean(raster=mprs, lon=lon, lat=lat, paste0("mprs", time_list_eval[i],"eval_eur11.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_eval[i]," in EUR-11 evaluation-data"), addMap=TRUE)
    mprs_stack<-addLayer(mprs_stack, mprs)
}
writeRaster(addLayer(addLayer(mprs_stack, lon),lat), dump_file_mprs_eval_eur11, overwrite=TRUE, format="CDF",
varname="mean_pr", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y", zunit="numeric")
'
#######################################################
#################  HIST DATA  #########################
#######################################################
'
lon <- raster(input_files_hist_pr[[1]], varname="lon")
lat <- raster(input_files_hist_pr[[1]], varname="lat")
names(lon)<-"lon"
names(lat)<-"lat"
mprs_stack <- raster()
for(i in 1:length(time_list_hist))
{
    prs <- getPrecip(input_files_hist_pr[[i]])
    mprs <- calc((prs*3600*24), fun=mean)
    names(mprs)<-time_list_hist[i]
    print(paste("mean for", time_list_hist[i], "done"))
    plotJPGmean(raster=mprs, lon=lon, lat=lat, paste0("mprs", time_list_hist[i],"hist_eur11.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_hist[i]," in EUR-11 historical-data"), addMap=TRUE)
    mprs_stack<-addLayer(mprs_stack, mprs)

}
writeRaster(addLayer(addLayer(mprs_stack, lon),lat), dump_file_mprs_hist_eur11, overwrite=TRUE, format="CDF",
varname="mean_pr", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y", zunit="numeric")
'
#######################################################
#################  RCP85 DATA  ########################
#######################################################
'
lon <- raster(input_files_rcp_pr[[1]], varname="lon")
lat <- raster(input_files_rcp_pr[[1]], varname="lat")
names(lon)<-"lon"
names(lat)<-"lat"
mprs_stack <- raster()
for(i in 1:length(time_list_rcp))
{
    prs <- getPrecip(input_files_rcp_pr[[i]])
    mprs <- calc((prs*3600*24), fun=mean)
    names(mprs)<-time_list_rcp[i]
    print(paste("mean for", time_list_rcp[i], "done"))
    plotJPGmean(raster=mprs, lon=lon, lat=lat, paste0("mprs", time_list_rcp[i],"rcp85_eur11.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_rcp[i]," in EUR-11 rcp85-data"), addMap=TRUE)
    mprs_stack<-addLayer(mprs_stack, mprs)
}
writeRaster(addLayer(addLayer(mprs_stack, lon),lat), dump_file_mprs_rcp_eur11, overwrite=TRUE, format="CDF",
varname="mean_pr", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y", zunit="numeric")
'
########################################################################################################################
######################################## EUR -11 ++ Q90Q99 ++ CALCULATIONS #############################################
########################################################################################################################
#################  EVAL DATA  #########################
#######################################################
'
for(i in 1:length(time_list_eval))
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
    varname="Q90Q99", varunit="mm", longname="90 and 99 Quantile Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
'
#######################################################
#################  HIST DATA  #########################
#######################################################
'
for(i in 1:length(time_list_hist))
{
    prs <- getPrecip(input_files_hist_pr[[i]])
    print("Q99")
    qprs <- calc((prs*3600*24), fun=Q99)
    lon <- raster(input_files_hist_pr[[i]], varname="lon")
    lat <- raster(input_files_hist_pr[[i]], varname="lat")
    print(paste("lon lat and q99 for", time_list_hist[i], "done"))
    qprs<-addLayer(qprs, lon)
    qprs<-addLayer(qprs, lat)
    plotJPGq90(subset(qprs, c(1,3,4)), paste0("q90sim", time_list_hist[i],"hist.jpg"), paste0("90. Quantile of percipitation[mm/day] in year ",
    time_list_hist[i]," in EUR-11 historical-data"), addMap=TRUE)
    plotJPGq99(subset(qprs, c(2,3,4)), paste0("q99sim", time_list_hist[i],"hist.jpg"), paste0("99. Quantile of percipitation[mm/day] in year ",
    time_list_hist[i]," in EUR-11 historical-data"), addMap=TRUE)
    writeRaster(qprs, paste0("../Results/q90q99prs", time_list_hist[i], "hist.nc"), overwrite=TRUE, format="CDF",
    varname="Q90Q99", varunit="mm", longname="90 and 99 Quantile Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
}
'

########################################################################################################################
################################ EUR-11 REMAPPED OBSERVATION CALCULATIONS ##############################################
########################################################################################################################
################## Q90Q99 ##########################
####################################################
'
observation <- getRemappedObs(input_file_obs_remapped)
quantile_observations<-getRemappedAnnualQuantileObs(observation)
lon <- raster(input_file_obs_remapped, varname="lon")
lat <- raster(input_file_obs_remapped, varname="lat")
writeRaster(addLayer(addLayer(quantile_observations, lon), lat), "../Results/q90q99_obs_remapped.nc", overwrite=TRUE, format="CDF",
varname="90and99Quantile", varunit="mm", longname="90and99Quantile", xname="X", yname="Y",zname="nbands", zunit="numeric")
for(i in 1:11)
{
    print("Q99")
    print(paste("lon lat and q99 for", time_list_obs[i], "done"))
    plotJPGq90(raster=quantile_observations[[(i*2)-1]], lon=lon, lat=lat, paste0("q90", time_list_obs[i],"obs_remapped.jpg"), paste0("90. Quantile of percipitation[mm/day] in year ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
    plotJPGq99(raster=quantile_observations[[(i*2)]], lon=lon, lat=lat, paste0("q99", time_list_obs[i],"obs_remapped.jpg"), paste0("99. Quantile of percipitation[mm/day] in year ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
}
'
####################################################
##############  MEAN   #############################
####################################################
'
observation <- getRemappedObs(input_file_obs_remapped)
mean_observations<-getAnnualMeanObs(observation)
lon <- raster(input_file_obs_remapped, varname="lon")
lat <- raster(input_file_obs_remapped, varname="lat")
names(lon)<-"lon"
names(lat)<-"lat"
writeRaster(addLayer(addLayer(mean_observations, lon), lat), dump_file_mprs_obs_eur11, overwrite=TRUE, format="CDF",
varname="mean_pr", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
for(i in 1:11)
{
    plotJPGmean(raster=mean_observations[[i]], lon=lon, lat=lat, paste0("mprs", time_list_obs[i],"obs_remapped.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
}
'


#####################################################
################## EVAL DATA ########################
#################### MEAN ###########################
#####################################################
'
lon <- raster(input_files_eval_pr[[1]], varname="lon")
lat <- raster(input_files_eval_pr[[1]], varname="lat")
for(i in 1:length(time_list_eval))
{
    prs <- getPrecip(input_files_eval_pr[[i]])
    mprs <- stackApply(prs, indices=c(1), fun=mean)
    print(paste("mean for", time_list_eval[i], "done"))
    plotJPGmean(raster=mprs, lon=lon, lat=lat, paste0("mprs", time_list_eval[i],"eval_alp3.jpg"), paste0("Annual mean percipitation[mm/day] ",
    time_list_eval[i]," in ALP-3 evaluation-data"), addMap=TRUE)
    if(i>1){
        old_raster <- raster("../Results/mprs_eval_alp3.nc")
        writeRaster(addLayer(old_raster, mprs), "../Results/mprs_eval_alp3.nc", overwrite=TRUE, format="CDF",
        varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
    }else{
    writeRaster(mprs, "../Results/mprs_eval_alp3.nc", overwrite=TRUE, format="CDF", varname="MPercipitation",
    varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
    }
}
old_raster <- raster("../Results/mprs_eval_alp3.nc")
writeRaster(addLayer(addLayer(old_raster, lon),lat), "../Results/mprs_eval_alp3.nc", overwrite=TRUE, format="CDF",
varname="MPercipitation", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
'
########################################################################################################################
#############################################   COMPARISIONS EUR 11 ####################################################
########################################################################################################################
'
mean_pr_eval <- stack(dump_file_mprs_eval_eur11, varname = "mean_pr")
mean_pr_obs <- stack(dump_file_mprs_obs_eur11, varname = "mean_pr")
lon=subset(mean_pr_obs, nlayers(mean_pr_obs)-1)
lat=subset(mean_pr_obs, nlayers(mean_pr_obs))
return_val <-compareSUB(mean_pr_eval, mean_pr_obs, lon= lon, lat= lat, EVAL=TRUE)
dif_eval <- return_val[[1]]
names(dif_eval)<-time_list_eval
freq_eval <- return_val[[2]]

mean_pr_hist <- stack(dump_file_mprs_hist_eur11, varname = "mean_pr")
mean_pr_obs <- stack(dump_file_mprs_obs_eur11, varname = "mean_pr")
return_val<-compareSUB(mean_pr_hist, mean_pr_obs, lon=lon, lat=lat, EVAL=FALSE)
dif_hist <- return_val[[1]]
names(dif_hist)<-time_list_hist
freq_hist <- return_val[[2]]
mean_eval<-compareAllYears(differences=dif_eval, frequencies=freq_eval, lon=lon, lat=lat, EVAL=TRUE)
mean_hist<-compareAllYears(differences=dif_hist, frequencies=freq_hist, lon=lon, lat=lat, EVAL=FALSE)
'

########################################################################################################################
##################### ALP-3 ****************************************** CALCULATIONS ####################################
########################################################################################################################

#---------------- RCP85 #############################
#rcp85<-getAnnualMean(inputfiles=input_files_rcp_pr, data_type="rcp85", time_list = time_list_rcp)




####################################################
###### REMAPPED APGD OBSERVATION DATA FOR ALP-3 ####
################## MEAN ##########################
####################################################
'
apgd_all_days<-stackAPGD(input_files_APGD)
apgd_lon <- raster(input_files_APGD[[1]], varname="lon")
apgd_lat <- raster(input_files_APGD[[1]], varname="lat")
apgd_mean<-getMeanAPGD(apgd_all_days, lon=apgd_lon, lat=apgd_lat)
alp3_eval_mean <- getAnnualMean(inputfiles=input_files_eval_pr,data_type="evaluation", time_list = time_list_eval)
alp3_hist_mean <- getAnnualMean(inputfiles=input_files_hist_pr, data_type="historical", time_list=time_list_eval)
crs(alp3_eval_mean)<-crs(apgd_mean)
############## UIUIUIUIUIUIUI #######
cells<-cellFromXY(alp3_eval_mean, cropMatrix(xmin=220, xmax=243, ymin=0,ymax=20))
alp3_eval_mean[cells]<-NA
###############
return_list<-compareSUB(simulated=alp3_eval_mean, apgd_mean, lon= apgd_lon, lat = apgd_lat, EVAL = TRUE)
dif_eval_raster<-return_list[[1]]
dif_eval_freq<-return_list[[2]]
return_list<-compareSUB(simulated=alp3_hist_mean, apgd_mean, lon= apgd_lon, lat = apgd_lat, EVAL = FALSE)
dif_hist_raster<-return_list[[1]]
dif_hist_freq<-return_list[[2]]

mean_mean_eval<-compareAllYears(differences=dif_eval_raster, frequencies=dif_eval_freq, lon=apgd_lon, lat=apgd_lat, EVAL=TRUE)
mean_mean_hist<-compareAllYears(differences=dif_hist_raster, frequencies=dif_hist_freq, lon=apgd_lon, lat=apgd_lat, EVAL=FALSE)

'

'observation <- getRemappedObs(input_file_obs_remapped)
quantile_observations<-getRemappedAnnualQuantileObs(observation)
lon <- raster(input_file_obs_remapped, varname="lon")
lat <- raster(input_file_obs_remapped, varname="lat")
writeRaster(addLayer(addLayer(quantile_observations, lon), lat), "../Results/q90q99_obs_remapped.nc", overwrite=TRUE, format="CDF",
varname="90and99Quantile", varunit="mm", longname="90and99Quantile", xname="X", yname="Y",zname="nbands", zunit="numeric")
for(i in 1:11)
{
    print("Q99")
    print(paste("lon lat and q99 for", time_list_obs[i], "done"))
    plotJPGq90(raster=quantile_observations[[(i*2)-1]], lon=lon, lat=lat, paste0("q90", time_list_obs[i],"obs_remapped.jpg"), paste0("90. Quantile of percipitation[mm/day] in year ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
    plotJPGq99(raster=quantile_observations[[(i*2)]], lon=lon, lat=lat, paste0("q99", time_list_obs[i],"obs_remapped.jpg"), paste0("99. Quantile of percipitation[mm/day] in year ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
}
'
####################################################
###### REMAPPED OBSERVATION DATA ALP3 ##############
##############  MEAN   #############################
####################################################
'
observation_alp3 <- getRemappedObs(input_file_obs_remapped_alp3)
mean_observations_alp3<-getAnnualMeanObs(observation_alp3)
lon <- raster(input_file_obs_remapped_alp3, varname="lon")
lat <- raster(input_file_obs_remapped_alp3, varname="lat")
writeRaster(addLayer(addLayer(mean_observations_alp3, lon), lat), "../Results/mean_obs_remapped_alp3.nc", overwrite=TRUE, format="CDF",
varname="mean_pr", varunit="mm", longname="Mean Percipitation", xname="X", yname="Y",zname="nbands", zunit="numeric")
for(i in 1:11)
{
    plotJPGmean(raster=mean_observations_alp3[[i]], lon=lon, lat=lat, paste0("mprs", time_list_obs[i],"obs_remapped_alp3.jpg"),
    paste0("Annual mean percipitation[mm/day] ", time_list_obs[i]," in remapped observation data for ALP-3"), addMap=TRUE)
}
'

######################################################################
#-----  --------------split all files and place them into .nc dumpfiles -----------------------###########
######################################################################
#ids_by_month<-splitMonthlyOBS(all_days=stack(input_file_obs_remapped, varname="rr"), lon=stack(input_files_eval_pr[[1]], varname="lon"),
#                lat=raster(input_files_eval_pr[[1]], varname="lat"), new_filename=filename_obs_monthly)

#ids_by_month<-splitMonthlySim(allInputfiles=input_files_eval_pr, lon=stack(input_files_eval_pr[[1]], varname="lon"),
#lat=raster(input_files_eval_pr[[1]], varname="lat"), new_filename=filename_eval_monthly)
#ids_by_month<-splitMonthlySim(allInputfiles=input_files_hist_pr, lon=raster(input_files_hist_pr[[1]], varname="lon"),
#                              lat=raster(input_files_hist_pr[[1]], varname="lat"), new_filename=filename_hist_monthly)
#ids_by_month<-splitMonthlyOBS(all_days = stackAPGD(inputfiles = input_files_APGD), lon = raster(input_files_APGD[[1]], varname="lon"),
#                              lat=raster(input_files_APGD[[1]], varname="lat"), new_filename = filename_obs_monthly)


#########################################################################################################
#########################################################################################################
############### --------------------- compare differences monthly ---------------- ######################
#########################################################################################################
#########################################################################################################

#differences_eval<-compareMonthly(monthly_filename=filename_eval_monthly) # Get q90 and q99 differences
#differences_hist<-compareMonthly(monthly_filename=filename_hist_monthly)
cells<-cellFromXY(differences_eval[[1]][[1]], cropMatrix(xmin=220, xmax=243, ymin=0,ymax=20))
cropped_hist<-differences_hist
cropped_eval<-differences_eval
for(months in 1:12){
    cropped_hist[[months]][[1]][cells]<-NA
    cropped_eval[[months]][[1]][cells]<-NA
    cropped_hist[[months]][[2]][cells]<-NA
    cropped_eval[[months]][[2]][cells]<-NA
}
dyed_eval<-dyeMaxMinDifferences(differences=cropped_eval, num_maximas=20)
dyed_hist<-dyeMaxMinDifferences(differences=cropped_hist, num_maximas=20) #Get a raster with num_maximas maximal differences


#hist<-getMonthlyList(filename_hist_monthly, 1, 1)

#obs<-getMonthlyList(filename_obs_monthly, 1, 1)

#eval<-getMonthlyList(filename_eval_monthly, 1, 1)
###

#pr <- getPR(input_file, 1)
#levelplot(pr)
#zoom(pr, ext=drawExtent(), maxpixels=100000)


#plot(obs, xlab="lon", ylab="lat")
#map(add=TRUE, col="red")

#zm()

#contour(pr, add=FALSE, nlevels=10)
#map(add=TRUE, col="red")
#zm()
