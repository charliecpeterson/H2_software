#!/bin/bash
#$ -cwd
#$ -o LinAlgTest.out.$JOB_ID
#$ -j y
#$ -l rh7,h_rt=1:00:00,h_data=5G
#$ -pe shared 1


# load the job environment
# Using pytnon version 3.7.3
. /u/local/Modules/default/init/modules.sh
module load python/3.7.3

#Running python code
#Input file: LinAlgTest.py
#Output file: LinAlgTest.out
python3 LinAlgTest.py > LinAlgTest.out

