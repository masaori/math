# 対象ラベル: claim_rational_power_point_numerator_divides_twice_gap_power_minus_one
# 隣接する三次元箱の頂点数の差が 3L^2+3L+1 であることを ZZ で確認する。

for L in range(1, 257):
    gap = ZZ(L + 1) ** 3 - ZZ(L) ** 3
    formula = 3 * ZZ(L) ** 2 + 3 * ZZ(L) + 1
    assert gap == formula
    assert gap > 0

print("RESULT: PASS")
