#
# Fortran compiler settings
#
if(WITH_MPI)
  set(CMAKE_Fortran_COMPILER "mpifort" CACHE STRING "Fortran compiler")
else()
  set(CMAKE_Fortran_COMPILER "ifort" CACHE STRING "Fortran compiler")
endif()

# Note: either "-standard-semantics' or '-assume realloc_lhs' must be among the compiler options
set(CMAKE_Fortran_FLAGS "-standard-semantics -heap-arrays 10" CACHE STRING "General Fortran flags")

set(CMAKE_Fortran_FLAGS_RELEASE "-O2 -ip" CACHE STRING
  "Specific Fortran flags for Release (production) mode")

set(FYPP_FLAGS "" CACHE STRING "Flags for the preprocessor")

#
# C compiler settings
#
set(CMAKE_C_COMPILER "icc" CACHE STRING "C compiler")

set(CMAKE_C_FLAGS "" CACHE STRING "General C flags")

set(CMAKE_C_FLAGS_RELEASE "-O2 -ip" CACHE STRING "Specific C flags for Release mode")


#
# External libraries
#

# LAPACK and BLAS
if(WITH_OMP)
  set(LAPACK_LIBRARIES "mkl_intel_lp64;mkl_intel_thread;mkl_core" CACHE STRING
    "LAPACK and BLAS libraries to link")
else()
  set(LAPACK_LIBRARIES "mkl_intel_lp64;mkl_sequential;mkl_core" CACHE STRING
    "LAPACK and BLAS libraries to link")
endif()
  
set(LAPACK_LIBRARY_DIRS "$ENV{MKLROOT}/lib/intel64" CACHE STRING
  "Directories where LAPACK and BLAS libraries can be found")

# ARPACK -- only needed when built with ARPACK support
set(ARPACK_LIBRARIES "arpack" CACHE STRING "Arpack library")
set(ARPACK_LIBRARY_DIRS "" CACHE STRING "Directories where Arpack library can be found")

# ScaLAPACK -- only needed for MPI-parallel build
set(SCALAPACK_LIBRARIES "mkl_scalapack_lp64;mkl_blacs_intelmpi_lp64" CACHE STRING
  "Scalapack libraries to link")
set(SCALAPACK_LIBRARY_DIRS "$ENV{MKLROOT}/lib/intel64" CACHE STRING
  "Directories where Scalapack libraries can be found")

# ELSI -- only needed when compiled with ELSI support
set(ELSI_ROOT "/opt/elsi" CACHE STRING "Root directory of the ELSI installation")

set(ELSI_EXTERNAL_LIBRARIES "" CACHE STRING
  "Any EXTERNAL libraries ELSI needs apart of its own libraries (and scalapack)")
set(ELSI_EXTERNAL_LIBRARY_DIRS "" CACHE STRING
  "Directories where ELSI external libraries can be found")

# PEXSI -- only needed when ELSI was compiled with PEXSI support
# Note: PEXSI usually needs explicit linking of the standard C++ library. Make sure to
#     provide the library path to that C++ standard library, which was used to compile PEXSI.
set(PEXSI_EXTERNAL_LIBRARIES "" CACHE STRING
  "Any EXTERNAL libraries PEXSI needs apart of its own libraries")
set(PEXSI_EXTERNAL_LIBRARY_DIRS "" CACHE STRING "Directories with PEXSI external libraries")

# Any other library needed to be linked or considered as include
set(OTHER_LIBRARIES "" CACHE STRING "Other libraries to link")
set(OTHER_LIBRARY_DIRS "" CACHE STRING "Directories where the other libraries can be found")
set(OTHER_INCLUDE_DIRS "" CACHE STRING "Other include directories to consider")


#
# Test settings
#

# Number of OMP-threads used by one test process
set(TEST_OMP_THREADS "1" CACHE STRING "Number of threads to use for each test")

# Number of MPI-processed launched for each test
set(TEST_MPI_PROCS "1" CACHE STRING "Number of mpi processes to use for each test")

# Command line used to launch the test code
if(WITH_MPI)
  set(TEST_RUNNER "env OMP_NUM_THREADS=${TEST_OMP_THREADS} mpiexec -n ${TEST_MPI_PROCS}")
else()
  set(TEST_RUNNER "env OMP_NUM_THREADS=${TEST_OMP_THREADS}")
endif()


#
# Debug settings (for developers)
#
set(CMAKE_Fortran_FLAGS_DEBUG "-g -warn all -stand f08 -check -diag-error-limit 1 -traceback"
  CACHE STRING "Specific Fortran flags for Debug mode")

set(CMAKE_C_FLAGS_DEBUG "-g -Wall")

