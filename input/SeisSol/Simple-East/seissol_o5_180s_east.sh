#!/bin/bash
#SBATCH -J HFFZ_fullycp_180s_o5_II
#Output and error (also --output, --error):
#SBATCH -o /hppfs/scratch/09/ru64lev2/HFFZ_fullycp_o5_180s_II/%x.%j.out
#SBATCH -e /hppfs/scratch/09/ru64lev2/HFFZ_fullycp_o5_180s_II/%x.%j.out

#Initial working directory:
#SBATCH --chdir=./

#Notification and type
#SBATCH --mail-type=END
#SBATCH --mail-user=f.kutschera@campus.lmu.de

# Wall clock limit:
#SBATCH --time=40:00:00
#SBATCH --no-requeue

#Setup of execution environment
#SBATCH --export=ALL
#SBATCH --account=pn68fi
#constraints are optional
#--constraint="scratch&work"
#SBATCH --partition=general

#SBATCH --ear=off

#Number of nodes and MPI tasks per node:
#SBATCH --nodes=40
#SBATCH --ntasks-per-node=1
module load slurm_setup
#Run the program:
export MP_SINGLE_THREAD=no
unset KMP_AFFINITY
export OMP_NUM_THREADS=94
export OMP_PLACES="cores(47)"

export XDMFWRITER_ALIGNMENT=8388608
export XDMFWRITER_BLOCK_SIZE=8388608
export SC_CHECKPOINT_ALIGNMENT=8388608

export SEISSOL_CHECKPOINT_ALIGNMENT=8388608
export SEISSOL_CHECKPOINT_DIRECT=1
export ASYNC_MODE=THREAD
export ASYNC_BUFFER_ALIGNMENT=8388608
source /etc/profile.d/modules.sh

echo 'num_nodes:' $SLURM_JOB_NUM_NODES 'ntasks:' $SLURM_NTASKS 'cpu_per_task:' $SLURM_CPUS_PER_TASK
ulimit -Ss 2097152
#mpiexec -n $SLURM_NTASKS /hppfs/work/pr63qo/ru64lev2/SeisSol/build-release/SeisSol_Release_dskx_5_elastic /hppfs/work/pr63qo/ru64lev2/HFFZ/fully-coupled/parameters_o5_180s.par
mpiexec -n $SLURM_NTASKS /hppfs/work/pn68fi/ru64lev2/SeisSol/build-release/SeisSol_Release_dskx_5_elastic /hppfs/work/pr63qo/ru64lev2/HFFZ/fully-coupled/parameters_o5_180s.par
