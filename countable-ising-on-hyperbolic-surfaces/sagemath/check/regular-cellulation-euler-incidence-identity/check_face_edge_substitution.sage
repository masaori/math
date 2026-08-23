# SageMath: 面と辺の incidence 等式を代入する一行を厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * (2 * e) - p * q * e + q * (p * f) == p * (2 * e) - p * q * e + q * (2 * e)
print("RESULT: PASS — p|F| = 2|E| is substituted over ZZ")
