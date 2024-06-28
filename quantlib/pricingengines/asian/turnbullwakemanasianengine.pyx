from cython.operator cimport dereference as deref

from quantlib.handle cimport static_pointer_cast, shared_ptr
from quantlib.pricingengines._pricing_engine cimport PricingEngine as QlPricingEngine
cimport quantlib.pricingengines.asian._turnbullwakemanasianengine as _twae
from quantlib.processes.black_scholes_process cimport GeneralizedBlackScholesProcess
cimport quantlib.processes._black_scholes_process as _bsp


cdef class TurnbullWakemanAsianEngine(PricingEngine):
    """ Turnbull Wakeman two moment-matching Asian option Engine
        Analytical pricing based on the two-moment Turnbull-Wakeman
        approximation.
        References: "Commodity Option Pricing", Iain Clark, Wiley, section 2.7.4.
                    "Option Pricing Formulas, Second Edition", E.G. Haug, 2006, pp. 192-202.
                    Some parts of the implementation were modeled after calculations from the
                    CommodityAveragePriceOptionAnalyticalEngine class in Open Source Risk Engine
                    (https://github.com/OpenSourceRisk/Engine).

        test
        - the correctness of the returned value is tested by reproducing
          results in literature with flat as well as upward and downward
          sloping volatility term structures.
        - the pricing of trades with guaranteed exercise/OTM is also tested.
    """
    
    def __init__(self,  GeneralizedBlackScholesProcess process):
        cdef shared_ptr[_bsp.GeneralizedBlackScholesProcess] process_ptr = \
            static_pointer_cast[_bsp.GeneralizedBlackScholesProcess](process._thisptr)
        self._thisptr.reset(
            new _twae.TurnbullWakemanAsianEngine(process_ptr))
    
