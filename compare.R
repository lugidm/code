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
    print("doit")
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

    return(list(differences_mean, frequencies_mean, differences_quantile,frequencies_quantile))

}

compareMonthly<-function(monthly_filename){
    differences<-list()
    for(months in 1:12){differences[[months]]<-list(1,2)}
    for(months in 1:12){
        sim<-getMonthlyList(monthly_filename, months, months)
        obs<-getMonthlyList(filename_obs_monthly, months, months)
        extent(obs[[1]])<-extent(sim[[1]])
        sim<-calc(sim[[1]][[-(nlayers(sim[[1]])-1):-(nlayers(sim[[1]]))]], fun=Q99)
        obs<-calc(obs[[1]][[-(nlayers(obs[[1]])-1):-(nlayers(obs[[1]]))]], fun=Q99)
        differences[[months]][[1]]<-overlay(sim[[1]], obs[[1]], fun=function(x,y){x-y})
        differences[[months]][[2]]<-overlay(sim[[2]], obs[[2]], fun=function(x,y){x-y})
    }
    return(differences)
}
dyeMaxMinDifferences<-function(differences, num_maximas){
    
    dyed_maximal_differences<-differences[[1]][[1]] # first layer is q90
    dyed_maximal_differences<-addLayer(dyed_maximal_differences, differences[[1]][[2]]) # second layer is q99
    values(dyed_maximal_differences)<-NA
    maxmin_positions<-NA
    maxmin_positions<-list()
    for(months in 1:12){
        maxmin_positions[[months]]<-list(q90=0, q99=0)
        maxmin_positions[[months]]$q90<-list(max=0,min=0)
        maxmin_positions[[months]]$q99<-list(max=0, min=0)
    }

    for(months in 1:12){
        maxmin_positions[[months]]$q90$max<-which.max(differences[[months]][[1]])
        maxmin_positions[[months]]$q90$min<-which.min(differences[[months]][[1]])
        maxmin_positions[[months]]$q99$max<-which.max(differences[[months]][[2]])
        maxmin_positions[[months]]$q99$min<-which.min(differences[[months]][[2]])
        dyed_maximal_differences[[1]][maxmin_positions[[months]]$q90$max[[1]]]<-months
        dyed_maximal_differences[[1]][maxmin_positions[[months]]$q90$min[[1]]]<-months
        dyed_maximal_differences[[2]][maxmin_positions[[months]]$q99$max[[(1)]]]<-months
        dyed_maximal_differences[[2]][maxmin_positions[[months]]$q99$min[[(1)]]]<-months
        #print(dyed_maximal_differences)
        for(maximas in 1:num_maximas)
        {
            differences[[months]][[1]][maxmin_positions[[months]]$q90$max[maximas]]<-0
            differences[[months]][[1]][maxmin_positions[[months]]$q90$min[maximas]]<-0
            maxmin_positions[[months]]$q90$max<-c(maxmin_positions[[months]]$q90$max, which.max(differences[[months]][[1]]))
            maxmin_positions[[months]]$q90$min<-c(maxmin_positions[[months]]$q90$min, which.min(differences[[months]][[1]]))
            dyed_maximal_differences[[1]][maxmin_positions[[months]]$q90$max[[(maximas+1)]]]<-months
            dyed_maximal_differences[[1]][maxmin_positions[[months]]$q90$min[[(maximas+1)]]]<-months
            
            differences[[months]][[2]][maxmin_positions[[months]]$q99$max[maximas]]<-0
            differences[[months]][[2]][maxmin_positions[[months]]$q99$min[maximas]]<-0
            maxmin_positions[[months]]$q99$max<-c(maxmin_positions[[months]]$q99$max, which.max(differences[[months]][[2]]))
            maxmin_positions[[months]]$q99$min<-c(maxmin_positions[[months]]$q99$min, which.min(differences[[months]][[2]]))
            dyed_maximal_differences[[2]][maxmin_positions[[months]]$q99$max[[(maximas+1)]]]<-months
            dyed_maximal_differences[[2]][maxmin_positions[[months]]$q99$min[[(maximas+1)]]]<-months
        }
    }
    return(dyed_maximal_differences)
}
