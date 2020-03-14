# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19

monthly_colors = c("#00FFFF", "#009999", "#00CC66", "#006600", "#66CC00", "#CCCC00", "#CC6600", "#CC0000", "#CC0066", "#990099", "#66B2FF", "#3333FF")
recttext <- function(xl, yb, xr, yt, text, rectArgs = NULL, textArgs = NULL) {
    center <- c(mean(c(xl, xr)), mean(c(yb, yt)))
    do.call('rect', c(list(xleft = xl, ybottom = yb, xright = xr, ytop = yt), rectArgs))
    do.call('text', c(list(x = center[1], y = center[2], labels = text), textArgs))
}

plotJPGmean <- function(raster, lon, lat, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    if(ALP3==TRUE)
    {
        quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=ncol(raster)-1, ny=nrow(raster)-1,
        main=plotmain)# na.rm=TRUE)
    }else{
        quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=ncol(raster)-1, ny=nrow(raster)-1,
        'col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8', main=plotmain, na.rm=TRUE, 'lab.breaks=c(0.0:9.0)*1.8')
    }
    #quilt.plot(data.frame(lon=as.vector(subset(raster, 'longitude')),lat=as.vector(subset(raster,'latitude')),pr=as.vector(subset(raster, 1))), nx=412, ny=424,
    #col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}

plotJPGobs <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    plot(rast, main=plotmain, breaks= c(0:9)*1.8)
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}

plotJPGq90 <- function(raster, lon, lat, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=412, ny=424,
    col=rev(heat.colors(9)), breaks = c(0.0:9.0)*5, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*5)
    #quilt.plot(data.frame(lon=as.vector(subset(raster, 'longitude.coordinate')),lat=as.vector(subset(raster,'latitude.coordinate')),pr=as.vector(subset(raster, 1))), nx=412, ny=424,
    #col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}
plotJPGq99 <- function(raster, lon, lat, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=412, ny=424,
    col=rev(heat.colors(9)), breaks = c(0.0:9.0)*14, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*14)

    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}

plotJPGobsq99 <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    plot(rast, main=plotmain, breaks= c(0:9)*14, col=rev(heat.colors(n=9)))
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}

plotJPGobsq90 <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    plot(rast, main=plotmain, breaks= c(0:9)*5, col=rev(heat.colors(n=9)))
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}


plotDifferences <- function(frequencies, raster, lon, lat, filename, plotmain, addMap, EVAL){
    #jpeg(paste0(output_dir,filename), height = 300, width = 300)
    for(i in 1:nlayers(raster))
    {
        jpeg(paste0(output_dir,toString(i+1995),filename), height = 500, width = 750)
        if(ALP3==TRUE)
        {
          quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster[[i]])), nx=ncol(raster), ny=nrow(raster),
                     #col=rev(heat.colors(9)),
                     main=paste0(plotmain, " in ", toString(i+1995)))#breaks = c(0.0:9.0)*2, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
        }else{
            if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster[[i]])), nx=ncol(raster), ny=nrow(raster),
            #col=rev(heat.colors(9)),
            main=paste0(plotmain, " in ", toString(i+1995)))#breaks = c(0.0:9.0)*2, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
            }else{
                quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster[[i]])), nx=ncol(raster), ny=nrow(raster),
                main=paste0(plotmain, " in ", toString(i+1995)))
            }
        }
        #quilt.plot(data.frame(lon=as.vector(subset(raster, 'longitude')),lat=as.vector(subset(raster,'latitude')),pr=as.vector(subset(raster, 1))), nx=412, ny=424,
        #col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
        if(!is.null(addMap) & addMap == TRUE){
            map(add=TRUE, col='black')
        }
        dev.off()
        jpeg(paste0(output_dir,toString(i+1995),"frequencies", filename), height = 400, width = 650)
          plot(frequencies[[i]], type="l", col="black", xlab="difference", ylab="over all appearance",
          main=paste0("Frequency plot in ", toString(i+1995)))
          grid(col="gray", lty = 2)
          ', axis=FALSE)
          axis(1, seq(round(min(frequencies[[i]][,1])), round(max(frequencies[[i]][,1])), by = 10))
          axis(2, seq(round(min(frequencies[[i]][,2])), round(max(frequencies[[i]][,2])), by = 10))
          abline(h=seq(round(min(frequencies[[i]][,2])), round(max(frequencies[[i]][,2])), by=10), v=seq(round(min(frequencies[[i]][,1])),
          round(max(frequencies[[i]][,1])), by=10), col="gray", lty=3)'
          print(paste0("plotted ", i+1995))
        dev.off()

    }
}

