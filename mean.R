getAnnualMeanSim <- function(allDays){
  pr_by_year<-raster()
  for(i in 1:length(allDays)){
    dummy<-calc(allDays[[i]],fun=mean)
    names(dummy) <- toString(i+1995)
    pr_by_year <- addLayer(pr_by_year, dummy)
  }
  return(pr_by_year)
}
stackSim <- function(inputfiles, varname, factor){
  listus<-list('1996'=raster(), '1997'=raster(), '1998'=raster(), '1999'=raster(),'2000'=raster(), '2001'=raster(),
               '2002'=raster(), '2003'=raster(), '2004'=raster(),'2005'=raster())
  for(i in 1:length(inputfiles))
  {
    listus[[i]]<- stack(inputfiles[[i]], varname=varname)*factor
  }
  return(listus)
}

cropMean2002<-function(raster_stack){
  M<-extent(c(xmin=100, xmax=108, ymin=78,ymax=87))
  return_raster<-raster()
  for(i in 1:nlayers(raster_stack)){
    new_raster<-crop(raster_stack[[i]],M)
    return_raster<-addLayer(return_raster, new_raster)
  }
  return(return_raster)
}
drawRect<-function(raster, extent){
    overall<-raster
    for(x in xmin(extent):xmax(extent))
      {
        overall[cellFromXY(overall,cbind(x,ymin(extent)))]<-20
        overall[cellFromXY(overall,cbind(x,ymax(extent)))]<-20
      }
    for(y in ymin(extent):ymax(extent)){
      overall[cellFromXY(overall, cbind(xmin(extent), y))]<-20
      overall[cellFromXY(overall, cbind(xmax(extent), y))]<-20
    }
  return(overall)
}

subArrayMean <- function(hist_eur11, eval_eur11, hist_alp3, eval_alp3, observated)
{
  e11_hist<-cellStats(hist_eur11, "mean")
  
  e11_eval<-cellStats(eval_eur11, "mean")
  alp3_hist<-cellStats(hist_alp3, "mean")
  alp3_eval<-cellStats(eval_alp3, "mean")
  obs<-cellStats(observated, "mean")
  
  dif_e11_hist<-e11_hist
  dif_e11_eval<-e11_eval
  dif_alp3_hist<-alp3_hist
  dif_alp3_eval<-alp3_eval
  for(i in 1:length(observated)){
    dif_e11_hist[i][[1]]<-(e11_hist[i][[1]]-obs[i][[1]])
    dif_e11_eval[i][[1]]<-(e11_eval[i][[1]]-obs[i][[1]])
    dif_alp3_hist[i][[1]]<-(alp3_hist[i][[1]]-obs[i][[1]])
    dif_alp3_eval[i][[1]]<-(alp3_eval[i][[1]]-obs[i][[1]])
  }
  ret_dat<-data.frame(timeline=seq(from=as.Date("2002-01-01"), to=as.Date("2002-12-31"), by="day"), "EUR-11-Historical"=dif_e11_hist, 
                                "EUR-11-Evaluation"=dif_e11_eval, "ALP-3-Historical"=dif_alp3_hist, "ALP-3-Evaluation"=dif_alp3_eval)
  return(ret_dat)
}

putInData<-function(simulated_1, simulated_2, observated, start_date, end_date){
  sim1<-cellStats(simulated_1, "mean")
  sim2<-cellStats(simulated_2, "mean")
  obs<-cellStats(observated, "mean")
  ret_dat<-data.frame(timeline=seq(from=as.Date(start_date), to=as.Date(end_date), by="day"), "ALP-3-Historical"=sim1, "EUR-11-Historical"=sim2, "Observated(APGD)"=obs)
  return(ret_dat)
}