include '../types.pxi'

cimport quantlib._stochastic_process as _sp
#from quantlib.termstructures.volatility.equityfx.local_vol_surface cimport LocalVolTermStructure
from quantlib.termstructures.volatility.equityfx.local_vol_surface cimport Lo 


from quantlib.handle cimport Handle, shared_ptr

from quantlib.quote cimport Quote
from quantlib.handle cimport Handle, shared_ptr, static_pointer_cast
cimport quantlib._quote as _qt
from quantlib.processes.heston_process cimport HestonProcess
cimport quantlib.processes._heston_process as _hp


cdef class HestonLSVProcess(StochasticProcess):
    r"""
    Heston Local Stochastic Volatility diffusion Process.

    .. math::

        d S_t   =& (r - d) S_t dt + L(S_t, t) \sqrt{V_t} S_t dW_t^S \\
        d V_t   =& \kappa (\theta - V_t)dt + \eta \sigma \sqrt{V_t} dW_t^V \\
        \rho dt =& dW_t^S dW_t^{V}

    """

    def __init__(self,
       HestonProcess heston_process,
       LocalVolTermStructure leverage_fct,
       mixing_factor=1.0,
    ):
       
       #create handles
       self._thisptr = shared_ptr[_sp.StochasticProcess](
            new QlHestonLSVProcess(
                static_pointer_cast[_hp.HestonProcess](heston_process._thisptr),
                leverage_fct._thisptr,
                mixing_factor
            )
        )

    def __str__(self):
        return 'Heston LSV process\nv0: %f kappa: %f theta: %f sigma: %f rho: %f' % \
          (self.v0, self.kappa, self.theta, self.sigma, self.rho, self.mixing_factor)

    @property
    def v0(self):
        return (<QlHestonLSVProcess*>self._thisptr.get()).v0()

    @property
    def rho(self):
        return (<QlHestonLSVProcess*>self._thisptr.get()).rho()

    @property
    def kappa(self):
        return (<QlHestonLSVProcess*>self._thisptr.get()).kappa()

    @property
    def theta(self):
        return (<QlHestonLSVProcess*>self._thisptr.get()).theta()

    @property
    def sigma(self):
        return (<QlHestonLSVProcess*>self._thisptr.get()).sigma()
    
    @property
    def mixing_factor(self):
        return (<QlHestonLSVProcess*>self._thisptr.get()).mixingFactor()

    @property
    def s0(self):
        cdef Handle[_qt.Quote] handle = (<QlHestonLSVProcess*>self._thisptr.get()).s0()
        cdef Quote q = Quote.__new__(Quote)
        q._thisptr = handle.currentLink()
        return q

    #def time(self, ):
    #    cdef Handle[_qt.Quote] handle = (<QlHestonLSVProcess*>self._thisptr.get()).s0()
    #    cdef Quote q = Quote.__new__(Quote)
    #    q._thisptr = handle.currentLink()
    #    return q