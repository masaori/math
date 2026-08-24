# 式ペア: v_2(P)+v_2(v^#V) = v_2(P v^#V)。
# 帰属: ZZ。素因子指数の積の法則を使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    assert P.valuation(2) + (v ** point_count).valuation(2) == (P * v ** point_count).valuation(2)
print("RESULT: PASS")

