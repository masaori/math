# 式ペア: v_2(P v^#V) = v_2(u^#V b^#E)。
# 帰属: ZZ。本文の整数等式を使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    assert P * v ** point_count == u ** point_count * b ** edge_count
    assert (P * v ** point_count).valuation(2) == (u ** point_count * b ** edge_count).valuation(2)
print("RESULT: PASS")

