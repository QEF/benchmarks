#!/bin/bash 
#BSUB -q parallel
#BSUB -a openmpi
#BSUB -n 1600
#BSUB -R "span[ptile=4] order[ch]"
#BSUB -oo collect.%J.out
#BSUB -eo collect.%J.err

## caricamento moduli
. /prod/modules/tcl_3.2/init/bash
module load profile/advanced
module load openmpi/1.2.6--intel--10.1
module load acml/3.6.0--intel--10.1

#module load openmpi/1.2.5/intel/10.1
#module load openmpi/1.2.5-dbg--intel--10.1
#module load cineca-tools
#module load valgrind

ulimit -s unlimited

cd /scratch/usercin/acv0/QE_input/cnt10por8

export OPENMPI_OPTS="$OPENMPI_OPTS --mca btl_openib_ib_mtu 4"
export OPENMPI_OPTS="$OPENMPI_OPTS --mca btl_openib_use_eager_rdma 1"
export OPENMPI_OPTS="$OPENMPI_OPTS --mca btl_openib_eager_limit 1024"
export OPENMPI_OPTS="$OPENMPI_OPTS --mca btl_openib_priority 1"

export OPENMPI_OPTS="$OPENMPI_OPTS --mca mpool_rdma_rcache_size_limit 268435456"
export OPENMPI_OPTS="$OPENMPI_OPTS --mca btl_self_min_rdma_size 536870911 --mca btl_self_max_rdma_size 536870911"
export OPENMPI_OPTS="$OPENMPI_OPTS --mca mpi_paffinity_alone 1 --mca maffinity_base_verbose 1 --mca paffinity_base_verbose 1 --mca maffinity 1"

export OMP_NUM_THREADS=1

export OPENMPI_OPTS="$OPENMPI_OPTS -x OMPI_HOME=$OMPI_HOME -x LD_LIBRARY_PATH=$LD_LIBRARY_PATH -x PATH=$PATH -x OMP_NUM_THREADS=$OMP_NUM_THREADS"

touch /tmp/hostfile.${LSB_BATCH_JID}
CHECK=0

## formato <host_1> <n-cpu_1> ... <host_N> <n-cpu_N>
for i in $LSB_MCPU_HOSTS
    do
        if [ $CHECK -eq 0 ]; then
            echo $i " " >> /tmp/hostfile.${LSB_BATCH_JID}
            echo $i " " >> /tmp/hostfile.${LSB_BATCH_JID}
            CHECK=1
        else
            CHECK=0
        fi
done

echo $LSB_MCPU_HOSTS

cat /tmp/hostfile.${LSB_BATCH_JID} 

NP=`cat /tmp/hostfile.${LSB_BATCH_JID} | wc -w`

mpirun --prefix $OMPI_HOME $OPENMPI_OPTS -n $NP -hostfile /tmp/hostfile.${LSB_BATCH_JID} ./pw.x -ntg 2 -ndiag 200 -input pw.in  > pw.out
