# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 21.10.19
compareQ99 <- function(simulated, observated)
{
    pE <- projectExtent(simulated)
    print("projectExtent done")
    simulated <- projectRaster(from=pE, to=simulated)
    return(simulated)
}
