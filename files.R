# Title     : TODO
# Objective : TODO
# Created by: lugi
# Created on: 09.10.19
getEUR11evalPR <- function(){

    input_file <- "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19970101-19971231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19980101-19981231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/eval/pr_EUR-11_ECMWF-ERAINT_evaluation_r1i1p1_CLMcom-CCLM4-8-17_v1_day_19990101-19991231.nc")
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
    
    input_file <- "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19950101-19951231.nc"
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19960101-19961231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19970101-19971231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19980101-19981231.nc")
    input_file <- c(input_file, "../Lukas_Moser/EUR-11/historical/pr_EUR-11_MPI-ESM-LR_historical_r2i1p1_CLMcom-CCLM4-8-17_v1_day_19990101-19991231.nc")
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
#####################################################################
###############   ALP-3 files########################################
getALP3evalPR <- function(){
    input_file <- "../Lukas_Moser/ALP-3/eval/tot_prec_1996.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_1997.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_1998.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_1999.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_2000.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_2001.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_2002.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_2003.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_2004.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/tot_prec_2005.nc")
    return(input_file)
}
getALP3evalTAS <- function(){
    input_file <- "../Lukas_Moser/ALP-3/eval/t2m_1996.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_1997.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_1998.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_1999.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_2000.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_2001.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_2002.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_2003.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_2004.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/eval/t2m_2005.nc")
    return(input_file)
}

getALP3histPR <- function(){
    input_file <- "../Lukas_Moser/ALP-3/historical/tot_prec_1996.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_1997.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_1998.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_1999.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_2000.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_2001.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_2002.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_2003.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_2004.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/tot_prec_2005.nc")
        return(input_file)
}
getALP3histTAS <- function(){
    input_file <- "../Lukas_Moser/ALP-3/historical/t2m_1996.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_1997.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_1998.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_1999.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_2000.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_2001.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_2002.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_2003.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_2004.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/historical/t2m_2005.nc")
    return(input_file)
}


getALP3rcp85PR <- function(){
    input_file <- "../Lukas_Moser/ALP-3/rcp85/tot_prec_2090.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2091.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2092.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2093.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2094.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2095.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2096.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2097.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2098.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/tot_prec_2099.nc")
        return(input_file)
}
getALP3rcp85TAS <- function(){
    input_file <- "../Lukas_Moser/ALP-3/rcp85/t2m_2090.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2091.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2092.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2093.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2094.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2095.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2096.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2097.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2098.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3/rcp85/t2m_2099.nc")
    return(input_file)
}
########################################################################################################################
################################### REGRIDDED ##########################################################################
########################################################################################################################


getALP3regriddedrcp85PR <- function(){
    input_file <- "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2090.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2091.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2092.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2093.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2094.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2095.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2096.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2097.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2098.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/rcp85/tot_prec_2099.nc")
    return(input_file)
}

getALP3regriddedhistPR <- function(){
    input_file <- "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_1996.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_1997.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_1998.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_1999.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_2000.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_2001.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_2002.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_2003.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_2004.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/historical/tot_prec_2005.nc")
    return(input_file)
}

getALP3regriddedevalPR <- function(){
    input_file <- "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_1996.nc"
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_1997.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_1998.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_1999.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_2000.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_2001.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_2002.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_2003.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_2004.nc")
    input_file <- c(input_file, "../Lukas_Moser/ALP-3-regridded/eval/tot_prec_2005.nc")
    return(input_file)
}

getAPGD <- function(){
    input_file<-"../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960100.nc"
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19960900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19961000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19961100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19961200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19970900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19971000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19971100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19971200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19980900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19981000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19981100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19981200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19990900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19991000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19991100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_19991200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20000900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20001000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20001100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_1991_2000/RapdD_al05.etrs.laea_20001200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20010900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20011000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20011100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20011200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20020900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20021000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20021100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20021200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20030900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20031000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20031100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20031200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20040900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20041000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20041100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20041200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050200.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050300.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050400.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050500.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050600.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050700.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050800.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20050900.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20051000.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20051100.nc"))
    input_file<-(c(input_file, "../EURO4M-APGD/RapdD_al05.etrs.laea_2001_2008/RapdD_al05.etrs.laea_20051200.nc"))
    return(input_file)
}