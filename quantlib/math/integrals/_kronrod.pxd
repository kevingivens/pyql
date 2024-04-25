include '../../types.pxi'

from quantlib.math.integrals._integral cimport Integrator


cdef extern from 'ql/math/integrals/kronrod.hpp' namespace 'QuantLib':

    cdef cppclass GaussKronrodNonAdaptive(Integrator):
        GaussKronrodNonAdaptive(Real absoluteAccuracy,
                                Size maxEvaluations,
                                Real relativeAccuracy) except +
        void setRelativeAccuracy(Real)
        Real relativeAccuracy()
     
    cdef cppclass GaussKronrodAdaptive(Integrator):
        GaussKronrodAdaptive(Real tolerance, Size maxFunctionEvaluations) except +
     