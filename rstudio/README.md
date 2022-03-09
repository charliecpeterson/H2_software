# Rstudio on Hoffman2

Hoffman2 has the ability to run RStudio on the H2 compute nodes. 

Hoffman2 has a RStudio container that can be ran using Apptainer that can be run on a compute node and rendered on the user's local machine

Users can run the `h2_rstudio.sh` script on their local machine to setup RSudio.

```
./h2_rstudio.sh -h
```

This will give you a usage statment on running the Hoffman2 RStudio script.

```
./h2_rstudio.sh -u H2USERNAME
```

This is start RStudio on hoffman2 as a qrsh job and open a port tunnel to the Hoffman2 compute node. Then you came open a web browser to set RStudio.

## Running in BATCH mode

The version of R in this container is installed in the container. If you want to continue using this version of R in a Batch job, instead of an interactive Rstudio, you will need run R inside the container.

The job script `rstudio_batch.job` is an example of a SGE job script that will submit a R job using the version of R inside of the Rstudio container and use the libraries that were installed using this version.

This is great if you used and installed packages with Rstudio and you want to run a R batch job with the same version of R and R packages.


