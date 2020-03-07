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
library(SimDesign)
source("~/Bacc/code/precip.R")
source("~/Bacc/code/plot.R")
source("~/Bacc/code/files.R")
source("~/Bacc/code/compare.R")
source("~/Bacc/code/OBS_functions.R")
source("~/Bacc/code/APGD_functions.R")
source("~/Bacc/code/split.R")
source("~/Bacc/code/monthly.R")
source("~/Bacc/code/mean.R")

#library(ggplot2)
#library(rasterVis)


###############################
### GLOBAL VARIABLES ##########
ALP3=FALSE
input_files_APGD <- getAPGD()
'dump_file_mprs_obs_eur11 <- "../Results/mean_obs_remapped_eur11.nc"
dump_file_mprs_hist_eur11 <- "../Results/mprs_hist_eur11.nc"
dump_file_mprs_eval_eur11_apgd <- "../Results/mprs_eval_eur11.nc"'

dump_file_mprs_hist_eur11 <- "../Results/mprs_hist_remapped_eur11.nc"
dump_file_mprs_eval_eur11 <- "../Results/mprs_eval_remapped_eur11.nc"
dump_file_mprs_hist_alp3 <- "../Results/mprs-alp3-historical.nc"
dump_file_mprs_eval_alp3 <- "../Results/mprs-alp3-evaluation.nc"
dump_file_mprs_apgd <- "../Results/mprs-apgd.nc"

