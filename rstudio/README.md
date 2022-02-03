# Rstudio on Hoffman2

Hoffman2 has the ability to run RStudio on the H2 compute nodes. 

Hoffman2 has a RStudio container that can be ran using Singularity that can be run on a compute node and rendered on the user's local machine

Users can run the `h2_rstudio.sh` script on their local machine to setup RSudio.

```
./h2_rstudio.sh -h
```

This will give you a usage statment on running the Hoffman2 RStudio script.

```
./h2_rstudio.sh -u H2USERNAME
```

This is start RStudio on hoffman2 as a qrsh job and open a port tunnel to the Hoffman2 compute node. Then you came open a web browser to set RStudio.


