module load intel/2019 mpi.intel/2020
export Mylibs=/import/freenas-m-05-seissol/SamoaRelated/myLibs
export HDF5_BASE=/import/freenas-m-05-seissol/SamoaRelated/samoa/build/intel/parallel/
export LD_LIBRARY_PATH=$NETCDF_BASE/lib/:$HDF5_BASE/lib/:$Mylibs/installDir/lib:$LD_LIBRARY_PATH


ulimit -s unlimited

export OMP_NUM_THREADS=30
export MP_PE_AFFINITY=yes
export MP_TASK_AFFINITY=core:30


#minimal and maximal resolution: (1/2)^(dm/2) * width of the domain
#minimal resolution: (1/2)^(dmin/2) * width of the domain
#maximal resolution: (1/2)^(dmax/2) * width of the domain

#Large domain
#dmin=14
#dmax=20
#dcoast=20
#domain='525000 7248000 730000 7453000'
#Small domain
dmin=14
dmax=18
dcoast=22
#old domain='555000 7248000 706000 7399100'
domain='536500 7248000 718500 7430000'


# Initial Displacement height [m]
displacement_height=0.1
# Initial Displacement resolution [m]
displacement_resolution=100
# Bathymetry Refinement [m]
refined_bathymetry=500
# Dry Tolerance
dry_tolerance=$(echo "scale=16; 0.01/9.80616" | bc -l)
#dry_tolerance=$(echo "scale=16; 0.001/9.80616" | bc -l)

#Chose corresponding displacement file
#DR West: 
disp="tanioka_simple_west_M7.341.nc"
#DR Middle: 
#disp="tanioka_simple_middle_M7.333.nc"
#DR East: 
#disp="tanioka_simple_east_M7.343.nc"
#Complex WEST
#disp="tanioka_complex_west_M6.74.nc"



#Bathymetry file
bathy="/import/freenas-m-05-seissol/kutschera/HIWI/BathymetryNorthIceland.grd"


#output directory - adjust accordingly
#outdir="outputSamoa_tanioka_simple_west_M7.34_points"
outdir="outputSamoa_tanioka_simple_west_M7.34_filtered_Husavik"
#outdir="outputSamoa_tanioka_simple_west_M7.341_200sec_test"
#outdir="outputSamoa_tanioka_simple_east_M7.343"
#outdir="outputSamoa_tanioka_complex_west_M6.74_points"


rm -rf $outdir
mkdir $outdir

cp samoa_west.sh "$outdir/$outdir.txt"


#tmax: end time of the simulation in [s], 3600 was chosen for HFF
#tout: output interval, here all 10 seconds
#courant: if the scheme diverges (Can happen caus we're nonlinear) decrease
#domain: considered domain, is already adjusted to the HFF
#if you want the wavefield add the argument -xmlpointoutput
#module unload mpi.ibm


#Chose point input file (only required for point-wise output)
#points="husavik_ssh.txt"
#points="dalvik_ssh.txt"
#points="akureyri_ssh.txt
#points="/import/freenas-m-05-seissol/kutschera/HIWI/samoa/points/points_EGU.txt"


#Chose of of the following 2 output possibilities:

#point-wise output:
#/import/freenas-m-05-seissol/SamoaRelated/samoa/bin/samoa_flash -fbath $bathy -fdispl $disp -tmax 2400 -dmin $dmin -dmax $dmax -tout 10 -max_displacement $displacement_height -displacement_resolution $displacement_resolution -refined_bathymetry $refined_bathymetry -output_dir $outdir -drytolerance $dry_tolerance -sections 1 -courant 0.5 -domain $domain -stestpoints_file $points

#XDMF-paraview output: without -dcoast $dcoast
/import/freenas-m-05-seissol/SamoaRelated/samoa/bin/samoa_flash -fbath $bathy -fdispl $disp -tmax 2400 -dmin $dmin -dmax $dmax -dcoast $dcoast -tout 10 -max_displacement $displacement_height -displacement_resolution $displacement_resolution -refined_bathymetry $refined_bathymetry -output_dir $outdir -drytolerance $dry_tolerance -sections 1 -courant 0.5 -domain $domain -xdmfoutput -xdmffilterindex 1 -xdmffilterparams 652000 666000 7320000 7335000
# Husavik: -xdmffilterindex 1 -xdmffilterparams 652000 665500 7320000 7332000



echo "Done."



