# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 07.10.19
plotJPG <- function(rast, filename, plotmain){

    bitmap(filename, height = 4, width = 4, units = 'in', type="jpeg", res=500)
    plot(rast, main=plotmain)
    dev.off()
}