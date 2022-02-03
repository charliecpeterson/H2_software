/*
        Test hydird MPI OMP code
*/
#include <mpi.h>
#include <omp.h>
#include <stdio.h>

int main(int argc, char** argv) {
    MPI_Init(&argc, &argv);

    int MPI_size, MPI_rank, name_len, iam, np;
    MPI_Comm_size(MPI_COMM_WORLD, &MPI_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &MPI_rank);
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    MPI_Get_processor_name(processor_name, &name_len);

#pragma omp parallel default(shared) private(iam,np)
{
    np = omp_get_num_threads();
    iam = omp_get_thread_num();
    printf("Hello world from node %s, thread %d of %d, and rank %d out of %d processors\n",
           processor_name, iam, np, MPI_rank, MPI_size);
}
    MPI_Finalize();
}
