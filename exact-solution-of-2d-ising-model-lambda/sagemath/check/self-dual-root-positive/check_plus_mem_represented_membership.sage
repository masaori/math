# 対象ラベル: claim_self_dual_root_plus_mem
# 本文の行: 表示された値の二次体への所属
# 式・所属: reconstruct_in_quadratic_field(j(minus_one_q) + j(one_q)*s, s) == (minus_one_q, one_q)
# 帰属: QQ と QQbar。所属は埋込み付き二次数体から独立に復元する。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

checked = 0
for s, value in plus_mem_cases():
    assert reconstruct_in_quadratic_field(j(minus_one_q) + j(one_q)*s, s) == (minus_one_q, one_q), s
    checked += 1
assert checked == 2
print('RESULT: PASS (表示された値の二次体への所属: 2 件)')
