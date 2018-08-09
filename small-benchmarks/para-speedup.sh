#!/bin/bash --noprofile
################################################################################
##                    Copyright (C) 2004 Carlo Sbraccia.                      ##
##                 This file is distributed under the terms                   ##
##                 of the GNU General Public License.                         ##
##                 See http://www.gnu.org/copyleft/gpl.txt .                  ##
##                                                                            ##
##    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,         ##
##    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF      ##
##    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                   ##
##    NONINFRINGEMENT.  IN NO EVENT SHALL CARLO SBRACCIA BE LIABLE FOR ANY    ##
##    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,    ##
##    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE       ##
##    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                  ##
################################################################################
#
# ... architecture to be tested
#
ARCH=""
#
# ... path to the pw.x executable
#
EXE=""
#
# ... path to the scratch directory
#
SCRATCH_DIR="/scratch/"
#
# ... MPI command used to run the job. Examples: 
#
# ...  1) mpi_cmd="mpirun -np"
# ...  2) mpi_cmd="mpiexec -n"
# ...  3) mpi_cmd="poe"
#
mpi_cmd=""
#
# ... min and max number of CPUs used for the benchmark
#
ncpu_min=2
ncpu_max=16
#
# ... increment
#
increment=2
#
# ... the list of CPUs can also be given here (in this case the three 
# ... variables above will be ignored)
#
list_of_cpus=""
#
################################################################################
################################################################################
######             DO NOT MODIFY THE SCRIPT UNDER THESE LINES             ######
################################################################################
################################################################################
#
if [ ${ncpu_max} -gt 128 ]; then
   #
   printf "\n ncpu_max = ${ncpu_max}  (must be less than 128):"
   printf "  ncpu_max set to 128 \n\n"
   #
   ncpu_max=128
   #
fi
if [ ${ncpu_min} -gt ${ncpu_max} ]; then
   #
   printf "\n ERROR: ncpu_min < ncpu_max\n"; exit
   #
elif [ ${ncpu_min} -lt 0 ]; then
   #
   printf "\n ERROR: ncpu_min < 0\n"; exit
   #
fi
#
PSEUDO_DIR="$PWD/pseudopotentials.d"
#
if [[ ${list_of_cpus} == "" ]]; then
   #
   list_of_cpus=$( seq ${ncpu_min} ${increment} ${ncpu_max} )
   #
fi
#
printf "\n bechmarking MPI-PWscf on $ARCH using  "
echo ${list_of_cpus} " CPUs"
#
# ... first the input file is written
#
cat > large-test.in << EOF
&CONTROL
  outdir      = "$SCRATCH_DIR",
  pseudo_dir  = "$PSEUDO_DIR",
/
&SYSTEM
  ibrav       = 6,
  celldm(1)   = 18.862D0,
  celldm(3)   = 1.0125D0,
  nat         = 95,
  ntyp        = 2,
  ecutwfc     = 35.D0,
  ecutrho     = 400.D0,
  tot_charge  = 2,
  occupations = "smearing",
  smearing    = "m-p",
  degauss     = 0.02D0,
/
&ELECTRONS
  conv_thr         = 1.D-8,
  mixing_beta      = 0.4D0,
  diago_david_ndim = 3,
