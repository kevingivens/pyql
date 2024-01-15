include '../types.pxi'

from quantlib.handle cimport shared_ptr, make_shared

from . cimport _gaussian_orthogonal_polynomial as _gop


cdef class GaussianOrthogonalPolynomial:
    
    def __init__(self) -> None:
        self._thisptr = shared_ptr[_gop.GaussianOrthogonalPolynomial](
            new _gop.GaussianOrthogonalPolynomial()
        )

    def value(self, Size i, Real x):
        return <double>self._thisptr.value(i, x)
        
    def weighted_value(self, Size i, Real x):
        return <double> self._thisptr.weightedValue(i, x)
    
cdef class GaussLaguerrePolynomial(GaussianOrthogonalPolynomial):

    def __init__(self, double s = 0.0):
        self._thisptr = shared_ptr[_gop.GaussLaguerrePolynomial](
            new _gop.GaussLaguerrePolynomial(s)
        )
    
    @property
    def mu_0(self):
        self._thisptr.mu_0()
    
    @property
    def alpha(self):
        self._thisptr.alpha()

    @property
    def beta(self):
        self._thisptr.beta()

    @property
    def w(self):
        self._thisptr.w()