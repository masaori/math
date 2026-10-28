# 対象ラベル: claim_mode_small_matrix_determinant_dispersion
from itertools import permutations

K = CyclotomicField(8)
z = K.gen()
R = LaurentPolynomialRing(K, names=('varpi', 'varsigma', 'x'))
varpi, varsigma, x = R.gens()
d0, d1, d2, d3 = 1-x*varpi, 1-x*varsigma, 1-x*varpi**(-1), 1-x*varsigma**(-1)
A = matrix(R, [
    [d0, -x*z*varsigma, 0, -x*z**(-1)*varsigma**(-1)],
    [-x*z**(-1)*varpi, d1, -x*z*varpi**(-1), 0],
    [0, -x*z**(-1)*varsigma, d2, -x*z*varsigma**(-1)],
    [-x*z*varpi, 0, -x*z**(-1)*varpi**(-1), d3],
])

def inversion_sign(p):
    return (-1)**sum(p[i] > p[j] for i in range(4) for j in range(i+1, 4))

all_perms = list(permutations(range(4)))
admissible = [p for p in all_perms if all(p[i] != (i+2)%4 for i in range(4))]
term = lambda p: inversion_sign(p)*prod(A[i,p[i]] for i in range(4))
permutation_sum = sum(map(term, all_perms), R.zero())
admissible_sum = sum(map(term, admissible), R.zero())
ordered = [(0,1,2,3), (0,1,3,2), (0,2,1,3), (1,0,2,3),
    (1,0,3,2), (1,2,3,0), (3,0,1,2), (3,1,2,0), (3,2,1,0)]
signed_terms = (prod(A[i,ordered[0][i]] for i in range(4))
    - prod(A[i,ordered[1][i]] for i in range(4))
    - prod(A[i,ordered[2][i]] for i in range(4))
    - prod(A[i,ordered[3][i]] for i in range(4))
    + prod(A[i,ordered[4][i]] for i in range(4))
    - prod(A[i,ordered[5][i]] for i in range(4))
    - prod(A[i,ordered[6][i]] for i in range(4))
    - prod(A[i,ordered[7][i]] for i in range(4))
    + prod(A[i,ordered[8][i]] for i in range(4)))
remaining_substitution = (d0*d1*d2*d3 - x**2*(varpi**(-1)*varsigma**(-1)*d0*d1
    + varpi**(-1)*varsigma*d0*d3 + varpi*varsigma*d2*d3
    + varpi*varsigma**(-1)*d1*d2) + 2*x**4
    - prod(A[i,ordered[5][i]] for i in range(4))
    - prod(A[i,ordered[6][i]] for i in range(4)))
signed_sum = (d0*d1*d2*d3 - x**2*(varpi**(-1)*varsigma**(-1)*d0*d1
    + varpi**(-1)*varsigma*d0*d3 + varpi*varsigma*d2*d3
    + varpi*varsigma**(-1)*d1*d2) + 4*x**4)
dispersion = (1+x**2)**2-x*(1-x**2)*(varpi+varpi**(-1)+varsigma+varsigma**(-1))

