include '../types.pxi'
from libcpp.functional cimport function

cdef extern from 'ql/math/integrals/integral.hpp' namespace 'QuantLib':

    cdef cppclas Integrator:
        Integrator(Real absoluteAccuracy,
                   Size maxEvaluations)
        
        Real operator()(function<Real (Real)>& f,
                        Real a,
                        Real b)

        void setAbsoluteAccuracy(Real)
        void setMaxEvaluations(Size)
     
        Real absoluteAccuracy()
        Size maxEvaluations()

        Real absoluteError()
        Size numberOfEvaluations()
        bool integrationSuccess()