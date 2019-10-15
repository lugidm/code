# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 15.10.19
# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19

plotJPG <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 800, width = 1200)
    plot(rast, main=plotmain, breaks = c(0:8)*2, col=rev(heat.colors(n=8)))
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}

plotJPGSoph <- function(rast, filename, plotmain, addMap){
    jpeg(paste0(output_dir,filename), height = 800, width = 1200)
    quilt.plot(data.frame(lon=as.vector(rast$lon),lat=as.vector(rast$lat),pr=as.vector(rast$pr)), nx=412, ny=424, col=rev(heat.colors(n=8)), breaks = c(0:8)*10)
    #plot(rast, main=plotmain, breaks = c(0:8)*2, col=rev(heat.colors(n=8)))
    if(!is.null(addMap) & addMap == TRUE){
        map(add=TRUE, col='black')
    }
    dev.off()
    print(paste0("plotted ", filename))
}
