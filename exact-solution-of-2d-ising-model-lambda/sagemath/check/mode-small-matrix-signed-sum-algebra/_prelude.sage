# 対象ラベル: claim_mode_small_matrix_signed_sum_algebra
K = CyclotomicField(8)
R = LaurentPolynomialRing(K, names=('varpi', 'varsigma', 'x'))
varpi, varsigma, x = R.gens()
d0 = 1-x*varpi
d1 = 1-x*varsigma
d2 = 1-x*varpi**(-1)
d3 = 1-x*varsigma**(-1)
S = varpi+varpi**(-1)+varsigma+varsigma**(-1)
left = d0*d1*d2*d3-x**2*(varpi**(-1)*varsigma**(-1)*d0*d1+varpi**(-1)*varsigma*d0*d3+varpi*varsigma*d2*d3+varpi*varsigma**(-1)*d1*d2)+4*x**4
expanded = 1-x*S+2*x**2+x**3*S+x**4
closed = (1+x**2)**2-x*(1-x**2)*S