plotMeanDifferences <- function(differences, frequencies, lon, lat, filename, EVAL)
{
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    if(ALP3==TRUE)
    {
        if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main="Mean difference in evaluation-APGD differences for period 1996-2005")
        }
        else{
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main="Mean difference in historical-APGD differences for period 1996-2005")
        }
    }else{
        if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main="Mean difference in evaluation-observated differences for period 1996-2005")
        }else{
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main="Mean difference in historical-observated differences for period 1996-2005")
        }
    }
    map(add=TRUE, col='black')
    print("plotted raster")
    dev.off()
    if(ALP3==TRUE)
    {
        if(EVAL){
            jpeg(paste0(output_dir, "frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="mean divergence", ylab="over all mean-appearance",
            main="Mean frequencies plot in evaluation-APGD differences for period 1996-2005")
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            grid(col="gray", lty = 2)
        }else{
            jpeg(paste0(output_dir,"frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="mean divergence", ylab="over all mean-appearance",
            main="Mean frequencies plot in historical-APGD differences for period 1996-2005")
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            grid(col="gray", lty = 2)
        }
    }else{
        if(EVAL){
            jpeg(paste0(output_dir, "frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="mean divergence", ylab="over all mean-appearance",
            main="Mean frequencies plot in evaluation-APGD differences for period 1996-2005")
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            grid(col="gray", lty = 2)
        }else{
            jpeg(paste0(output_dir,"frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="mean divergence", ylab="over all mean-appearance",
            main="Mean frequencies plot in historical-APGD differences for period 1995-2005")
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            grid(col="gray", lty = 2)
        }
    }
    print("plotted frequencies")
    dev.off()
}

plotQ90Q99Differences <- function(differences, frequencies, lon, lat, filename, plotmain, EVAL)
{
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    if(ALP3==TRUE)
    {
        if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main=paste0(plotmain, " in evaluation-APGD differences for period 1996-2005"))
        }else{
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main=paste0(plotmain, " in historical-APGD differences for period 1996-2005"))
        }
    }else{
        if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main=paste0(plotmain, " in evaluation-observated differences for period 1996-2005"))
        }else{
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=ncol(differences)-1, ny=nrow(differences)-1,
            main=paste0(plotmain, " in historical-observated differences for period 1995-2005"))
        }
    }
    map(add=TRUE, col='black')
    print("plotted raster")
    dev.off()
    if(ALP3==TRUE)
    {
        if(EVAL){
            jpeg(paste0(output_dir, "frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="quantile of mean divergence[mm/day]", ylab="over all appearance",
            main=paste0(plotmain, " frequencies plot in evaluation-APGD differences for period 1996-2005")
            ,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 30))
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
            round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
        }else{
            jpeg(paste0(output_dir,"frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="quantile of mean divergence[mm/day]", ylab="over all appearance",
            main=paste0(plotmain, " frequencies plot in historical-APGD differences for period 1996-2005"),
            xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 30))
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
            round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
        }
    }else{
        if(EVAL){
            jpeg(paste0(output_dir, "frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="quantile of mean divergence[mm/day]", ylab="over all appearance",
            main=paste0(plotmain, " frequencies plot in evaluation-observated differences for period 1996-2005"))
            #,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 26))
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
            round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
        }else{
            jpeg(paste0(output_dir,"frequencies", filename), height = 600, width = 900)
            plot(frequencies, type="l", col="black", xlab="quantile of mean divergence[mm/day]", ylab="over all appearance",
            main=paste0(plotmain, " frequencies plot in historical-observated differences for period 1995-2005"))
            #,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 28))
            #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
            abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
            round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
        }
    }

    print("plotted frequencies")
    dev.off()
}

