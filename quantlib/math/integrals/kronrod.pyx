include '../../types.pxi'
from quantlib.handle cimport shared_ptr
from quantlib.math.integrals.integral cimport Integrator
from . cimport _integral as _integral
from . cimport _kronrod as _kronrod

cdef class GaussKronrodNonAdaptive(Integrator):
    """ 
    # Integral of a 1-dimensional function using the Gauss-Kronrod methods
    # This class provide a non-adaptive integration procedure which
    #    uses fixed Gauss-Kronrod abscissae to sample the integrand at
    #    a maximum of 87 points.  It is provided for fast integration
    #    of smooth functions.
    #
    #    This function applies the Gauss-Kronrod 10-point, 21-point, 43-point
    #    and 87-point integration rules in succession until an estimate of the
    #    integral of f over (a, b) is achieved within the desired absolute and
    #    relative error limits, epsabs and epsrel. The function returns the
    #    final approximation, result, an estimate of the absolute error,
    #    abserr and the number of function evaluations used, neval. The
    #    Gauss-Kronrod rules are designed in such a way that each rule uses
    #    all the results of its predecessors, in order to minimize the total
    #    number of function evaluations.
    #
    """
    def __init__(self, Real absoluteAccuracy,
                       Size maxEvaluations,
                       Real relativeAccuracy):
        self._thisptr = shared_ptr[_integral.Integrator](
                new _kronrod.GaussKronrodNonAdaptive(
                    absoluteAccuracy,
                    maxEvaluations,
                    relativeAccuracy
            )
        )
    
    @property
    def absolute_accuracy(self):
        return <Real>self._thisptr.get().absoluteAccuracy()
    
    @absolute_accuracy.setter
    def absolute_accuracy(self, Real abs_accuracy):
        (<_kronrod.GaussKronrodNonAdaptive*>self._thisptr.get()).setAbsoluteAccuracy(abs_accuracy)
    

cdef class GaussKronrodAdaptive(Integrator):
    """ 
    # Integral of a 1-dimensional function using the Gauss-Kronrod methods
    # This class provide an adaptive integration procedure using 15
    #    points Gauss-Kronrod integration rule.  This is more robust in
    #    that it allows to integrate less smooth functions (though
    #    singular functions should be integrated using dedicated
    #    algorithms) but less efficient beacuse it does not reuse
    #    precedently computed points during computation steps.
    #
    #    References:
    #
    #    Gauss-Kronrod Integration
    #    <http://mathcssun1.emporia.edu/~oneilcat/ExperimentApplet3/ExperimentApplet3.html>
    #
    #    NMS - Numerical Analysis Library
    #    <http://www.math.iastate.edu/burkardt/f_src/nms/nms.html>
    #
    """
    def __init__(self, Real tolerance, Size maxFunctionEvaluations):
        self._thisptr = shared_ptr[_integral.Integrator](
                new _kronrod.GaussKronrodAdaptive(tolerance, maxFunctionEvaluations)
        )