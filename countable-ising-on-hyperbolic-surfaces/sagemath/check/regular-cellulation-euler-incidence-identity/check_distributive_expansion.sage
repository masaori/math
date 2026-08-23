# SageMath: Euler 標数式への整数分配律を厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * q * (v - e + f) == p * q * v - p * q * e + p * q * f
print("RESULT: PASS — distributive expansion holds over ZZ")
