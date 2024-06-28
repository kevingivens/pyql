from quantlib.handle cimport shared_ptr
from quantlib.processes._black_scholes_process cimport GeneralizedBlackScholesProcess
from quantlib.pricingengines._pricing_engine cimport PricingEngine


cdef extern from 'ql/pricingengines/asian/turnbullwakemanasianengine.hpp' namespace 'QuantLib':
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
    cdef cppclass TurnbullWakemanAsianEngine(PricingEngine):
        TurnbullWakemanAsianEngine(
            shared_ptr[GeneralizedBlackScholesProcess] process
        ) except +
