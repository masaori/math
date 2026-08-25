# 式ペア: Omega_M(#E_M-1)=Omega_M(1)=0 なので一つ下の項は 0。
# 帰属: ZZ。回文性と有限な整数等式だけを使う。
load("_prelude.sage")
for M, edge_count, a, b, coefficients, P in CASES:
    omega_one = ZZ(0)
    assert coefficients[edge_count - 1] == omega_one
    penultimate_term = coefficients[edge_count - 1] * a**(edge_count - 1) * b
    assert penultimate_term == 0
print("RESULT: PASS")
