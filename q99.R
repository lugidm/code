getQuantile <- function(allDays){
  qt_by_year<-raster()
  for(i in 1996:2005){
    date_string_start <- paste0(toString(i), "-01-01")
    date_string_end <- paste0(toString(i+1), "-01-01")
    dummy<-allDays[[i-1995]]
    qt_by_year <- addLayer(qt_by_year, calc(dummy,Q99))
    names(qt_by_year[[i-1995]])<-paste0(date_string_start,"..", date_string_end)
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
    legend(x=-80, y=80, legend=c("Historical EUR11", "Historical ALP3", "Evaluation EUR11", "Evaluation ALP3"),
           col=c("green", "blue", "red", "purple"), lty=c(1))
  dev.off()
  return(list(stack(hist_mean, eval_mean, hist_alp3_mean, eval_alp3_mean),freq_hist_mean, freq_eval_mean, freq_hist_alp3_mean, freq_eval_alp3_mean))  
}