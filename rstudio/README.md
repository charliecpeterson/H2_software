# Rstudio on Hoffman2

Hoffman2 has the ability to run RStudio on the H2 compute nodes. 

Hoffman2 has a RStudio container that can be ran using Apptainer that can be run on a compute node and rendered on the user's local machine

## Running Rstudio - the long way

Users can follow these steps in order to run Rstudio using the Rstudio container on Hoffman2

```
# get an interactive job
qrsh -l h_data=10G
# Create tmp directories
mkdir -pv $SCRATCH/rstudiotmp/var/lib
mkdir -pv $SCRATCH/rstudiotmp/var/run
mkdir -pv $SCRATCH/rstudiotmp/tmp
#Setup apptainer
module load apptainer/1.0.0
#Run rstudio
apptainer run -B $SCRATCH/rstudiotmp/var/lib:/var/lib/rstudio-server -B $SCRATCH/rstudiotmp/var/run:/var/run/rstudio-server -B $SCRATCH/rstudiotmp/tmp:/tmp $H2_CONTAINER_LOC/h2-rstudio_4.1.0.sif
# This command will display some information and a `ssh -L ...` command for you to run on a separate terminal 
```

Then open another terminal to connect to hoffman2

```
ssh  -L 8787:nXXX:8787 username@hoffman2.idre.ucla.edu # Or whatever command was displayed earlier 
# Then open a web browser and type
http://localhost:8787 #or whatever port number that was displayed
```

Then you can use Rstudio on your web browser. When you are done, it is best to exit Rstudio and press [Crtl-C] to the terminal running the Rstudio container to exit the job.

## Running Rstudio - the easy way

We have built a script to automatically setup Rstudio server on a compute node on Hoffman2.
 
Users can run the `h2_rstudio.sh` script on their local machine to setup RSudio.

```
./h2_rstudio.sh -h
```

This will give you a usage statment on running the Hoffman2 RStudio script.

```
./h2_rstudio.sh -u H2USERNAME
```

This is start RStudio on hoffman2 as a qrsh job and open a port tunnel to the Hoffman2 compute node. Then you came open a web browser to set RStudio.

---
**NOTE**

This script has been test on Mac's terminal, Windows WSL2, and Mobaxterm. This script will fail on GitBash because it doesn't have the `execpt` command.
 
---


## Running R in BATCH mode

The version of R in this container is installed in the container. If you want to continue using this version of R in a Batch job, instead of an interactive Rstudio, you will need run R inside the container.

The job script `rstudio_batch.job` is an example of a SGE job script that will submit a R job using the version of R inside of the Rstudio container and use the libraries that were installed using this version.

This is great if you used and installed packages with Rstudio and you want to run a R batch job with the same version of R and R packages.


