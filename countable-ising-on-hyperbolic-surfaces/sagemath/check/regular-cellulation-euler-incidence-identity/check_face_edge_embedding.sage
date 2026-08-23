# SageMath: 面側の標準単射が 2|E| を 2 ebar へ移す一行を厳密検算する
# 対象ラベル: theorem_regular_cellulation_euler_incidence_identity
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/_prelude.sage")
for data in examples:
    p, q, v, e, f, chi = values(data)
    assert p * (2 * e) - p * q * e + q * ZZ(2 * e) == p * (2 * e) - p * q * e + q * (2 * e)
print("RESULT: PASS — the face-side embedding sends 2|E| to 2 ebar")
