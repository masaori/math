# 式ペア: 下位項と一つ下の項が消えるので P_M ≡ 2 (mod 4)、従って v_2(P_M)=1。
# 帰属: ZZ。有限和、端係数 2、素因子指数だけを使う。
load("_prelude.sage")
for M, edge_count, a, b, coefficients, P in CASES:
    top_term = coefficients[edge_count] * a**edge_count
    assert coefficients[edge_count] == 2
    assert a % 2 == 1
    assert P % 4 == top_term % 4
    assert top_term % 4 == 2
    assert P.valuation(2) == 1
print("RESULT: PASS")
