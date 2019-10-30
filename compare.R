# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 21.10.19



compareSUB <- function(simulated, observated)
{
    obs_without_lon <- dropLayer(observated, c(nlayers(observated)-1, nlayers(observated)))
    obs_without_lon <- dropLayer(obs_without_lon, 1)
    sim_without_lon <- dropLayer(simulated, c(nlayers(simulated)-1, nlayers(simulated)))
    dif<- overlay( sim_without_lon, obs_without_lon,fun=function(x,y){return((x - y))})
    f<-freq(dif, digits = 1, cum = TRUE, valid=TRUE, total=TRUE, useNA="no")

    plotDifferences(frequencies=f, raster=dif, lon=subset(simulated, nlayers(simulated)-1), lat=subset(simulated, nlayers(simulated)),
    "dif_mprs_eval-obs.jpg", "Difference of mean percipitation (observated-eval)[mm/day]", addMap=TRUE)

}
