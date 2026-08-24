# 式ペア: v_2(P)+#V e_v = v_2(P)+v_2(v^#V)。
# 帰属: ZZ。素因子指数の冪の法則を使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    e_v = v.valuation(2)
    assert P.valuation(2) + point_count * e_v == P.valuation(2) + (v ** point_count).valuation(2)
print("RESULT: PASS")

