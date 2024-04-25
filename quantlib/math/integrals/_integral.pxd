include '../../types.pxi'
from libcpp cimport bool
from libcpp.functional cimport function

cdef extern from 'ql/math/integrals/integral.hpp' namespace 'QuantLib':
    
    cdef cppclass Integrator:
        Integrator(Real absoluteAccuracy, Size maxEvaluations) except +
        
        Real call "operator()"(function[Real(Real) noexcept]& f, Real a, Real b)
        # Real call "operator()"(function[Real(Real)]& f, Real a, Real b)

        void setAbsoluteAccuracy(Real)
        void setMaxEvaluations(Size)
     
        Real absoluteAccuracy()
        Size maxEvaluations()

        Real absoluteError()
        Size numberOfEvaluations()
        bool integrationSuccess()