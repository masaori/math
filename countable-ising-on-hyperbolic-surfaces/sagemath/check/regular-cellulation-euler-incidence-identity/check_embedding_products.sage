# SageMath: 標準単射が二つの自然数積を整数積へ移す一行を厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * (q * v) - p * q * e + q * (p * f) == p * ZZ(q * v) - p * q * e + q * ZZ(p * f)
print("RESULT: PASS — the standard embedding preserves both natural-number products")
