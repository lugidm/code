getMonthlyList<-function(inputfile, start_month, end_month){
  return_value<-list()
  list_index<-1
  for(i in start_month:end_month){
    return_value[[list_index]]<-stack(paste0(output_dir, inputfile, toString(i), ".nc"))
    list_index<-list_index+1
  }
  return(return_value)
}