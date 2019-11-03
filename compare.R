# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 21.10.19



compareSUB <- function(simulated, observated, EVAL)
{
    obs_without_lon <- dropLayer(observated, c(nlayers(observated)-1, nlayers(observated)))
    if(EVAL==TRUE)
    {
            obs_without_lon <- dropLayer(obs_without_lon, 1)
    }

    sim_without_lon <- dropLayer(simulated, c(nlayers(simulated)-1, nlayers(simulated)))
    extent(obs_without_lon)<-extent(sim_without_lon)
    dif<- overlay(sim_without_lon, obs_without_lon,fun=function(x,y){return((x - y))})
    f<-freq(dif, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(EVAL){
        plotDifferences(frequencies=f, raster=dif, lon=subset(simulated, nlayers(simulated)-1), lat=subset(simulated, nlayers(simulated)),
        "dif_mprs_eval-obs.jpg", "Difference of mean percipitation (observated-eval)[mm/day]", addMap=TRUE, EVAL=EVAL)
    }else{
        plotDifferences(frequencies=f, raster=dif, lon=subset(simulated, nlayers(simulated)-1), lat=subset(simulated, nlayers(simulated)),
        "dif_mprs_hist-obs.jpg", "Difference of mean percipitation (observated-hist)[mm/day]", addMap=TRUE, EVAL=EVAL)
    }
    return(list(dif, f))
}

compareAllYears<-function(differences, frequencies, lon, lat, EVAL)
{
    differences_mean<-stackApply(differences, indices=c(1), fun=mean)
    print("mean diff:")
    print(mean(na.omit(values(differences_mean))))
    frequencies_mean<-freq(differences_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(EVAL)
    {
        plotMeanDifferences(differences_mean, frequencies_mean, lon, lat, filename="dif_mean_eval.jpg", EVAL=EVAL)
    }else{
        plotMeanDifferences(differences_mean, frequencies_mean, lon, lat, filename="dif_mean_hist.jpg", EVAL=EVAL)
    }
    ####################################################################################################################
    ######################   QUANTILE ##################################################################################
    ####################################################################################################################
    print("doit")
    differences <- stack(differences)
    print(differences)
    differences_quantile<-calc(differences, fun=Q99, forcefun=TRUE)
    print("did it")
   # print(mean(na.omit(values(differences_quantile))))
    frequencies_quantile<-freq(differences_quantile, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    if(EVAL)
    {
        plotMeanDifferences(differences_quantile[[1]], frequencies_quantile, lon, lat, filename="dif_q90_eval.jpg", EVAL=EVAL)
        plotMeanDifferences(differences_quantile[[2]], frequencies_quantile, lon, lat, filename="dif_q99_eval.jpg", EVAL=EVAL)
    }else{
        plotMeanDifferences(differences_quantile[[1]], frequencies_quantile, lon, lat, filename="dif_q90_hist.jpg", EVAL=EVAL)
        plotMeanDifferences(differences_quantile[[2]], frequencies_quantile, lon, lat, filename="dif_q99_hist.jpg", EVAL=EVAL)
    }

}