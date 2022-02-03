#Example of Linear Algbra function With Numpy/SciPy
#Charles Peterson 04/2020

import numpy as np
from scipy import linalg

#Creating 10 x 10 matrix
np.random.seed(20)
Mat1 = np.random.rand(10,10)
Mat1 = Mat1 * 10
print("\nExample of 10 x 10 Matrix:\n", Mat1)
print("\nDeterminant of matrix" , linalg.det(Mat1))
print("\nInverse of the Matrix:\n", linalg.inv(Mat1))

eg_val, eg_vec = linalg.eig(Mat1)
print("\nEigenValues of Matrix:\n", eg_val)
print("\nEigenVectors:\n",eg_vec)

