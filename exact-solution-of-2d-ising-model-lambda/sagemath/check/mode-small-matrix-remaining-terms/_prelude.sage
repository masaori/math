# 対象ラベル: claim_mode_small_matrix_remaining_terms
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
d0 = 1-x*varpi
d1 = 1-x*varsigma
d2 = 1-x*varpi**(-1)
d3 = 1-x*varsigma**(-1)
