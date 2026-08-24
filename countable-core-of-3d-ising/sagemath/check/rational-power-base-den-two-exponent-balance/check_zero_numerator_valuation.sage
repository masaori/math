# 式ペア: #V v_2(u)+#E e_b = #V*0+#E e_b = #E e_b。
# 帰属: ZZ。2 ∤ u と零元の性質を使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    e_b = b.valuation(2)
    assert u.valuation(2) == 0
    assert point_count * u.valuation(2) + edge_count * e_b == point_count * 0 + edge_count * e_b
    assert point_count * 0 + edge_count * e_b == edge_count * e_b
    assert P.valuation(2) + point_count * v.valuation(2) == edge_count * e_b
print("RESULT: PASS")

