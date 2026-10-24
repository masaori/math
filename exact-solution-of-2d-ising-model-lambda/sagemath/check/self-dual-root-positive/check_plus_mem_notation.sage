# 対象ラベル: claim_self_dual_root_plus_mem
# 本文の行: 負の一の記法
# 式・所属: value == (-one_k) + s
# 帰属: QQ と QQbar。所属は埋込み付き二次数体から独立に復元する。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

checked = 0
for s, value in plus_mem_cases():
    assert value == (-one_k) + s, s
    checked += 1
assert checked == 2
print('RESULT: PASS (負の一の記法: 2 件)')
