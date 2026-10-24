# 対象ラベル: claim_self_dual_positive_root_unique
# 本文の行: 自己双対方程式の仮定
# 帰属: QQ と QQbar。場合の仮定を含む論理式を検査する。
load('sagemath/check/self-dual-root-positive/_unique_prelude.sage')
checked = 0
for s, xi in unique_cases():
    assert xi**2 + 2*xi - 1 == 0, (s, xi)
    checked += 1
assert checked == 4
print('RESULT: PASS (自己双対方程式の仮定: 4 件)')
