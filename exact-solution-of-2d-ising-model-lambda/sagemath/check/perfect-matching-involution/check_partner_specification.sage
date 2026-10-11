# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 存在・非固定・相手の仕様
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, i in matching_points():
    v = candidates(J,D,i)
    assert len(v) == 1 and v[0] != i and pair(i,v[0]) in D
    checked += 1
print("PASS partner_specification: %s 条件確認" % checked)
