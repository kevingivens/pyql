"""
 Copyright (C) 2011, Enthought Inc
 Copyright (C) 2011, Patrick Henaff

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
"""

include '../types.pxi'

from quantlib.handle cimport Handle, shared_ptr
from quantlib.termstructures.volatility.equityfx._local_vol_surface cimport LocalVolTermStructure
from quantlib.termstructures.yields._flat_forward cimport YieldTermStructure
cimport quantlib._quote as _qt
from quantlib._stochastic_process cimport StochasticProcess
from quantlib.processes._heston_process cimport HestonProcess

cdef extern from 'ql/processes/hestonprocess.hpp' namespace 'QuantLib':

    cdef cppclass HestonLSVProcess(StochasticProcess):
        HestonLSVProcess() # fake empty constructor for Cython
        HestonLSVProcess(
            shared_ptr[HestonProcess]& hestonProcess,
            shared_ptr[LocalVolTermStructure]& leverageFct,
            Real mixingFactor = 1.0) except +

        Size size() except +
        Real v0() except +
        Real rho() except +
        Real kappa() except +
        Real theta() except +
        Real sigma() except +
        Real mixingFactor() 
        shared_ptr[LocalVolTermStructure] leverageFct()

        Handle[_qt.Quote] s0()
        Handle[YieldTermStructure] dividendYield()
        Handle[YieldTermStructure] riskeFreeRate()



