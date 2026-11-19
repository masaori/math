# 対象ラベル: claim_subfield_weighted_square_sum_excludes_minus_one
# y ∈ QQ について y² = 0 または y² > 0 を厳密に検査する。
values = [QQ(n)/QQ(d) for n in range(-4, 5) for d in range(1, 5)]
for y in values:
    assert y*y == 0 or y*y > 0
    assert (-y)*(-y) == y*y
print('PASS: square sign')
