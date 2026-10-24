# 対象ラベル: claim_self_dual_root_plus_positive
# 本文の行: 根の二次体への所属
# 式・所属: value == j(a) + j(b)*s
# 帰属: QQ と QQbar。表示は両埋込みの数体から独立に復元する。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

checked = 0
for s, value in plus_mem_cases():
    a, b = reconstruct_in_quadratic_field(value, s)
    assert value == j(a) + j(b)*s, s
    checked += 1
assert checked == 2
print('RESULT: PASS (根の二次体への所属: 2 件)')
