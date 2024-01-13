from libcpp.vector cimport vector, function
from quantlib.types cimport Real, Size
from quantlib.math._array cimport Array


cdef extern from 'ql/methods/montecarlo/montecarlo/lsmbasissystem.hpp' namespace 'QuantLib':
   cdef cppclass LsmBasisSystem:
       enum PolynomialType:
            Monomial 
            Laguerre
            Hermite
            Hyperbolic
            Legendre
            Chebyshev
            Chebyshev2nd

       @staticmethod 
       vector[function[Real(Real)]] pathBasisSystem(Size order, PolynomialType type)

       @staticmethod
       vector[[function[Real(Array)]] multiPathBasisSystem(Size dim, Size order, PolynomialType type)

 
       