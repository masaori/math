# 対象ラベル: claim_box_free_divisibility_excludes_no_rational_point
# 本文の構成 c=a+1 と最終整除を ZZ 上で一段ずつ確認する。

for a in range(1, 1025):
    a = ZZ(a)
    c = a + 1
    assert c > 0
    twice_difference = 2 * (c - 1)
    assert twice_difference == 2 * a
    assert a.divides(twice_difference)

print("RESULT: PASS")
