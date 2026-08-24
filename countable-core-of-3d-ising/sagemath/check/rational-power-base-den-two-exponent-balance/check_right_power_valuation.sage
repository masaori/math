# 式ペア: v_2(u^#V)+v_2(b^#E) = #V v_2(u)+#E v_2(b)。
# 帰属: ZZ。素因子指数の冪の法則を使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    assert (u ** point_count).valuation(2) + (b ** edge_count).valuation(2) == point_count * u.valuation(2) + edge_count * b.valuation(2)
print("RESULT: PASS")

