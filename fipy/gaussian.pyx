###############################################################################
# gaussian.pyx
###############################################################################
#
# Smear with a Gaussian kernel and variable array of sigma's
#
#
###############################################################################

# Import basic functions
import numpy as np
cimport numpy as np
cimport cython


DTYPE = np.float
ctypedef np.float_t DTYPE_t

cdef extern from "math.h":
	double log(double x) nogil
	double exp(double x) nogil


# Define basic quantities
cdef double pi = np.pi


#########################################################
# Internal functions									#
#########################################################

@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
@cython.initializedcheck(False)
cdef double Gauss(double x,double x0,double sigma) nogil:
	return exp(- (x-x0)**2/2./sigma**2)


#########################################################
# External functions									#
#########################################################
@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
@cython.initializedcheck(False)
cpdef double[::1] gaussian_filter1d(double[::1] x_list,double[::1] y_list,double[::1] sigma_list):
	'''
	--- input ---
	x_list : double array of x values
	y_list : double array of y values
	sigma_list : list of sigma values
	'''
	cdef int N = len(x_list)
	cdef double[::1] res = np.zeros(N,dtype=DTYPE)
	cdef double[::1] vec = np.zeros(N,dtype=DTYPE)
	cdef int i,j
	cdef double y , sigma, x0, norm,tmp

	with nogil:
		for i in range(N):
			y = y_list[i]
			sigma = sigma_list[i]
			x0 = x_list[i]
			norm = 0.0
			for j in range(N):
				tmp = Gauss(x_list[j],x0,sigma)
				norm += tmp
				vec[j] = y*tmp
			for j in range(N):
				res[j] += vec[j] / norm
		
	return res