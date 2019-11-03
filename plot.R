# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19


plotJPGmean <- function(raster, lon, lat, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    if(ALP3==TRUE)
    {
        quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=240, ny=424,
        col=rev(heat.colors(9)), main=plotmain, na.rm=TRUE)
    }else{
        quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=412, ny=424,
        col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
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
    plot(rast, main=plotmain, breaks= c(0:9)*1.8, col=rev(heat.colors(n=9)))
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
        jpeg(paste0(output_dir,toString(i+1995),filename), height = 400, width = 650)
        if(ALP3==TRUE)
        {
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster)), nx=240, ny=424,
            col=rev(heat.colors(9)), main=paste0(plotmain, "in", toString(i+1995)), na.rm=TRUE)
        }else{
            if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster[[i]])), nx=412, ny=424,
            col=rev(heat.colors(9)), main=paste0(plotmain, "in", toString(i+1995)))#breaks = c(0.0:9.0)*2, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
            }else{
                quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(raster[[i]])), nx=412, ny=424,
                col=rev(heat.colors(9)), main=paste0(plotmain, "in", toString(i+1994)))
            }
        }
        #quilt.plot(data.frame(lon=as.vector(subset(raster, 'longitude')),lat=as.vector(subset(raster,'latitude')),pr=as.vector(subset(raster, 1))), nx=412, ny=424,
        #col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
        if(!is.null(addMap) & addMap == TRUE){
            map(add=TRUE, col='black')
        }
        dev.off()
        if(EVAL){
            jpeg(paste0(output_dir,toString(i+1995),"frequencies", filename), height = 400, width = 650)
            plot(frequencies[[i]], type="l", col="black", xlab="divergence", ylab="over all appearance",
            main=paste0("Frequency plot in ", toString(i+1995)))
            axis(1, seq(round(min(frequencies[[i]][,1])), round(max(frequencies[[i]][,1])), by = 1.0))
            abline(h=seq(round(min(frequencies[[i]][,2])), round(max(frequencies[[i]][,2])), by=500), v=seq(round(min(frequencies[[i]][,1])),
            round(max(frequencies[[i]][,1]))), col="gray", lty=3)
            print(paste0("plotted ", i+1995))
        }else{
            jpeg(paste0(output_dir,toString(i+1994),"frequencies", filename), height = 400, width = 650)
            plot(frequencies[[i]] , type="l", col="black", xlab="divergence", ylab="over all appearance",
            main=paste0("Frequency plot in ", toString(i+1994)))
            axis(1, seq(round(min(frequencies[[i]][,1])), round(max(frequencies[[i]][,1])), by = 1.0))
            abline(h=seq(round(min(frequencies[[i]][,2])), round(max(frequencies[[i]][,2])), by=500), v=seq(round(min(frequencies[[i]][,1])),
            round(max(frequencies[[i]][,1]))), col="gray", lty=3)
            print(paste0("plotted ", i+1994))

        }
        dev.off()

    }
}

plotMeanDifferences <- function(differences, frequencies, lon, lat, filename, EVAL)
{
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    if(ALP3==TRUE)
    {
        quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=240, ny=424,
        col=rev(heat.colors(9)), main="Mean differnces between ssssssssssssssssssssssssssssssssss", na.rm=TRUE)
    }else{
        if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=412, ny=424,
            col=rev(heat.colors(9)), main="Mean difference in evaluation-observated differences for period 1996-2005")
        }else{
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=412, ny=424,
            col=rev(heat.colors(9)), main="Mean difference in historical-observated differences for period 1995-2005")
        }
    }
    map(add=TRUE, col='black')
    print("plotted raster")
    dev.off()

    if(EVAL){
        jpeg(paste0(output_dir, "frequencies", filename), height = 600, width = 900)
        plot(frequencies, type="l", col="black", xlab="mean divergence", ylab="over all mean-appearance",
        main="Mean frequencies plot in evaluation-observated differences for period 1996-2005"
        ,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 26))
        #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
        abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
        round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
    }else{
        jpeg(paste0(output_dir,"frequencies", filename), height = 600, width = 900)
        plot(frequencies, type="l", col="black", xlab="mean divergence", ylab="over all mean-appearance",
        main="Mean frequencies plot in historical-observated differences for period 1995-2005"
        ,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 28))
        #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
        abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
        round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
    }
    print("plotted frequencies")
    dev.off()
}

plotQ90Q99Differences <- function(differences, frequencies, lon, lat, filename, plotmain, EVAL)
{
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    if(ALP3==TRUE)
    {
        quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=240, ny=424,
        col=rev(heat.colors(9)), main="Mean differnces between ssssssssssssssssssssssssssssssssss", na.rm=TRUE)
    }else{
        if(EVAL){
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=412, ny=424,
            col=rev(heat.colors(9)), main=paste0(plotmain, " in evaluation-observated differences for period 1996-2005"))
        }else{
            quilt.plot(data.frame(lon=as.vector(lon),lat=as.vector(lat),pr=as.vector(differences)), nx=412, ny=424,
            col=rev(heat.colors(9)), main=paste0(plotmain, " in historical-observated differences for period 1995-2005"))
        }
    }
    map(add=TRUE, col='black')
    print("plotted raster")
    dev.off()

    if(EVAL){
        jpeg(paste0(output_dir, "frequencies", filename), height = 600, width = 900)
        plot(frequencies, type="l", col="black", xlab="quantile", ylab="over all mean-appearance",
        main=paste0(plotmain, " frequencies plot in evaluation-observated differences for period 1996-2005"))
        #,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 26))
        #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
        abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
        round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
    }else{
        jpeg(paste0(output_dir,"frequencies", filename), height = 600, width = 900)
        plot(frequencies, type="l", col="black", xlab="quantile", ylab="over all mean-appearance",
        main=paste0(plotmain, " frequencies plot in historical-observated differences for period 1995-2005"))
        #,xaxp=c(round(min(frequencies[,1])), round(max(frequencies[,1])), 28))
        #axis(1, seq(round(min(frequencies[,1])), round(max(frequencies[,1])), by = 0.5))
        abline(h=seq(round(min(frequencies[,2])), round(max(frequencies[,2])), by=500), v=seq(round(min(frequencies[,1])),
        round(max(frequencies[,1])), by=0.5), col="gray", lty=3)
    }
    print("plotted frequencies")
    dev.off()
}
