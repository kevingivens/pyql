cimport quantlib.math.integrals._integral as _integral
from quantlib.handle cimport shared_ptr

cdef class Integrator:
    cdef shared_ptr[_integral.Integrator] _thisptr