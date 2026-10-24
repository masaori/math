# 対象ラベル: claim_self_dual_positive_root_unique
# 本文の行: 正錐の元の二次体への所属
# 帰属: QQ と QQbar。場合の仮定を含む論理式を検査する。
load('sagemath/check/self-dual-root-positive/_unique_prelude.sage')
checked = 0
for s, xi in unique_cases():
    assert (not unique_positive(xi, s)) or all(c in QQ for c in reconstruct_in_quadratic_field(xi, s)), (s, xi)
    checked += 1
assert checked == 4
print('RESULT: PASS (正錐の元の二次体への所属: 4 件)')
