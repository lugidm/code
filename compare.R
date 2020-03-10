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

q99_SUB <- function(simulated, observated, lon, lat, EVAL)
{
  extent(observated)<-extent(simulated)
  dif<- overlay(simulated, observated,fun=function(x,y){return((x - y))})
  f<-freq(dif, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
  if(ALP3)
  {
    if(EVAL){
      plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
                      "dif_q99_eval_alp3.jpg", "Difference in the 99. Percentile [mm/day]", addMap=TRUE, EVAL=EVAL)
    }else{
      plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
                      "dif_q99_hist_alp3.jpg", "Difference in the 99. Percentile [mm/day]", addMap=TRUE, EVAL=EVAL)
    }
  }else{
    if(EVAL){
      plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
                      "dif_q99_eval_eur11.jpg", "Difference in the 99. Percentile [mm/day]", addMap=TRUE, EVAL=EVAL)
    }else{
      plotDifferences(frequencies=f, raster=dif, lon=lon, lat=lat,
                      "dif_q99_hist_eur11.jpg", "Difference in the 99. Percentile [mm/day]", addMap=TRUE, EVAL=EVAL)
    }
  }
  return(list(dif, f))
}

q99_SeasonsSUB <- function(simulated, observated, lon, lat, filename, plotmain)
{
  differences<-list(spring=NULL, summer=NULL, autumn=NULL, winter=NULL)
  frequencies<-list(spring=NULL, summer=NULL, autumn=NULL, winter=NULL)
  for(i in 1:4)
  {
    extent(observated[[i]])<-extent(simulated[[i]])
    dif<- overlay(simulated[[i]], -observated[[i]],fun=sum,na.rm=TRUE)
    f<-freq(dif, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
    jpeg(paste0(output_dir,filename, names(simulated)[[i]],".jpg"), height = 500, width = 750)
      quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(dif)), nx=ncol(dif), ny=nrow(dif),
                 main=paste0("99. Quantile-Differences ", plotmain, " in ", names(simulated)[[i]], " [mm/day]"))
      map(add=TRUE, col="black")
    dev.off()
      jpeg(paste0(output_dir,"frequencies", filename, names(simulated)[[i]], ".jpg"), height = 400, width = 650)
      plot(f, type="l", col="black", xlab="difference [mm/day]", ylab="over all appearance",
           main=paste0("Frequency plot from ",plotmain," in ", names(simulated)[[i]]))
      ', axis=FALSE)
          axis(1, seq(round(min(frequencies[[i]][,1])), round(max(frequencies[[i]][,1])), by = 10))
          axis(2, seq(round(min(frequencies[[i]][,2])), round(max(frequencies[[i]][,2])), by = 10))
          abline(h=seq(round(min(frequencies[[i]][,2])), round(max(frequencies[[i]][,2])), by=10), v=seq(round(min(frequencies[[i]][,1])),
          round(max(frequencies[[i]][,1])), by=10), col="gray", lty=3)'
      print(paste0("plotted ",names(simulated)[[i]]))
      dev.off()
      differences[[i]]<-dif
      frequencies[[i]]<-f
  }
  
  
  return(list(differences, frequencies))
}



