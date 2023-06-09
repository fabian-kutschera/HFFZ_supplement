#Fabian Kutschera 20.12.2020

module load intel/2019 mpi.intel/2020
export Mylibs=/import/freenas-m-05-seissol/SamoaRelated/myLibs
export HDF5_BASE=/import/freenas-m-05-seissol/SamoaRelated/samoa/build/intel/parallel/
export LD_LIBRARY_PATH=$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$Mylibs/installDir/lib:$LD_LIBRARY_PATH

#INPUT
#wrong format because .h5 instead of posix (.bin) --> conversion first with conversion_h5_to_bin.sh 
#input=/import/freenas-m-05-seissol/bo/CHEESE/forFabian/middle_M7.333/HFFtest-surface.xdmf

#DR West:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/west_M7.343_simple/west_M7.343/HFFtest_resampled-surface.xdmf 
#DR Middle:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/middle_M7.333_simple/middle_M7.333/HFFtest_resampled-surface.xdmf 
#DR East:
#input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/surface_output_Iceland/east_M7.341_simple/east_M7.341/HFFtest_resampled-surface.xdmf 
#Complex MIDDLE
input=/import/freenas-m-05-seissol/kutschera/HIWI/SeisSol/complex_fault_geometry/Complex_Middle_M7.07/HFFtest_resampled-surface.xdmf


#OUTPUT
#DR West: 
#output=tanioka_simple_west_M7.341.nc
#DR Middle:
#output=tanioka_simple_middle_M7.333.nc
#DR East: 
#output=tanioka_simple_east_M7.343.nc
#Complex MIDDLE
output=tanioka_complex_middle_M7.07.nc


#BATHYMETRY
bathy=/import/freenas-m-05-seissol/kutschera/HIWI/BathymetryNorthIceland.grd
#bathy=/import/freenas-m-05-seissol/kutschera/HIWI/BathymetryNorthIceland_test.grd


export HDF5_BASE=/import/freenas-m-05-seissol/SamoaRelated/samoa/build/intel/parallel/
export LD_LIBRARY_PATH=$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$Mylibs/installDir/lib:$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$LD_LIBRARY_PATH

#dx=100
dx=125
#use only with posix format (.bin)
/import/freenas-m-05-seissol/SamoaRelated/displacement-converter/converter_Tanioka -i $input -o $output -b $bathy --dx $dx --dy $dx -x525000 -w205000 -y7248000 -z182000 --dt 5

