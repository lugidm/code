# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19


plotJPGmean <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    quilt.plot(data.frame(lon=as.vector(subset(rast, varname[[1]])),lat=as.vector(subset(rast,varname[[2]])),pr=as.vector(subset(rast, 1))), nx=412, ny=424,
    col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
    #quilt.plot(data.frame(lon=as.vector(subset(rast, 'longitude')),lat=as.vector(subset(rast,'latitude')),pr=as.vector(subset(rast, 1))), nx=412, ny=424,
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

plotJPGq90 <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    quilt.plot(data.frame(lon=as.vector(subset(rast, varname[[1]])),lat=as.vector(subset(rast,varname[[2]])),pr=as.vector(subset(rast, 1))), nx=412, ny=424,
    col=rev(heat.colors(9)), breaks = c(0.0:9.0)*5, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*5)
    #quilt.plot(data.frame(lon=as.vector(subset(rast, 'longitude.coordinate')),lat=as.vector(subset(rast,'latitude.coordinate')),pr=as.vector(subset(rast, 1))), nx=412, ny=424,
    #col=rev(heat.colors(9)), breaks = c(0.0:9.0)*1.8, main=plotmain, na.rm=TRUE, lab.breaks=c(0.0:9.0)*1.8)
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}
plotJPGq99 <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 600, width = 900)
    quilt.plot(data.frame(lon=as.vector(subset(rast, varname[[1]])),lat=as.vector(subset(rast,varname[[2]])),pr=as.vector(subset(rast, 1))), nx=412, ny=424,
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