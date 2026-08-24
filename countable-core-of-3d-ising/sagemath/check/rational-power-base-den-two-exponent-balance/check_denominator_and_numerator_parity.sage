# 式ペア: 2 | v から 2 | b、2 ∤ a、2 ∤ u、e_v >= 1、e_b >= 1。
# 帰属: ZZ。有限の整除性だけを使う。
load("_prelude.sage")
for a, b, u, v, P, point_count, edge_count in CASES:
    assert b % 2 == 0
    assert a % 2 != 0
    assert u % 2 != 0
    assert v.valuation(2) >= 1
    assert b.valuation(2) >= 1
print("RESULT: PASS")

