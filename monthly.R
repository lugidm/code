getMonthlyList<-function(inputfile, start_month, end_month){
  return_value<-list()
  list_index<-1
  for(i in start_month:end_month){
    return_value[[list_index]]<-stack(paste0(output_dir, inputfile, toString(i), ".nc"))
    list_index<-list_index+1
  }
  return(return_value)
}

drawRectangle<-function(dyed_hist, dyed_eval, q90_spring_extent, q90_summer_extent, q90_autumn_extent, q90_winter_extent){
  overall<-dyed_hist
  overall<-overlay(overall, dyed_eval, fun=function(x,y){y})
  extents<-list(q90_spring_extent, q90_summer_extent, q90_autumn_extent, q90_winter_extent)
  cols<-c(5, 8, 10, 12)
  colsi<-1
  for(extenti in extents){
    for(e in 1:2){
      for(x in xmin(extenti[[e]]):xmax(extenti[[e]]))
      {
        overall[cellFromXY(overall,cbind(x,ymin(extenti[[e]])))]<-cols[[colsi]]
        overall[cellFromXY(overall,cbind(x,ymax(extenti[[e]])))]<-cols[[colsi]]
      }
      for(y in ymin(extenti[[e]]):ymax(extenti[[e]])){
        overall[cellFromXY(overall, cbind(xmin(extenti[[e]]), y))]<-cols[[colsi]]
        overall[cellFromXY(overall, cbind(xmax(extenti[[e]]), y))]<-cols[[colsi]]
      }
    }
    colsi<-colsi+1
  }
  return(overall)
}
