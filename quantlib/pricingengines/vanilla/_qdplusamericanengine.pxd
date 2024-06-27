include '../../types.pxi'

from libcpp cimport pair
from quantlib.utilities.null cimport Null

from quantlib.processes._black_scholes_process cimport GeneralizedBlackScholesProcess
from quantlib.pricingengines._pricing_engine cimport PricingEngine


cdef extern from 'ql/pricingengines/vanilla/qdplusamericanengine.hpp' namespace 'QuantLib':
    cdef cppclass Interpolation
    cdef cppclass ChebyshevInterpolation
    cdef cppclass QdPutCallParityEngine(PricingEngine):
        QdPutCallParityEngine(shared_ptr[GeneralizedBlackScholesProcess] process) except +
        void calculate()
        
        cdef cppclass QdPlusAddOnValue:
            QdPlusAddOnValue(Time T,
                             Real S,
                             Real K,
                             Rate r,
                             Rate q,
                             Volatility vol,
                             Real xmax,
                             shared_ptr[Interpolation] q_z)
            Real operator()(Real z)

    # American engine based on the QD+ approximation to the exercise boundary.
    # The main purpose of this engine is to provide a good initial guess to the exercise
    #    boundary for the superior fixed point American engine QdFpAmericanEngine
    #
    #    References:
    #    Li, M. (2009), “Analytical Approximations for the Critical Stock Prices
    #                    of American Options: A Performance Comparison,”
    #                    Working paper, Georgia Institute of Technology.
    #
    #    https://mpra.ub.uni-muenchen.de/15018/1/MPRA_paper_15018.pdf
    
    cdef cppclass QdPlusAmericanEngineQdPutCallParityEngine:
      
        enum SolverType: 
            Brent
            Newton 
            Ridder
            Halley
            SuperHalley

        QdPlusAmericanEngine(
            shared_ptr[GeneralizedBlackScholesProcess],
            Size interpolationPoints = 8,
            SolverType solverType = Halley,
            Real eps = 1e-6,
            Size maxIter = Null[Size]())  except +

        pair[Size, Real] putExerciseBoundaryAtTau(
            Real S, Real K, Rate r, Rate q,
            Volatility vol, Time T, Time tau)

        shared_ptr[ChebyshevInterpolation] getPutExerciseBoundary(
            Real S, Real K, Rate r, Rate q, Volatility vol, Time T)

        Real xMax(Real K, Rate r, Rate q)