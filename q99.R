getQuantile <- function(list_allDays){
  qt_by_year<-raster()
  for(i in 1996:2005){
    'date_string_start <- paste0(toString(i), "-01-01")
    date_string_end <- paste0(toString(i+1), "-01-01")
    ids<-which((getZ(allDays) < as.Date(date_string_end))& (getZ(allDays) >= as.Date(date_string_start)))
    '
    dummy<-list_allDays[[i-1995]]
    qt_by_year <- addLayer(qt_by_year, calc(dummy,Q99))
    names(qt_by_year[[i-1995]])<-paste0(toString(i))
  }
  return(qt_by_year)
}

meanOfQuantiles<-function(eval, hist, eval_alp3, hist_alp3){
  eval_mean<-stackApply(eval, indices=c(1), fun=mean)
  hist_mean<-stackApply(hist, indices = c(1), fun=mean)
  eval_alp3_mean<-stackApply(eval_alp3, indices = c(1), fun=mean)
  hist_alp3_mean<-stackApply(hist_alp3, indices=c(1), fun=mean)
  
  freq_eval_mean<-freq(eval_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
  freq_hist_mean<-freq(hist_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
  freq_eval_alp3_mean<-freq(eval_alp3_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
  freq_hist_alp3_mean<-freq(hist_alp3_mean, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")
  
  jpeg(paste0(output_dir, "freq_mean_q99.jpg"), height = 600, width = 900)
    plot(freq_eval_mean, type="l", col="red", xlab="Mean divergence of 99. Quantile[mm/day]", ylab="over all appearance",
         main="Frequencies plot of 99. Quantile differences for period 1996-2005")
    lines(freq_hist_mean, col="green", type="l")
    lines(freq_eval_alp3_mean, col="purple", type="l")
    lines(freq_hist_alp3_mean, col="blue", type="l")
    abline(h=seq(0, 200, by=50), v=seq(-65, 30, by=5), col="gray", lty=3)
    legend(x=-40, y=80, legend=c("Historical EUR11", "Historical ALP3", "Evaluation EUR11", "Evaluation ALP3"),
           col=c("green", "blue", "red", "purple"), lty=c(1))
  dev.off()
  return(list(stack(hist_mean, eval_mean, hist_alp3_mean, eval_alp3_mean),freq_hist_mean, freq_eval_mean, freq_hist_alp3_mean, freq_eval_alp3_mean))  
}
getQuantileOfSeasons <- function(list_all_days){
  qt_by_year<-list(spring=NULL, summer=NULL, autumn=NULL, winter=NULL)
  for(i in 1:4){
    qt_by_year[[i]]<- calc(list_all_days[[i]],Q99)
    justQuiltPlot(qt_by_year[[i]], lon, lat)
  }
  return(qt_by_year)
}

findCellWithValue<-function(raster_list, value_min, value_max, season){
  ids<-list('1996'=list(), '1997'=list(), '1998'=list(), '1999'=list(), '2000'=list(), '2001'=list(), '2002'=list(), '2003'=list(), '2004'=list(), '2005'=list())
  spring_start <- "-03-20"
  spring_end<- "-06-20"
  summer_start <- "-06-20"
  summer_end <- "-09-22"
  autumn_start <- "-09-22"
  autumn_end <- "-12-22"
  winter_start <- "-12-22"
  winter_end <- "-03-20"
  for(i in 1:length(raster_list)){
    if(season=="spring")
    {
      split<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) < as.Date(paste0(i+1995,spring_end)))& 
                                            (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,spring_start)))))
      for(j in 1:nlayers(split))
      {
        freeze<-which(na.omit(values(split[[j]])) <= value_max & na.omit(values(split[[j]])) >= value_min)
        if(!is.null(freeze) & length(freeze)>0){
  
          ids[[i]]<-append(ids[[i]], list(day=j, cells=freeze))
        }
        
      }
    }else if(season=="summer")
    {
      split<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) < as.Date(paste0(i+1995,summer_end)))& 
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,summer_start)))))
      ids[[i]]<-which(values(split) < value_max & (values(split) >= value_min))
    }else if(season=="autumn")
    {
      split<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) < as.Date(paste0(i+1995,autumn_end)))& 
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,autumn_start)))))
      ids[[i]]<-which(values(split) < value_max & (values(split) >= value_min))
    }
    else if(season=="winter")
    {
      split<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) < as.Date(paste0(i+1995,winter_end)))|
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,winter_start)))))
      ids[[i]]<-which(values(split) < value_max & (values(split) >= value_min))
    }
  }
  return(ids)
}