/
ATOMIC_SPECIES
O   15.999 O.vdb.UPF
Zr  91.224 Zr.vdb.UPF
ATOMIC_POSITIONS
O       0.125773159    0.125773159    0.104156164
O       0.126750357    0.126750357    0.359129139
O       0.120591035    0.376245832    0.138023835
O       0.376245832    0.120591035    0.138023835
O       0.150262866    0.382649341    0.390818365
O       0.382649341    0.150262866    0.390818365
O       0.374996125    0.374996125    0.124185015
Zr      0.000612655    0.000612655   -0.005751244
Zr     -0.000628808    0.247570077    0.246340868
Zr      0.247570077   -0.000628808    0.246340868
Zr      0.250474512    0.250474512   -0.004062341
O       0.625578479    0.124421921    0.100277109
O       0.630711659    0.119286087    0.353548454
O       0.629400194    0.373754706    0.138024894
O       0.875850411    0.124855180    0.140884972
O       0.599732982    0.367345973    0.390819736
O       0.877045779    0.126367141    0.394385811
O       0.874995036    0.375005779    0.100289514
O       0.874995360    0.374997301    0.353660411
Zr      0.496992170   -0.000616018   -0.008236449
Zr      0.512569122    0.237428520    0.236775183
Zr      0.752691814   -0.002688371    0.246191095
Zr      0.750615376    0.253008645   -0.008236940
O       0.124421921    0.625578479    0.100277109
O       0.119286087    0.630711659    0.353548454
O       0.124855180    0.875850411    0.140884972
O       0.373754706    0.629400194    0.138024894
O       0.126367141    0.877045779    0.394385811
O       0.367345973    0.599732982    0.390819736
O       0.375005779    0.874995036    0.100289514
O       0.374997301    0.874995360    0.353660411
Zr     -0.000616018    0.496992170   -0.008236449
Zr     -0.002688371    0.752691814    0.246191095
Zr      0.237428520    0.512569122    0.236775183
Zr      0.253008645    0.750615376   -0.008236940
O       0.117884435    0.117884435    0.614354071
O       0.126069055    0.126069055    0.864018630
O       0.124099418    0.368979378    0.647565656
O       0.368979378    0.124099418    0.647565656
O       0.126482390    0.375125238    0.899728723
O       0.375125238    0.126482390    0.899728723
O       0.375000951    0.375000951    0.593148822
O       0.374997145    0.374997145    0.863141532
Zr     -0.002539837   -0.002539837    0.499407769
Zr     -0.003201395    0.246975842    0.755124067
Zr      0.246975842   -0.003201395    0.755124067
Zr      0.240704574    0.240704574    0.511492014
O       0.132784953    0.617216670    0.604991051
O       0.125707105    0.624300377    0.858705885
O       0.127805173    0.867401069    0.645972832
O       0.381021601    0.625906817    0.647563983
O       0.124853419    0.875495228    0.900313336
O       0.374877404    0.623514622    0.899728498
O       0.374996064    0.875003084    0.604972655
O       0.374998620    0.874997623    0.860749908
Zr      0.003035758    0.498755513    0.499877266
Zr      0.000142706    0.749856693    0.755068667
Zr      0.250044786    0.499958505    0.751725045
Zr      0.251245380    0.746965185    0.499875748
O       0.617216670    0.132784953    0.604991051
O       0.624300377    0.125707105    0.858705885
O       0.625906817    0.381021601    0.647563983
O       0.867401069    0.127805173    0.645972832
O       0.623514622    0.374877404    0.899728498
O       0.875495228    0.124853419    0.900313336
O       0.875003084    0.374996064    0.604972655
O       0.874997623    0.374998620    0.860749908
Zr      0.498755513    0.003035758    0.499877266
Zr      0.499958505    0.250044786    0.751725045
Zr      0.749856693    0.000142706    0.755068667
Zr      0.746965185    0.251245380    0.499875748
O       0.624227310    0.624227310    0.104153807
O       0.623248856    0.623248856    0.359128804
O       0.625156988    0.874144577    0.140886290
O       0.874144577    0.625156988    0.140886290
O       0.623630068    0.872954337    0.394385672
O       0.872954337    0.623630068    0.394385672
O       0.875003741    0.875003741    0.100670052
O       0.874997882    0.874997882    0.355700396
Zr      0.499523586    0.499523586   -0.004057943
Zr      0.502431262    0.750629301    0.246337395
Zr      0.750629301    0.502431262    0.246337395
Zr      0.749391052    0.749391052   -0.005749174
O       0.632117549    0.632117549    0.614355011
O       0.623937346    0.623937346    0.864019975
O       0.622189105    0.882600474    0.645973009
O       0.882600474    0.622189105    0.645973009
O       0.625148824    0.874507899    0.900313581
O       0.874507899    0.625148824    0.900313581
O       0.874997550    0.874997550    0.609292757
O       0.874998968    0.874998968    0.860732671
Zr      0.509296679    0.509296679    0.511490822
Zr      0.503026576    0.753201014    0.755126269
Zr      0.753201014    0.503026576    0.755126269
Zr      0.752538644    0.752538644    0.499403990
K_POINTS automatic
2 2 2  1 1 1
EOF
#
# ... the benchmark starts here
#
for i in ${list_of_cpus}; do
   #
   printf " working on ${i} cpus ..."
   #
   ${mpi_cmd} ${i} $EXE -in $PWD/large-test.in &> $PWD/large-test_${i}.out
   #
   printf " done\n"
   #
done
#
# ... end of tests
#
# ... output files are parsed here (the bench score is also computed here)
#
printf "\n %s      %s    %s     %s\n\n" "test" "cpu-time" "I/O-time" "speed-up"
#
first=".TRUE."
#
for i in ${list_of_cpus}; do
   #
   file=large-test_${i}.out
   #
   check=$( grep "convergence has been achieved" ${file} | awk '{print $4}' )
   #
   if [[ "${check}" !=  "achieved" ]]; then
      #
      echo "large-test_${i} :  convergence has NOT been achieved"; exit
      #
   fi
   #
   tcpu=$( grep "electrons" ${file} | grep CPU | awk '{print $3}'  )
   tio=$(  grep "davcio"    ${file}            | awk '{print $3}'  )
   #
   printf "    %i    %10s  %10s" ${i} ${tcpu} ${tio}
   #
   tcpu=$( echo ${tcpu} | awk -F s '{print $1}' )
   #
   if [ "${first}" == ".TRUE." ]; then
      #
      ref_time=${tcpu}
      #
      first=".FALSE."
      #
   fi
   #
   printf "   %10.5f\n" $( echo "(${ref_time}/${tcpu})" | bc -l )
   #
done
#
# ... end of the script
#
