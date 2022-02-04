### NWChem_submit.sh START ###
#!/bin/bash
#$ -cwd
# error = Merged with joblog
#$ -o joblog.$JOB_ID
#$ -j y
# Edit the line below to request the appropriate runtime and memory
# (or to add any other resource) as needed:
#$ -l rh7,h_rt=1:00:00,h_data=5G
# Add multiple cores/nodes as needed:
#$ -pe dc* 72
# Email address to notify
#$ -M $USER@mail
# Notify when
#$ -m bea

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