plotTwoFrequencies <- function(freq_eval, freq_hist, filename, data_type){
    jpeg(paste0(output_dir, filename), height = 600, width = 900)
    plot(freq_eval, type="l", col="red", xlab="quantile of mean divergence[mm/day]", ylab="over all appearance",
    main=paste0(data_type, " frequencies plot of differences for period 1996-2005"))
    lines(freq_hist, col="green")
    legend(x=1300,y=NULL, legend=c("Evaluation-APGD", "Historical-APGD)"),
    col=c("red", "green"), lty=1:2)
    dev.off()
}

plotBoxplot<-function(raster_brick, filename_pattern, main_pattern, overall_mean=NULL){
  no_na<-list(layer1=NULL, layer2=NULL, layer3=NULL, layer4=NULL, layer5=NULL, layer6=NULL, layer7=NULL, layer8=NULL, layer9=NULL,layer10=NULL)
  biases<-list()
  for(i in 1:nlayers(raster_brick)){
    #no_na[[i]]<-values(raster_brick[[i]])
    #no_na[[i]]<-no_na[[i]][!is.na(no_na[[i]])]
    biases<-unlist(list(unlist(biases), (values(raster_brick[[i]]), na.rm=TRUE)))
    if(is.null(overall_mean)){
      jpeg(paste0(output_dir, filename_pattern,".jpg"), height = 500, width = 700)
      boxplot(values(raster_brick[[i]]), ylab="Mean difference from observated data [mm/day]",  main=paste0(main_pattern,". Bias = ", round(biases[[i]]),5))
    }else if(overall_mean==TRUE){
      jpeg(paste0(output_dir, filename_pattern,".jpg"), height = 500, width = 700)
      boxplot(values(raster_brick[[i]]), ylab="Mean difference from observated data [mm/day]",  main=paste0("Mean boxplot of ",main_pattern," data, mean over all years. Bias = ", round(biases[[i]]),5))
    }else{
      jpeg(paste0(output_dir, filename_pattern, i+1995, ".jpg"), height = 400, width = 500)
      boxplot(values(raster_brick[[i]]), ylab="Mean difference from observated data [mm/day]",  main=paste0("Mean boxplot of ",main_pattern," data in year: ", i+1995, ", Bias = ", round(biases[[i]]),5))
    }
      dev.off()
  }
  return(biases)
}

plotSeasonalBoxplot<-function(raster_list, filename_pattern, main_pattern){
  no_na<-list(layer1=NULL, layer2=NULL, layer3=NULL, layer4=NULL)
  biases<-list()
  for(i in 1:4){
    no_na[[i]]<-values(raster_list[[i]])
    no_na[[i]]<-no_na[[i]][!is.na(no_na[[i]])]
    biases<-unlist(list(unlist(biases), bias(no_na[[i]])))
    jpeg(paste0(output_dir, filename_pattern, names(raster_list)[[i]], ".jpg"), height = 400, width = 500)
      boxplot(no_na[[i]], ylab="Difference from observated data [mm/day]",  main=paste0("Boxplot of ",main_pattern," data in ", names(raster_list)[[i]], ", Bias = ", round(bias(no_na[[i]]),5)))
    
    dev.off()
  }
  return(biases)
}

plotBiases <- function(biases_alp3_eval, biases_alp3_hist, biases_eur11_eval, biases_eur11_hist, fn){
  #tada<-cbind(timeline=as.integer(time_list_eval), biases_alp3_eval, biases_alp3_hist, biases_eur11_eval, biases_eur11_hist)
  tada<-data.frame(timeline=as.integer(time_list_eval), biases=c(biases_alp3_eval, biases_alp3_hist, biases_eur11_eval, biases_eur11_hist), 
                   grouping=structure(c(rep(1L, 10), rep(2L,10), rep(3L, 10), rep(4L, 10)),
                   .Label=c("mean bias of alp3-evaluation data","mean bias of alp3-historical data", "mean bias of eur11-evaluation data", "mean bias of eur11-historical data"),class="factor"))
  #jpeg(paste0(output_dir, fn, ".jpg"), width = 900, height=600)
    print(paste0(output_dir, fn, ".jpg"))
    ggplot(tada) +aes(x=as.Date.yearmon(timeline), y=biases, col=grouping) + geom_line() + ylab("Mean Biases [mm/day]") +xlab("Years") + guides(col=guide_legend(title="Dataset")) + ggtitle("Yearly Mean Biases")
  #dev.off()  
}

