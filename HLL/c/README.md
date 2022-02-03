# Test C Code

These are example C code and job scripts to show examples of compiling and running C code on Hoffman2.

# MPI_hello

Files:
- MPI_hello.c
- MPI_hello.sh

In this example, the `MPI_hello.c` file has C code to run a simple Hello World program using MPI. The `MPI_hello.sh` file is a job script for Hoffman2. In this job script, it has examples of running this program with using INTEL MPI and OPENMPI.

To run this job:

```
qsub MPI_hello.sh
```

# hybrid_hello

Files:
- hybrid_hello.c
- hybrid_hello.sh

In this example, the `hybrid_hello.c` file is a C code that will use MPI and OpenMP hybrid to run a multi-threaded, distributed program. This example will use INTEL MPI and OPENMPI.

To run this job:

```
qsub hybrid_hello.sh
```

# example cuda 

Files:
- matrixMul.cu

Example from https://github.com/NVIDIA/cuda-samples

