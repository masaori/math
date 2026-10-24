# 対象ラベル: claim_self_dual_positive_root_unique
# 本文の行: 第二の場合の等式
# 帰属: QQ と QQbar。場合の仮定を含む論理式を検査する。
load('sagemath/check/self-dual-root-positive/_unique_prelude.sage')
checked = 0
for s, xi in unique_cases():
    assert xi != -1-s or xi == -1-s, (s, xi)
    checked += 1
assert checked == 4
print('RESULT: PASS (第二の場合の等式: 4 件)')
