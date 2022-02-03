/*
        Test MPI code
*/
#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    MPI_Init(NULL, NULL);

    int MPI_size, MPI_rank, name_len;;
    MPI_Comm_size(MPI_COMM_WORLD, &MPI_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &MPI_rank);
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    MPI_Get_processor_name(processor_name, &name_len);

    printf("Hello world from node %s, rank %d out of %d processors\n",
           processor_name, MPI_rank, MPI_size);

    MPI_Finalize();
}
