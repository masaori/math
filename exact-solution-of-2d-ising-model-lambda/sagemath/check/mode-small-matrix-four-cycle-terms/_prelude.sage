# 対象ラベル: claim_mode_small_matrix_four_cycle_terms
# 形式的なモード変数と不定元を含む可算な Laurent 多項式環。
K = CyclotomicField(8)
z = K.gen()
R = LaurentPolynomialRing(K, names=('varpi', 'varsigma', 'x'))
varpi, varsigma, x = R.gens()
z = R(z)
M = matrix(R, [
    [varpi, z*varsigma, 0, z**(-1)*varsigma**(-1)],
    [z**(-1)*varpi, varsigma, z*varpi**(-1), 0],
    [0, z**(-1)*varsigma, varpi**(-1), z*varsigma**(-1)],
    [z*varpi, 0, z**(-1)*varpi**(-1), varsigma**(-1)],
])
A = identity_matrix(R, 4) - x*M
forward_product = A[0,1]*A[1,2]*A[2,3]*A[3,0]
reverse_product = A[0,3]*A[1,0]*A[2,1]*A[3,2]
forward_substitution = (-x*z*varsigma)*(-x*z*varpi**(-1))*(-x*z*varsigma**(-1))*(-x*z*varpi)
reverse_substitution = (-x*z**(-1)*varsigma**(-1))*(-x*z**(-1)*varpi)*(-x*z**(-1)*varsigma)*(-x*z**(-1)*varpi**(-1))
forward_grouped = x**4*z**4*(varsigma*varsigma**(-1))*(varpi**(-1)*varpi)
reverse_grouped = x**4*z**(-4)*(varsigma**(-1)*varsigma)*(varpi*varpi**(-1))
