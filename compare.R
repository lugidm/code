# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 21.10.19


compareSUB <- function(simulated, observated, lon, lat, EVAL)
{
    obs_without_lon <- dropLayer(observated, c(nlayers(observated)-1, nlayers(observated)))
    if(EVAL==TRUE & ALP3==FALSE)
    {
            obs_without_lon <- dropLayer(obs_without_lon, 1)
    }

    sim_without_lon <- dropLayer(simulated, c(nlayers(simulated)-1, nlayers(simulated)))
    extent(obs_without_lon)<-extent(sim_without_lon)
    dif<- overlay(sim_without_lon, obs_without_lon,fun=function(x,y){return((x - y))})
    f<-freq(dif, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(ALP3)
    {
        if(EVAL){
            plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
            "dif_mprs_alp3eval-apgd.jpg", "Difference of mean percipitation (APGD-eval)[mm/day]", addMap=TRUE, EVAL=EVAL)
        }else{
            plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
            "dif_mprs_alp3hist-apgd.jpg", "Difference of mean percipitation (APGD-hist)[mm/day]", addMap=TRUE, EVAL=EVAL)
        }
    }else{
        if(EVAL){
            plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
            "dif_mprs_eval-obs.jpg", "Difference of mean percipitation (observated-eval)[mm/day]", addMap=TRUE, EVAL=EVAL)
        }else{
            plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
            "dif_mprs_hist-obs.jpg", "Difference of mean percipitation (observated-hist)[mm/day]", addMap=TRUE, EVAL=EVAL)
        }
    }
    return(list(dif, f))
}

compareAllYears<-function(differences, frequencies, lon, lat, EVAL)
{

    differences_mean<-stackApply(differences, indices=c(1), fun=mean)
    print("mean diff:")
    print(mean(na.omit(values(differences_mean))))
    frequencies_mean<-freq(differences_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(ALP3==TRUE)
    {
        if(EVAL)
        {
            plotMeanDifferences(differences_mean, frequencies_mean, lon, lat, filename="dif_mean_eval_apgd.jpg", EVAL=EVAL)
        }else{
            plotMeanDifferences(differences_mean, frequencies_mean, lon, lat, filename="dif_mean_hist_apgd.jpg", EVAL=EVAL)
        }
    }else{
        if(EVAL)
        {
            plotMeanDifferences(differences_mean, frequencies_mean, lon, lat, filename="dif_mean_eval.jpg", EVAL=EVAL)
        }else{
            plotMeanDifferences(differences_mean, frequencies_mean, lon, lat, filename="dif_mean_hist.jpg", EVAL=EVAL)
        }
    }
    ####################################################################################################################
    ######################   QUANTILE ##################################################################################
    ####################################################################################################################
   ' print("doit")
    differences_quantile<-calc(differences,fun=Q99,forceapply=TRUE)


    print("did it")
   # print(mean(na.omit(values(differences_quantile))))
    frequencies_quantile<-freq(differences_quantile, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(ALP3==TRUE)
    {
        if(EVAL)
        {
            plotQ90Q99Differences(differences_quantile[[1]], frequencies_quantile[[1]], lon, lat, filename="dif_q90_eval_apgd.jpg",
            plotmain = "90. quantile", EVAL=EVAL)
            plotQ90Q99Differences(differences_quantile[[2]], frequencies_quantile[[2]], lon, lat, filename="dif_q99_eval_apgd.jpg",
            plotmain = "99. quantile", EVAL=EVAL)
        }else{
            plotQ90Q99Differences(differences_quantile[[1]], frequencies_quantile[[1]], lon, lat, filename="dif_q90_hist_apgd.jpg",
            plotmain = "90. quantile", EVAL=EVAL)
            plotQ90Q99Differences(differences_quantile[[2]], frequencies_quantile[[2]], lon, lat, filename="dif_q99_hist_apgd.jpg",
            plotmain= "99. quantile", EVAL=EVAL)
        }
    }else{
        if(EVAL)
        {
            plotQ90Q99Differences(differences_quantile[[1]], frequencies_quantile[[1]], lon, lat, filename="dif_q90_eval.jpg",
            plotmain = "90. quantile", EVAL=EVAL)
            plotQ90Q99Differences(differences_quantile[[2]], frequencies_quantile[[2]], lon, lat, filename="dif_q99_eval.jpg",
            plotmain = "99. quantile", EVAL=EVAL)
        }else{
            plotQ90Q99Differences(differences_quantile[[1]], frequencies_quantile[[1]], lon, lat, filename="dif_q90_hist.jpg",
            plotmain = "90. quantile", EVAL=EVAL)
            plotQ90Q99Differences(differences_quantile[[2]], frequencies_quantile[[2]], lon, lat, filename="dif_q99_hist.jpg",
            plotmain= "99. quantile", EVAL=EVAL)
        }
    }
    '

    'max_diff<-calc(differences,fun=GREATESTDIFF,forcefun=TRUE)
    frequencies_quantile<-freq(max_diff, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(EVAL)
    {
        plotQ90Q99Differences(max_diff, frequencies_quantile, lon, lat, filename="dif_max_eval.jpg",
        plotmain = "maximal differences", EVAL=EVAL)
    }else{
        plotQ90Q99Differences(max_diff, frequencies_quantile, lon, lat, filename="dif_max_hist.jpg",
        plotmain= "maximal differences", EVAL=EVAL)
    }'

    return(list(differences_mean, frequencies_mean))

}