# 式ペア: P_M ≡ 2 (mod 4) なら v_2(P_M) = 1。
# 帰属: ZZ。素因子指数だけを使う。
load("_prelude.sage")
for M, edge_count, a, b, coefficients, P in CASES:
    assert P % 4 == 2
    assert P % 2 == 0
    assert P % 4 != 0
    assert P.valuation(2) == 1
print("RESULT: PASS")

