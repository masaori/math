# 対象ラベル: claim_self_dual_root_plus_mem
# 本文の行: 包含の一保存
# 式・所属: (-one_k) + s == (-j(one_q)) + s
# 帰属: QQ と QQbar。所属は埋込み付き二次数体から独立に復元する。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

checked = 0
for s, value in plus_mem_cases():
    assert (-one_k) + s == (-j(one_q)) + s, s
    checked += 1
assert checked == 2
print('RESULT: PASS (包含の一保存: 2 件)')
