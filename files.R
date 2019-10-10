# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 09.10.19
getEUR11evalPR <- function(){

    input_file <- "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20000101-20001231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20010101-20011231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20020101-20021231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20030101-20031231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20040101-20041231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20050101-20051231.nc")
    return(input_file)
}
getEUR11evalTAS <- function(){
    input_file <- "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20000101-20001231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20010101-20011231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20020101-20021231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20030101-20031231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20040101-20041231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/tas_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_20050101-20051231.nc")
    return(input_file)
}
getEUR11histPR <- function(){
    
    input_file <- "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19860101-19861231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19870101-19871231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19880101-19881231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19890101-19891231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20000101-20001231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20010101-20011231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20020101-20021231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20030101-20031231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20040101-20041231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20050101-20051231.nc")
    return(input_file)
}
getEUR11histTAS <- function(){
    input_file <- "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19860101-19861231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19870101-19871231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19880101-19881231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19890101-19891231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20000101-20001231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20010101-20011231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20020101-20021231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20030101-20031231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20040101-20041231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20050101-20051231.nc")
    return(input_file)
}
getEUR11rcp85PR <- function(){
    input_file <- "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20900101-20901231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20910101-20911231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20920101-20921231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20930101-20931231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20940101-20941231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20950101-20951231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20960101-20961231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20970101-20971231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20980101-20981231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20990101-20991231.nc")
    return(input_file)
}
getEUR11rcp85TAS <- function(){
    input_file <- "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20900101-20901231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20910101-20911231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20920101-20921231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20930101-20931231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20940101-20941231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20950101-20951231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20960101-20961231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20970101-20971231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20980101-20981231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/rcp85/tas_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_20990101-20991231.nc")
    return(input_file)
}