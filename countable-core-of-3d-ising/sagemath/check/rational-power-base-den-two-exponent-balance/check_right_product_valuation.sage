# 式ペア: v_2(u^#V b^#E) = v_2(u^#V)+v_2(b^#E)。
# 帰属: ZZ。素因子指数の積の法則を使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    assert (u ** point_count * b ** edge_count).valuation(2) == (u ** point_count).valuation(2) + (b ** edge_count).valuation(2)
print("RESULT: PASS")

