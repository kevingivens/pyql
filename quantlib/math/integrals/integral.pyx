include '../../types.pxi'
from libcpp.functional cimport function
cimport quantlib.math.integrals._integral as _integral
from quantlib.handle cimport shared_ptr


cdef class Integrator:
    def __init__(self, Real absoluteAccuracy, Size maxEvaluations):
        self._thisptr = shared_ptr[_integral.Integrator](
                new _integral.Integrator(absoluteAccuracy, maxEvaluations)
        )

    def __call__(self, object f, Real a, Real b):
        # TODO: add is callable and arg runtime assertions
        # <void*>f
        cdef function[double(double)] _f(*f)
        self._thisptr.get().call(_f, a, b)
        del _f
    
    @property
    def absolute_accuracy(self):
        return <Real>self._thisptr.get().absoluteAccuracy()
    
    @property
    def max_evaluations(self):
        return <Size>self._thisptr.get().maxEvaluations()

    @absolute_accuracy.setter
    def absolute_accuracy(self, Real abs_accuracy):
        self._thisptr.get().setAbsoluteAccuracy(abs_accuracy)
    
    @max_evaluations.setter
    def max_evaluations(self, Size max_evals):
        self._thisptr.get().setMaxEvaluations(max_evals)
    
    @property
    def absolute_error(self):
        return <Real>self._thisptr.get().absoluteError()
    
    @property
    def number_of_evaluations(self):
        return <Size>self._thisptr.get().numberOfEvaluations()
    
    @property
    def integration_success(self):
        return self._thisptr.get().integrationSuccess()

