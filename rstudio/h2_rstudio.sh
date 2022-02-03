#!/bin/bash
## This script will run Rstudio server on Hoffman2
## This uses a Singularity container with R/Rstudio
# Author Charlie Peterson <cpeterson@oarc.ucla.edu>
# Date Created: 2/2/2022

echo -e $'\e[37;42m@--------------------------------------------------------------------------------------@\e[0m'
echo -e $'\e[37;42m|                     H O F F M A N 2  -  R S U T D I O                                |\e[0m'
echo -e $'\e[37;42m@--------------------------------------------------------------------------------------@\e[0m' 
echo -e $'\E[32m                                                                          ctrl+c to quit \e[0m'
tput sgr0
GREEN='\033[0;32m'

NOCOLOR='\033[0m'
## USAGE ##
usage ()
{
echo "
##	This Script will create a Rstudio session on a compute node on Hoffman2

	-h       Show this message  
	OPTIONS:
	REQUIRED
	-u [username]   Hoffman2 user name
	OPTIONAL:
        -m [MEMORY]       Memory requirments in GB   
	-l [qsub/qrsh opts]  Extra QRSH option i.e. highp	
"
}

## CLEANING UP ##
function cleaning()
{
	if [ -f rstudiotmp ] ; then
		rm rstudiotmp
	fi

	[ ! -z "$JOBID" ] && ssh ${H2USERNAME}@hoffman2.idre.ucla.edu qdel $JOBID > /dev/null

	for i in "${PIDarr[@]}"
	do
		pkill -P $i
	done
	exit 1
}


## GETTING COMMAND LINE OPTIONS ###
while getopts ":u:h" options ; do
        case $options in
                h ) usage; exit ;;
                u ) H2USERNAME=$OPTARG  ;;
                : ) echo "-$OPTARG requires an argument"; usage; exit ;;
                ? ) echo "-$OPTARG is not an option"; usage ; exit;;
        esac
done


## STARING RSTUDIO JOB ##
mktmp_cmd='mkdir -p $SCRATCH/rstudiotmp/var/run ; mkdir -p $SCRATCH/rstudiotmp/var/lib ; mkdir -p $SCRATCH/rstudiotmp/tmp'

qrsh_cmd='source /u/local/Modules/default/init/modules.sh ; module purge ; module load singularity ; module list ; echo "JOBID: ${JOB_ID}" ; singularity run -B $SCRATCH/rstudiotmp/var/lib:/var/lib/rstudio-server -B $SCRATCH/rstudiotmp/var/run:/var/run/rstudio-server -B $SCRATCH/rstudiotmp/tmp:/tmp $H2_CONTAINER_LOC/rstudio-rocker-4.1.0'

PIDarr=()
ssh_cmd="${mktmp_cmd} ; qrsh -N RSTUDIO -l h_data=10G,h_rt=4:00:00 '${qrsh_cmd}'"
ssh ${H2USERNAME}@hoffman2.idre.ucla.edu "${ssh_cmd}" > rstudiotmp  2>&1 &
PID=$!
PIDarr+=($PID)
trap cleaning EXIT

## WAITING FOR RSTUDIO TO START ##
out_tmp=""
sp="/-\|"
printf "Waiting for job to start running....."
while [[ ${out_tmp} -ne 1 ]]
do 
	JOBID=`cat rstudiotmp | grep JOBID | awk '{print $2}'`
	out_tmp=`cat rstudiotmp | grep ssh | wc -l`
	printf "\b${sp:i++%${#sp}:1}"
	sleep 1
done

## OPEN UP PORT
echo ".....Job started!!"
echo ""
out_tmp=`cat rstudiotmp | grep ssh |  sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"`
out_port=`grep "running on PORT" rstudiotmp | awk '{print $7}'`
eval "${out_tmp}" 2>&1 &
PID=$!
PIDarr+=($PID)
sleep 3
echo -e $"You can now open your web browser to ${GREEN} http://localhost:${out_port} ${NOCOLOR}"
open http://localhost:${out_port}

### Stopping
sleep 60


