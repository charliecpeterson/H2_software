### NWChem_submit.sh START ###
#!/bin/bash
#$ -cwd
# error = Merged with joblog
#$ -o joblog.$JOB_ID
#$ -j y
# Edit the line below to request the appropriate runtime and memory
# (or to add any other resource) as needed:
#$ -l h_rt=1:00:00,h_data=5G
# Add multiple cores/nodes as needed:
#$ -pe node 24
#$ -q *@n1825,*@n1826,*@n1827,*@n1828,*@n1829,*@n1830,*@n1831,*@n1832,*@n1833,*@n1834,*@n1835,*@n1836,*@n1837,*@n1838,*@n1839,*@n1840,*@n1841,*@n1842,*@n1843,*@n1844,*@n1845,*@n1845,*@n1846,*@n1847,*@n1848,*@n1849,*@n1850,*@n1851,*@n1852,*@n1853,*@n1854,*@n1855,*@n1856,*@n1857,*@n1858,*@n1859,*@n1860,*@n1861,*@n1862,*@n1863,*@n1864,*@n1865,*@n1866,*@n1867,*@n1868,*@n1869,*@n1870,*@n1871,*@n1872
# Email address to notify
#$ -M $USER@mail
# Notify when
#$ -m bea


cat $PE_HOSTFILE

# echo job info on joblog:
echo "Job $JOB_ID started on:   " `hostname -s`
echo "Job $JOB_ID started on:   " `date `
echo " "

# echo job file on joblog:
input=`echo $JOB_NAME | sed 's/\(.*\)\.[^\.]*/\1/'`
if [ ! -f ${input}.nw ]; then
    echo "Did NOT find input file: ${input}.nw"
    echo "Exiting..."
    echo " "
    exit 1
fi
echo "Job $JOB_ID used the input file: ${input}.nw"
echo " "

# Creating scratch/tmp directory

JOB_SCRATCH_TMP=$PWD/tmp
echo "Creating Scratch Tmp folder: $JOB_SCRATCH_TMP"
echo " "
mkdir -pv $JOB_SCRATCH_TMP
cp ${input}.nw $JOB_SCRATCH_TMP
cd $JOB_SCRATCH_TMP

# load the job environment:
. /u/local/Modules/default/init/modules.sh
module load intel/2020.4
module load nwchem

# Running NWCHEM
echo "Running NWChem"
echo " "
`which mpirun` -np $NSLOTS $NWCHEM_BIN/nwchem ${input}.nw 2>&1 > ${SGE_O_WORKDIR}/${input}.out.$JOB_ID

#Moving output files and remove tmp
cd $SGE_O_WORKDIR
echo "Removing Scratch Tmp"
echo " "
rm -rf $JOB_SCRATCH_TMP

# echo job info on joblog:
echo "Job $JOB_ID ended on:   " `hostname -s`
echo "Job $JOB_ID ended on:   " `date `
echo " "
### NWChem_submit.sh STOP ###
