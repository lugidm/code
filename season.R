spring_start <- "-03-20"
spring_end<- "-06-20"
summer_start <- "-06-20"
summer_end <- "-09-22"
autumn_start <- "-09-22"
autumn_end <- "-12-22"
winter_start <- "-12-22"
winter_end <- "-03-20"
cropAndMean<-function(raster_list, ex, season){
  return_raster_list<-raster_list
  timeline<-raster_list
  for(i in 1:length(raster_list)){
    if(season=="spring"){
      split<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) <= as.Date(paste0(i+1995,spring_end)))& 
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,spring_start)))))
      timeline[[i]]<-seq(as.Date(paste0(toString(i+1995),spring_start)), as.Date(paste0(toString(i+1995), spring_end)), by="day")
    }
    if(season=="summer"){
      split<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) <= as.Date(paste0(i+1995,summer_end)))& 
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,summer_start)))))
      timeline[[i]]<-seq(as.Date(paste0(toString(i+1995),summer_start)), as.Date(paste0(toString(i+1995), summer_end)), by="day")
    }
    new_raster<-crop(split,ex)
    new_raster<-cellStats(new_raster, stat='mean', na.rm=TRUE)
    return_raster_list[[i]]<-new_raster
    names(return_raster_list[[i]])<-timeline[[i]]
    
  }
  ret_dat<-data.frame(timeline=timeline[[i]], return_raster_list)
  return(ret_dat)
}
cropAndMeanAndMean<-function(raster_list, simulated, ex, season, year_of_interest){
  return_raster_list<-list(observated=raster_list, simulated=simulated)
  timeline<-raster_list
  
  for(i in 1:length(raster_list)){
    if(season=="spring"){
      split_obs<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) <= as.Date(paste0(i+1995,spring_end)))& 
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,spring_start)))))
      split_sim<-subset(simulated[[i]],which((getZ(simulated[[i]]) <= as.Date(paste0(i+1995,spring_end)))& 
                                                 (getZ(simulated[[i]]) >= as.Date(paste0(i+1995,spring_start)))))
      timeline[[i]]<-seq(as.Date(paste0(toString(i+1995),spring_start)), as.Date(paste0(toString(i+1995), spring_end)), by="day")
    }
    if(season=="summer"){
      split_obs<-subset(raster_list[[i]],which((getZ(raster_list[[i]]) <= as.Date(paste0(i+1995,summer_end)))& 
                                             (getZ(raster_list[[i]]) >= as.Date(paste0(i+1995,summer_start)))))
      split_sim<-subset(simulated[[i]],which((getZ(simulated[[i]]) <= as.Date(paste0(i+1995,summer_end)))& 
                                                 (getZ(simulated[[i]]) >= as.Date(paste0(i+1995,summer_start)))))
      timeline[[i]]<-seq(as.Date(paste0(toString(i+1995),summer_start)), as.Date(paste0(toString(i+1995), summer_end)), by="day")
    }
    new_raster_obs<-crop(split_obs, ex)
    new_raster_sim<-crop(split_sim, ex)
    new_raster_obs<-cellStats(new_raster_obs, stat='mean', na.rm=TRUE)
    new_raster_sim<-cellStats(new_raster_sim, stat='mean', na.rm=TRUE)
    return_raster_list$observated[[i]]<-new_raster_obs
    return_raster_list$simulated[[i]]<-new_raster_sim
  }
  means<-list(timeline=timeline[[year_of_interest-1995]], beobachtung=list(), modell=list())
    for(j in 1:length(return_raster_list$observated[[i]]))
    {
      s_obs<-0
      s_sim<-0
      for(i in 1:length(return_raster_list$observated))
      {
        s_obs<-s_obs+return_raster_list$observated[[i]][[j]]
        s_sim<-s_sim+return_raster_list$simulated[[i]][[j]]
      }
      means$modell<-list.append(means$modell,as.numeric(return_raster_list$simulated[[year_of_interest-1995]][[j]]-s_sim/length(return_raster_list$simulated)))
      means$beobachtung<-list.append(means$beobachtung,as.numeric(return_raster_list$observated[[year_of_interest-1995]][[j]]-s_obs/length(return_raster_list$observated)))
    }
  setDT(means)
  #ret_dat<-data.frame(timeline=timeline[[year_of_interest-1995]], cbind(simulated=mean_sim, observated=mean_obs))
  ret_dat<-data.frame(means)
  return(means)
}
