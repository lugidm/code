load "./gsn_code.ncl" 
load "./gsn_csm.ncl" 
load "./contributed.ncl" 
load "./ESMF_regridding.ncl" 
;
; This programm generates SCRIP files in 
; NetCDF format containing grid informations
; for source grid and for destination/target 
; grid, given respective latitude and
; longitude coordinates as input.
; Author: map
; Date of last modification: 23.11.15
;
begin
;************************
; Define parameters
;************************
typeS = "curvilinear"       ; type of source grid 
                            ; options are: rectilinear (1d coords)
			    ;              curvilinear (2d coords)
			    ; Note: unstructured grids cannot be described in SCRIP file;
			    ;       ESMF format can be used instead. See details
			    ;       on NCL website www.ncl.ucar.edu
;
infileS = "../../Lukas_Moser/ALP-3/eval/t2m_2005.nc"    ; name of the input file containing latitude and longitude of source grid
outfileS = "ALP-3_temp.nc"  ; name of the output SCRIP file for source grid 
print("Read file infileS "+infileS)
fS   = addfile (infileS, "r")   ; open input file
latS = fS->lat            ; read latitude coordinate             
lonS = fS->lon            ; read longitude coordinate
; 
; Define options
OptS                      = True
OptS@ForceOverwrite       = True            ; if set to True, overwrite existing output file
OptS@PrintTimings         = True            ; if set to True, print out the computing time
;
; Write the description of the source grid to a SCRIP file:
if (typeS .eq. "rectilinear") then
   rectilinear_to_SCRIP(outfileS,latS,lonS,OptS)
   else if (typeS .eq. "curvilinear") then
      curvilinear_to_SCRIP(outfileS,latS,lonS,OptS)
      else
         print("  Problem with typeS definition; programm will exit now")
         exit
   end if
end if
;
print("Succesfully write "+outfileS)
;
end
