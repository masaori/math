# SageMath: 最終的な整数分配律による因数分解を厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * (2 * e) - p * q * e + q * (2 * e) == (2 * p + 2 * q - p * q) * e
print("RESULT: PASS — the final factorization holds over ZZ")
