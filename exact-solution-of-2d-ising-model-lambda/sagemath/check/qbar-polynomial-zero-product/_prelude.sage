# 対象ラベル: claim_qbar_polynomial_zero_product
# QQbar[t] の演算結果と、独立に添字を列挙した係数和を照合する。
R = PolynomialRing(QQbar, 't')
t = R.gen()
zero = QQbar(0)
one = QQbar(1)
sqrt_two = QQbar(2).sqrt()
iota = QQbar(-1).sqrt()
zeta = QQbar.zeta(3)

# リストは定数項から順に並ぶ。最小非零次数はリストから改めて探索する。
coefficient_lists = [
    [1], [-1, 1], [sqrt_two, 0, -sqrt_two], [iota, zeta, 1],
    [0, 1, -1], [0, zeta, -zeta, iota], [0, 0, sqrt_two, 1],
    [0, 0, 0, iota, 0, -1], [0, 0, 0, 0, zeta, 1],
    [0, 0, 0, 0, 0, 0, 0, sqrt_two + iota, -zeta],
]
polynomials = [R(coefficients) for coefficients in coefficient_lists]

def least_nonzero_index(poly):
    return min(k for k, coefficient in enumerate(poly.list()) if coefficient != zero)

fixtures = []
for f in polynomials:
    for g in polynomials:
        m = least_nonzero_index(f)
        n = least_nonzero_index(g)
        pairs = [(a, m+n-a) for a in range(m+n+1)]
        fixtures.append((f, g, m, n, pairs))

# 零積の仮定が成立する実際の標本。非零二因子に偽の仮定を置かない。
zero_product_fixtures = [(R.zero(), R.zero())]
for f in polynomials:
    zero_product_fixtures.extend([(R.zero(), f), (f, R.zero())])

assert len(fixtures) == 100
assert len(zero_product_fixtures) == 21
assert {least_nonzero_index(f) for f in polynomials} == {0, 1, 2, 3, 4, 7}
assert any(c.imag() != 0 for f in polynomials for c in f.list())
