# 式ペア: P_M = sum(...) ≡ Omega_M(#E_M) a^#E_M ≡ 2 (mod 4)。
# 帰属: ZZ。有限和、端係数 2、a の奇数性だけを使う。
load("_prelude.sage")
for M, edge_count, a, b, coefficients, P in CASES:
    top_term = coefficients[edge_count] * a**edge_count
    assert coefficients[edge_count] == 2
    assert a % 2 == 1
    assert P % 4 == top_term % 4
    assert top_term % 4 == 2
    assert P % 4 == 2
print("RESULT: PASS")

