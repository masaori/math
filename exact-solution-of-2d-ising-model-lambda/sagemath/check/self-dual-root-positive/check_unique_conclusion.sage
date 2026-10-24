# 対象ラベル: claim_self_dual_positive_root_unique
# 本文の行: 二つの場合を合わせた結論
# 帰属: QQ と QQbar。場合の仮定を含む論理式を検査する。
load('sagemath/check/self-dual-root-positive/_unique_prelude.sage')
checked = 0
for s, xi in unique_cases():
    assert not unique_positive(xi,s) or xi == -1+s, (s, xi)
    checked += 1
assert checked == 4
print('RESULT: PASS (二つの場合を合わせた結論: 4 件)')
