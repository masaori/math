# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 二元軌道の族の完全マッチング条件
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, tau in _inv_cases:
    D = involution_pairs(J,tau)
    assert is_matching(J,D)
    checked += 1
print("PASS orbit_partition: %s 条件確認" % checked)
