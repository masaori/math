# SageMath: Euler 標数の定義を代入する一行を厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * q * chi == p * q * (v - e + f)
print("RESULT: PASS — the Euler-characteristic definition substitution holds over ZZ")