time_list_obs <- c("1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
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
    input_files_eval_pr <- getEUR11regridded_eval_pr()
    time_list_eval <- c("1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
    input_files_hist_pr <- getEUR11regridded_historical_pr()
    time_list_hist <- c("1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005")
    input_files_rcp_pr <- getEUR11regridded_rcp85_pr()
    time_list_rcp <- c("2090", "2091", "2092", "2093", "2094", "2095", "2096", "2097", "2098", "2099")
}

nc_data<-nc_open(input_files_eval_pr[[2]])
if(ALP3 == TRUE)
{
    fVal_sim <- ncatt_get(nc_data, "TOT_PREC", "_FillValue")
}else{
    fVal_sim <- ncatt_get(nc_data, "pr", "_FillValue")
}
nc_close(nc_data)
'nc_data<-nc_open(input_file_obs)
fVal_obs <- ncatt_get(nc_data, "rr", "_FillValue")
nc_close(nc_data)
'
nc_data<-nc_open(input_files_APGD[[4]])
fVal_apgd <- ncatt_get(nc_data, "PRECIPITATION", "_FillValue")
nc_close(nc_data)

################################
### HELPER FUNCTIONS ###########
Q99 <- function(x){quantile(x, probs =c(0.99), na.rm=TRUE)}
GREATESTDIFF <- function(x){
    if(length(which.max( abs(unlist(na.omit(x)))) == 0)){return(NA)}
    return_val=x[which.max( abs(unlist(na.omit(x))))]}

######################################## SPLIT MONTHLY ##########################
'
ids_by_month<-splitMonthlyOBS(all_days=stack(input_file_obs_remapped, varname="rr"), lon=stack(input_files_eval_pr[[1]], varname="lon"),
                lat=raster(input_files_eval_pr[[1]], varname="lat"), new_filename=filename_obs_monthly)

ids_by_month<-splitMonthlySim(allInputfiles=input_files_eval_pr, lon=stack(input_files_eval_pr[[1]], varname="lon"),
  lat=raster(input_files_eval_pr[[1]], varname="lat"), new_filename=filename_eval_monthly)
ids_by_month<-splitMonthlySim(allInputfiles=input_files_hist_pr, lon=raster(input_files_hist_pr[[1]], varname="lon"),
                              lat=raster(input_files_hist_pr[[1]], varname="lat"), new_filename=filename_hist_monthly)
splitSeasons(allInputfiles = getPrecipAll(input_files_eval_pr), lon=stack(input_files_eval_pr[[1]], varname="lon"),
             lat=raster(input_files_eval_pr[[1]], varname="lat"), new_filename=filename_eval_monthly)
splitSeasons(allInputfiles = getPrecipAll(input_files_hist_pr), lon=stack(input_files_hist_pr[[1]], varname="lon"),
             lat=raster(input_files_hist_pr[[1]], varname="lat"), new_filename=filename_hist_monthly)
splitSeasons(allInputfiles = stackAPGD(input_files_APGD), lon =stack(input_files_APGD[[1]], varname="lon"),
             lat=stack(input_files_APGD[[1]], varname="lat"), new_filename = "EUR11/monthly_obs_remapped_eur-11,")
ids_by_month<-splitMonthlyOBS(all_days = stackAPGD(inputfiles = input_files_APGD), lon = raster(input_files_APGD[[1]], varname="lon"),
    lat=raster(input_files_APGD[[1]], varname="lat"), new_filename = filename_obs_monthly)
'
################################


########################################################################################################################
######################################## EUR -11 ++MEAN ++ CALCULATIONS #################################################
########################################################################################################################

#######################################################
#################  EVAL DATA  #########################
#######################################################
'
lon <- raster(input_files_eval_pr[[1]], varname="lon")
lat <- raster(input_files_eval_pr[[1]], varname="lat")
mprs_stack <- raster()
for(i in 1:length(time_list_eval))
{
    prs <- getPrecip(input_files_eval_pr[[i]])
    mprs <- calc(prs*3600*24, fun=mean)
    names(mprs)<-time_list_eval[i]
    print(paste("mean for", time_list_eval[i], "done"))
    plotJPGmean(raster=mprs, lon=lon, lat=lat, paste0("mprs", time_list_eval[i],"eval_eur11.jpg"), paste0("Annual mean percipitation",
    time_list_eval[i]," in EUR-11 evaluation-data [mm/day]"), addMap=TRUE)
    mprs_stack<-addLayer(mprs_stack, mprs)
}
writeRaster(addLayer(addLayer(mprs_stack, lon),lat), dump_file_mprs_eval_eur11, overwrite=TRUE, format="CDF",
varname="mean_pr", varunit="mm/day", longname="Mean Percipitation", xname="X", yname="Y", zunit="numeric")
'
#######################################################
#################  HIST DATA  #########################
#######################################################
'
lon <- raster(input_files_hist_pr[[1]], varname="lon")
lat <- raster(input_files_hist_pr[[1]], varname="lat")
mprs_stack <- raster()
for(i in 1:length(time_list_hist))
{
    prs <- getPrecip(input_files_hist_pr[[i]])
    mprs <- calc((prs*3600*24), fun=mean)
    names(mprs)<-time_list_hist[i]
    print(paste("mean for", time_list_hist[i], "done"))
    plotJPGmean(raster=mprs, lon=lon, lat=lat, paste0("mprs", time_list_hist[i],"hist_eur11.jpg"), paste0("Annual mean percipitation ",
    time_list_hist[i]," in EUR-11 historical-data [mm/day]"), addMap=TRUE)
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

'ALP3=FALSE
mean_pr_eval <- stack(dump_file_mprs_eval_eur11, varname = "mean_pr")
mean_pr_obs <- stack(dump_file_mprs_apgd, varname = "mprs")
lon=subset(mean_pr_obs, nlayers(mean_pr_obs)-1)
lat=subset(mean_pr_obs, nlayers(mean_pr_obs))
return_val <-compareSUB(mean_pr_eval, mean_pr_obs, lon= lon, lat= lat, EVAL=TRUE)
dif_eval <- return_val[[1]]
freq_eval <- return_val[[2]]
biases_eur11_eval<- plotBoxplot(dif_eval, "eur_11_evaluation_boxplot_", main_pattern="evaluation", overall_mean=FALSE)



mean_pr_hist <- stack(dump_file_mprs_hist_eur11, varname = "mean_pr")
mean_pr_obs <- stack(dump_file_mprs_apgd, varname = "mprs")
return_val<-compareSUB(mean_pr_hist, mean_pr_obs, lon=lon, lat=lat, EVAL=FALSE)
dif_hist <- return_val[[1]]
freq_hist <- return_val[[2]]
biases_eur11_hist <- plotBoxplot(dif_hist, "eur_11_historical_boxplot_", main_pattern="historical", overall_mean=FALSE)
mean_eval<-compareAllYears(differences=dif_eval, frequencies=freq_eval, lon=lon, lat=lat, EVAL=TRUE)
mean_hist<-compareAllYears(differences=dif_hist, frequencies=freq_hist, lon=lon, lat=lat, EVAL=FALSE)
plotBoxplot(mean_eval[[1]], "eur_11_mean_evaluation_boxplot", "evaluation", overall_mean=TRUE)
plotBoxplot(mean_hist[[1]], "eur_11_mean_historical_boxplot", "historical", overall_mean=TRUE)
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
'
ALP3=TRUE
mean_pr_eval_alp3 <- stack(dump_file_mprs_eval_alp3, varname = "mprs")
mean_pr_obs <- stack(dump_file_mprs_apgd, varname = "mprs")
lon=subset(mean_pr_obs, nlayers(mean_pr_obs)-1)
lat=subset(mean_pr_obs, nlayers(mean_pr_obs))
return_val <-compareSUB(mean_pr_eval_alp3, mean_pr_obs, lon= lon, lat= lat, EVAL=TRUE)
dif_eval_alp3 <- return_val[[1]]
freq_eval_alp3 <- return_val[[2]]
biases_alp3_eval<-plotBoxplot(dif_eval_alp3, "alp3_evaluation_boxplot_", main_pattern="evaluation", overall_mean=FALSE)



mean_pr_hist_alp3 <- stack(dump_file_mprs_hist_alp3, varname = "mprs")
mean_pr_obs <- stack(dump_file_mprs_apgd, varname = "mprs")
return_val<-compareSUB(mean_pr_hist_alp3, mean_pr_obs, lon=lon, lat=lat, EVAL=FALSE)
dif_hist_alp3 <- return_val[[1]]
freq_hist_alp3 <- return_val[[2]]
biases_alp3_hist<-plotBoxplot(dif_hist_alp3, "alp3_historical_boxplot_", main_pattern="historical", overall_mean=FALSE)
mean_eval_alp3<-compareAllYears(differences=dif_eval_alp3, frequencies=freq_eval, lon=lon, lat=lat, EVAL=TRUE)
mean_hist_alp3<-compareAllYears(differences=dif_hist_alp3, frequencies=freq_hist_alp3, lon=lon, lat=lat, EVAL=FALSE)
plotBoxplot(mean_eval_alp3[[1]], "alp3_mean_evaluation_boxplot", "evaluation", overall_mean=TRUE)
plotBoxplot(mean_hist_alp3[[1]], "alp3_mean_historical_boxplot", "historical", overall_mean=TRUE)

'

########################################################################################################
#############################    2002 2002 2002 2002 2002 2002 2002 2002 ###############################
########################################################################################################
'
eval_eur11_2002<-stack(getEUR11regridded_eval_pr()[[7]], varname="pr")
hist_eur11_2002<-stack(getEUR11regridded_historical_pr()[[7]], varname="pr")
eval_alp3_2002<-stack(getALP3regriddedevalPR()[[7]], varname="TOT_PREC")
hist_alp3_2002<-stack(getALP3regriddedhistPR()[[7]], varname="TOT_PREC")
apgd_2002<-getAPGDinYear(stackAPGD(input_files_APGD), 2002)
extent(apgd_2002)<-extent(eval_eur11_2002)
cropped_eval_eur11_2002<-cropMean2002(eval_eur11_2002)
cropped_eval_eur11_2002<-cropped_eval_eur11_2002*3600*24
cropped_hist_eur11_2002<-cropMean2002(hist_eur11_2002)
cropped_hist_eur11_2002<-cropped_hist_eur11_2002*3600*24
cropped_eval_alp3_2002<-cropMean2002(eval_alp3_2002) 
cropped_hist_alp3_2002<-cropMean2002(hist_alp3_2002) 
cropped_apgd_2002<-cropMean2002(apgd_2002)

dif_2002<-subArrayMean(hist_eur11 = cropped_hist_eur11_2002, eval_eur11 = cropped_eval_eur11_2002,
                            hist_alp3 = cropped_hist_alp3_2002, eval_alp3 = cropped_eval_alp3_2002, cropped_apgd_2002)

plotDif2002(dif_2002, fn="differences_2002") 

hist<-putInData(simulated_1 = cropped_his_alp3_2002, simulated_2 = cropped_hist_eur11_2002, observated = cropped_apgd_2002, "2002-01-01", "2002-12-31")

plotDif2002(data = hist, fn="historical_2002")
########################BIASES#################
plotBiases(biases_alp3_eval, biases_alp3_hist, biases_eur11_eval, biases_eur11_hist, fn="yearly_mean_biases")
'


######################################################################################################
########################################### Q90Q99 ###################################################
######################################################################################################
ALP3=FALSE
observation <- stackAPGD(getAPGD())
print("quantile")
quantile_observations<-getQuantileObs(observation)
print("done")
lon <- raster(getAPGD()[[2]], varname="lon")
lat <- raster(getAPGD()[[2]], varname="lat")

eval_eur11<-getPR(getEUR11regridded_eval_pr(), varname="pr", "_FillValue")*3600*24
hist_eur11<-getPR(getEUR11regridded_historical_pr(), varname="pr", "_FillValue")*3600*24
eval_alp3<-getPR(getALP3regriddedevalPR(), varname="TOT_PREC", "missing_value")
hist_alp3<-stack(getALP3regriddedhistPR(), varname="TOT_PREC") #NO MISSING VALUE!!!!!!

quantile_eval_eur11<-getQuantile(eval_eur11)
quantile_hist_eur11<-getQuantile(hist_eur11)
quantile_eval_alp3<-getQuantile(eval_alp3)
quantile_hist_alp3<-getQuantile(hist_alp3)

saveRaster(quantile_eval_eur11, "q99_eval_eur11", "q99", longname = "99.Quantile")
saveRaster(quantile_hist_eur11, "q99_hist_eur11", "q99", longname = "99.Quantile")
saveRaster(quantile_eval_alp3, "q99_eval_alp3", "q99", longname = "99.Quantile")
saveRaster(quantile_hist_alp3, "q99_hist_alp3", "q99", longname = "99.Quantile")
saveRaster(quantile_observations, "q99_apgd", "q99", "99.Quantile")

ALP3=FALSE
return_val<-q99_SUB(quantile_eval_eur11, quantile_observations, lon=lon, lat=lat, EVAL=TRUE)
dif_eval<-return_val[[1]]
freq_eval<-return_val[[2]]
return_val<-q99_SUB(quantile_hist_eur11, quantile_observations, lon=lon, lat=lat, EVAL=FALSE)
dif_hist<-return_val[[1]]
freq_hist<-return_val[[2]]
ALP3=TRUE
return_val<-q99_SUB(quantile_eval_alp3, quantile_observations, lon=lon, lat=lat, EVAL=TRUE)
dif_eval_alp3<-return_val[[1]]
freq_eval_alp3<-return_val[[2]]
return_val<-q99_SUB(quantile_hist_alp3, quantile_observations, lon=lon, lat=lat, EVAL=FALSE)
dif_hist_alp3<-return_val[[1]]
freq_hist_alp3<-return_val[[2]]

quantil_mean<-meanOfQuantiles(dif_eval, dif_hist, dif_eval_alp3, dif_hist_alp3)
plotBoxplot(quantil_mean[[1]][[1]], "mean_q99_boxplot_hist_eur11", "EUR-11 historical", TRUE)
plotBoxplot(quantil_mean[[1]][[4]], "mean_q99_boxplot_eval_alp3", "ALP-3 evaluation", TRUE)
plotBoxplot(quantil_mean[[1]][[3]], "mean_q99_boxplot_hist_alp3", "ALP-3 historical", TRUE)

plotBoxplot(quantil_mean[[1]][[2]], "mean_q99_boxplot_eval_eur11", "EUR-11 evaluation", TRUE)

dif_eval_mean<-stackApply(dif_eval, indices=c(1), fun=mean)
freq_eval_mean<-freq(dif_eval_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
dif_eval_hist<-stackApply(dif_hist[[1]], indices=c(1), fun=mean)
dif_eval_alp3_mean<-stackApply(dif_eval_alp3[[1]], indices=c(1), fun=mean)
dif_hist_alp3_mean<-stackApply(dif_hist_alp3[[1]], indices=c(1), fun=mean)




'for(i in 1:11)
{
    print("Q99")
    print(paste("lon lat and q99 for", time_list_obs[i], "done"))
    plotJPGq90(raster=quantile_observations[[(i*2)-1]], lon=lon, lat=lat, paste0("q90", time_list_obs[i],"obs_remapped.jpg"), paste0("90. Quantile of percipitation[mm/day] in year ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
    plotJPGq99(raster=quantile_observations[[(i*2)]], lon=lon, lat=lat, paste0("q99", time_list_obs[i],"obs_remapped.jpg"), paste0("99. Quantile of percipitation[mm/day] in year ",
    time_list_obs[i]," in remapped observation data"), addMap=TRUE)
}'


#########################################################################################################
#########################################################################################################
############### --------------------- compare differences monthly ---------------- ######################
#########################################################################################################
#########################################################################################################

'
differences_eval<-compareMonthly(monthly_filename=filename_eval_monthly) # Get q90 and q99 differences
differences_hist<-compareMonthly(monthly_filename=filename_hist_monthly)
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

q90_winter_extent<-list() #two crop matrices
q90_winter_extent[[1]]<-extent(c(xmin=212, xmax=240, ymin=22,ymax=40))
q90_winter_extent[[2]]<-extent(c(xmin=122, xmax=130, ymin=23,ymax=35))
q90_spring_extent<-list()
q90_spring_extent[[1]]<-extent(c(xmin=172, xmax=201, ymin=97,ymax=111))
q90_spring_extent[[2]]<-extent(c(xmin=153, xmax=171, ymin=87,ymax=98))
q90_autumn_extent<-list()
q90_autumn_extent[[1]]<-extent(c(xmin=170, xmax=190, ymin=71,ymax=82))
q90_autumn_extent[[2]]<-extent(c(xmin=197, xmax=210, ymin=42,ymax=62))
q90_summer_extent<-list()
q90_summer_extent[[1]]<-extent(c(xmin=105, xmax=125, ymin=60,ymax=72))
q90_summer_extent[[2]]<-extent(c(xmin=99, xmax=109, ymin=79,ymax=92))
dyed_q90<-drawRectangle(dyed_hist[[1]], dyed_eval[[1]], q90_spring_extent, q90_summer_extent, q90_autumn_extent, q90_winter_extent)
quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(dyed_q90)), 
           nx=ncol(dyed_q90)+1, ny=nrow(dyed_q90)+1,
           main="First 20 maximal and minimal 90.quantile differences sorted by months in historical data (1=January, 12=December)", 
           col=monthly_colors, na.rm = TRUE)

spring_eval<-cropSeasons(extents=q90_spring_extent, initial_rasters=getMonthlyList(filename_eval_monthly, 2,5))
spring_hist<-cropSeasons(extents=q90_spring_extent, initial_rasters=getMonthlyList(filename_hist_monthly, 2,5))

summer_eval<-cropSeasons(extents=q90_summer_extent, initial_rasters=getMonthlyList(filename_eval_monthly, 2,5))
summer_hist<-cropSeasons(extents=q90_summer_extent, initial_rasters=getMonthlyList(filename_hist_monthly, 2,5))

autumn_eval<-cropSeasons(extents=q90_autumn_extent, initial_rasters=getMonthlyList(filename_eval_monthly, 2,5))
autumn_hist<-cropSeasons(extents=q90_autumn_extent, initial_rasters=getMonthlyList(filename_hist_monthly, 2,5))

winter_eval<-cropSeasons(extents=q90_winter_extent, initial_rasters=getMonthlyList(filename_eval_monthly, 2,5))
winter_hist<-cropSeasons(extents=q90_winter_extent, initial_rasters=getMonthlyList(filename_hist_monthly, 2,5))

spring_lon_q90<-list()
spring_lat_q90<-list()
spring_lon_q90[[1]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_spring_extent[[1]])
spring_lat_q90[[1]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_spring_extent[[1]])
spring_lon_q90[[2]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_spring_extent[[2]])
spring_lat_q90[[2]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_spring_extent[[2]])
'
'quilt.plot(data.frame(lon=as.vector(spring_lon$q90[[1]]),lat=as.vector(spring_lat$q90[[1]]),pr=as.vector(spring$q90[[1]])), 
           nx=ncol(spring$q90[[1]])+1, ny=nrow(spring$q90[[1]])+1,
           main="First 20 maximal and minimal 90.quantile differences sorted by months in historical data (1=January, 12=December)", 
           col=monthly_colors, na.rm = FALSE)
'
'
spring_lon_q90<-list()
spring_lat_q90<-list()
spring_lon_q90[[1]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_spring_extent[[1]])
spring_lat_q90[[1]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_spring_extent[[1]])
spring_lon_q90[[2]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_spring_extent[[2]])
spring_lat_q90[[2]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_spring_extent[[2]])

summer_lon_q90<-list()
summer_lat_q90<-list()
summer_lon_q90[[1]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_summer_extent[[1]])
summer_lat_q90[[1]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_summer_extent[[1]])
summer_lon_q90[[2]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_summer_extent[[2]])
summer_lat_q90[[2]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_summer_extent[[2]])

autumn_lon_q90<-list()
autumn_lat_q90<-list()
autumn_lon_q90[[1]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_autumn_extent[[1]])
autumn_lat_q90[[1]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_autumn_extent[[1]])
autumn_lon_q90[[2]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_autumn_extent[[2]])
autumn_lat_q90[[2]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_autumn_extent[[2]])

winter_lon_q90<-list()
winter_lat_q90<-list()
winter_lon_q90[[1]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_winter_extent[[1]])
winter_lat_q90[[1]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_winter_extent[[1]])
winter_lon_q90[[2]]<-crop((raster(input_files_eval_pr[[1]], varname="lon")), q90_winter_extent[[2]])
winter_lat_q90[[2]]<-crop(raster(input_files_eval_pr[[1]], varname="lat"), q90_winter_extent[[2]])

'
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
