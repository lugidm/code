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