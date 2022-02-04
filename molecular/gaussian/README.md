# Gaussian

Examples for running Gaussian jobs on Hoffman2

Since Gaussian is licensed code, access is restriced to certain Talon users.

If you require to run Gaussian (09 or 16), please contact ### LINK ###


# CO example

This example runs the Gaussian 09 revD.

The `CO.com` file is a Gaussian input file for the CO compound. 

The `CO.job` file is a SLURM job script to run the `CO.com` input on Talon.

The `CO.job` file will

1. module the Gaussian module
2. create a scratch directory and copy input file
3. run Gaussian
4. move output files and remove scratch directory

To run this job, you will run the command:

```
qsub CO.job
```

The resulting output directory will be placed in `$JOBID.CO` 

# CO example on GPU

Gaussian 16 can use the GPU compute nodes.

The `CO-gpu.com` file is a Gaussian input file for the CO compound with GPUs.

The `CO-gpu.com` file is a SLURM job script to run on Talons GPU compute nodes

The job script will

1. load the gaussian16 and cuda modules
2. set up scratch directory and copy input file
3. run Gaussian16
4. move output files and remove scratch direcetory

To run this job, you will run the command:

```
qsub CO-gpu.job
```

The resulting output directory will be placed in `$JOBID.CO-gpu` 
