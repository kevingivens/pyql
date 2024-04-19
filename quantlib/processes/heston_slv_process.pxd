from quantlib.stochastic_process cimport StochasticProcess
from ._heston_slv_process cimport HestonLSVProcess as QlHestonLSVProcess

cdef class HestonLSVProcess(StochasticProcess):
    pass