click_plot<-function(raster){
  #quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=ncol(differences)-1, ny=nrow(differences)-1)
  X11()
  plot(raster)
  click(x=raster, n=Inf, xy=TRUE, cell=TRUE, type="o")
  dev.off()
}

justQuiltPlot<-function(ra, lon, lat)
{
  extent(ra)<-extent(lon)
  quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(ra)), nx=ncol(ra), ny=nrow(ra))
  map(add = TRUE)
}

plotDif2002 <- function(data, fn){
  molten<-melt(data, id.vars="timeline")
  jpeg(paste0(output_dir, fn, ".jpg"), height = 900, width = 1200)
    ggplot(molten) +aes(x=as.Date(timeline), y=value, col=variable) + geom_line() + ylab("Precipitation [mm/day]") +xlab("") + guides(col=guide_legend(title="Dataset")) + ggtitle("Precipitation 2002  in the area of Sout-Switzerland")
  dev.off()  
}

saveRaster<-function(raster, filename, varname, longname){
  writeRaster(raster, paste0(output_dir, filename, ".nc"), overwrite=TRUE, format="CDF",
              varname=varname, varunit="mm/day", longname=longname, xname="X", yname="Y")
}

plotAllSeasonsFreq<-function(list_freq, filename, plotmain, ylim, xlim)
{
    jpeg(paste0(output_dir, filename, ".jpg"), height = 600, width = 900)
    plot(list_freq[[1]], col="blue", type="l", xlab="Difference in the 99. Quantile[mm/day]", ylab="over all appearance",
         main= plotmain, xlim=xlim, ylim=ylim)
    lines(list_freq[[2]], col="red", type="l")
    lines(list_freq[[3]], col="orange", type="l")
    lines(list_freq[[4]], type="l", col="green")
    abline(h=seq(ylim[[1]], ylim[[2]], by=50), v=seq(xlim[[1]], xlim[[2]], by=5), col="gray", lty=3)
    legend(x=xlim[[2]]-30, y=ylim[[2]]-50, legend=c("Historical EUR-11", "Evaluation EUR-11", "Historical ALP-3", "Evaluation ALP-3"),
           col=c("blue", "red", "orange", "green"), lty=c(1))
    dev.off()
}
plotAllSeasonalBoxplot<-function(raster_list, filename, plotmain){
  no_na<-list(layer1=NULL, layer2=NULL, layer3=NULL, layer4=NULL)
  biases<-list()
  for(i in 1:4){
    no_na[[i]]<-values(raster_list[[i]])
    no_na[[i]]<-no_na[[i]][!is.na(no_na[[i]])]
    biases<-unlist(list(unlist(biases), bias(no_na[[i]])))
  }
  jpeg(paste0(output_dir, filename, ".jpg"), height = 400, width = 600)
  boxplot(no_na, ylab="Difference from observated data [mm/day]", names=c(paste0(names(raster_list)[[1]],"\nBias=",round(bias(no_na[[1]]),5)), 
          paste0(names(raster_list)[[2]],"\nBias=",round(bias(no_na[[2]]),5)), paste0(names(raster_list)[[3]],"\nBias=",round(bias(no_na[[3]]),5)), 
          paste0(names(raster_list)[[4]],"\nBias=",round(bias(no_na[[4]]),5))),main=plotmain)
  dev.off()
  
  return(biases)
}

plotData <- function(data, fn, plotmain){
  molten<-melt(data, id.vars="timeline")
  #jpeg(paste0(output_dir, fn, ".jpg"), height = 900, width = 1200)
  ggplot(molten) +aes(x=timeline, y=as.numeric(value), col=variable) + geom_line() + ylab("Niederschlag [mm/day]") +xlab("") + guides(col=guide_legend(title="Dataset")) + ggtitle(plotmain)
  #dev.off()  
}
