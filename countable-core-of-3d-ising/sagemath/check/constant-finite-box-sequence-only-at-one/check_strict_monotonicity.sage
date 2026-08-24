# 対象ラベル: claim_constant_finite_box_sequence_only_at_one
# Z_2 の係数の非負性と正次数の正係数から、正の有理数上の狭義単調増加と
# Z_2(q)=Z_2(1) ⇒ q=1 を検証する。
# 帰属: ZZ[X] と QQ の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

multiplicity, edge_count = multiplicities(2)
polynomial = partition_polynomial(multiplicity, edge_count)

assert edge_count == ZZ(12)
for degree in range(edge_count + 1):
    assert polynomial[ZZ(degree)] >= ZZ(0)
assert polynomial[edge_count] > ZZ(0)

# 狭義単調増加を有限標本ではなく二変数の多項式恒等式として検証する。
# Z_2(R)-Z_2(Q)=(R-Q)D(Q,R) で、D の係数は全て非負かつ D は非零である。
bivariate_ring = PolynomialRing(ZZ, names=("Q", "R"))
Q, R = bivariate_ring.gens()
polynomial_Q = bivariate_ring(polynomial(Q))
polynomial_R = bivariate_ring(polynomial(R))
difference = polynomial_R - polynomial_Q
quotient, remainder = difference.quo_rem(R - Q)
assert remainder == 0
assert difference == (R - Q) * quotient
assert all(coefficient >= 0 for coefficient in quotient.coefficients())
assert quotient != 0

# 各正次数 m の寄与は c_m(R^(m-1)+...+Q^(m-1)) であり、
# Q,R>0 なら非負、最高次係数の寄与が正なので D(Q,R)>0 となる。
expected_quotient = sum(
    polynomial[m] * sum(R ** (m - 1 - k) * Q ** k for k in range(m))
    for m in range(1, edge_count + 1)
)
assert quotient == expected_quotient
assert polynomial[edge_count] > 0

# Z_2(q)=Z_2(1) を満たす正の有理点は 1 のみ。
shifted = polynomial - polynomial_ring(polynomial(QQ(1)))
positive_rational_roots = [
    root for root, _ in shifted.roots(QQ) if root > QQ(0)
]
assert positive_rational_roots == [QQ(1)]

print("RESULT: PASS")
