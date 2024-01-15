include '../types.pxi'

cdef extern from 'ql/math/integral/gaussianorthogonalpolynomial.hpp' namespace 'QuantLib':
    cppclass GaussianOrthogonalPolynomial
        Real value(Size i, Real x) const
        Real weightedValue(Size i, Real x) const

    cppclass GaussLaguerrePolynomial(GaussianOrthogonalPolynomial):
        GaussLaguerrePolynomial(Real s = 0.0) except +
        Real mu_0() const
        Real alpha(Size i) const
        Real beta(Size i) const
        Real w(Real x) const

    cppclass GaussHermitePolynomial(GaussianOrthogonalPolynomial):
        GaussHermitePolynomial(Real mu = 0.0) except +
        Real mu_0() const
        Real alpha(Size i) const
        Real beta(Size i) const
        Real w(Real x) const

    cppclass GaussJacobiPolynomial(GaussianOrthogonalPolynomial):
        GaussJacobiPolynomial(Real alpha, Real beta) except +
        Real mu_0() const
        Real alpha(Size i) const
        Real beta(Size i) const
        Real w(Real x) const

    cppclass GaussLegendrePolynomial(GaussJacobiPolynomial):
        GaussLegendrePolynomial() except +

    cppclass GaussChebyshevPolynomial(GaussJacobiPolynomial):
        GaussChebyshevPolynomial() except +

    cppclass GaussChebyshev2ndPolynomial(GaussJacobiPolynomial):
        GaussChebyshev2ndPolynomial() except +

    cppclass GaussGegenbauerPolynomial(GaussJacobiPolynomial):
        GaussGegenbauerPolynomial(Real lambda) except +

    cppclass GaussHyperbolicPolynomial(GaussianOrthogonalPolynomial):
        Real mu_0() const
        Real alpha(Size i) const
        Real beta(Size i) const
        Real w(Real x) const
    