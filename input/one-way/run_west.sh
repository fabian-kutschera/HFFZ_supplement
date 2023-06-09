module load intel/2019 mpi.intel/2020
export Mylibs=/import/freenas-m-05-seissol/SamoaRelated/myLibs
export HDF5_BASE=/import/freenas-m-05-seissol/SamoaRelated/samoa/build/intel/parallel/
export LD_LIBRARY_PATH=$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$Mylibs/installDir/lib:$LD_LIBRARY_PATH


#DR West 100 sec:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/west_M7.343_simple/west_M7.343/HFFtest_resampled-surface.xdmf 
#DR West 200 sec:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/west_M7.343_simple_200sec/HFFtest_resampled-surface.xdmf 
#DR Middle:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/middle_M7.333_simple/middle_M7.333/HFFtest_resampled-surface.xdmf 
#DR East:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/east_M7.341_simple/east_M7.341/HFFtest_resampled-surface.xdmf 
#Complex WEST
input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/complex_fault_geometry/Complex_West_M6.74/HFFtest_resampled-surface.xdmf


#OUTPUT
#DR West: 
#output=tanioka_simple_west_M7.341_200sec.nc
#DR Middle:
#output=tanioka_simple_middle_M7.333.nc
#DR East: 
#output=tanioka_simple_east_M7.343.nc
#Complex WEST
output=tanioka_complex_west_M6.74.nc


#BATHYMETRY
bathy=/import/freenas-m-05-seissol/kutschera/HIWI/BathymetryNorthIceland.grd


export HDF5_BASE=/import/freenas-m-05-seissol/SamoaRelated/samoa/build/intel/parallel/
export LD_LIBRARY_PATH=$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$Mylibs/installDir/lib:$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$LD_LIBRARY_PATH

#dx=100
dx=125
#use only with posix format (.bin)
/import/freenas-m-05-seissol/SamoaRelated/displacement-converter/converter_Tanioka -i $input -o $output -b $bathy --dx $dx --dy $dx -x525000 -w205000 -y7248000 -z182000 --dt 5

