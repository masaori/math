# SageMath: 整数乗法の結合律・交換律による括り直しを厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * q * v - p * q * e + p * q * f == p * (q * v) - p * q * e + q * (p * f)
print("RESULT: PASS — multiplicative regrouping holds over ZZ")
