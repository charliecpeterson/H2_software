# Example of using SciPy 

This is a simple example of running a Python calucation on Hoffman2

This job uses NumPy/SciPy to run some Linear Algbra routines

This is a serial (1 core) job

## Files
- Job Script: LinAlgTest.sh
- Python Input file: LinAlgTest.py


## To run on Hoffman2

First, you will need to install the SciPy package

```
qrsh -l rh7,h_data=5G
module load python/3.7.3
pip3 install scipy --user
```

This will install scipy in your `$HOME/.local` directory

Then, you can submit the job script.

```
qsub LinAlgTest.job
```

This will run the Python job and output to a file, LinAlgTest.out.

