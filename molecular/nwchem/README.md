# Running NWCHEM on H2

This is information about running [NWChem](https://nwchemgit.github.io/) on H2

## Example water

Files:
 - water.nw: input file 
 - water.job: job script for UGE

The file `water.nw` is example input file for NWCHEM.

To run this job on Hoffman2, you will need to run

```
qsub water.out
```

This will run the `water.nw` on Hoffman2. It will create a TMP directory to run NWCHEM and save the output to the file `water.out.$JOBID`

You can use `water.job` as a template to run other NWChem jobs by renaming this file to the name of your NWChem input file. You can also change the location of the TMP directory in this job script.

 
