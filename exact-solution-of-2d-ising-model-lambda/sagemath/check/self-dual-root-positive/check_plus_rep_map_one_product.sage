# 対象ラベル: claim_self_dual_root_plus_representation
# 本文の行: 一の包含像への置換
# 式・所属: j(minus_one_q) + one_k*s == j(minus_one_q) + j(one_q)*s
# 帰属: QQ と QQbar。表示は両埋込みの数体から独立に復元する。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

checked = 0
for s, value in plus_mem_cases():
    a, b = reconstruct_in_quadratic_field(value, s)
    assert j(minus_one_q) + one_k*s == j(minus_one_q) + j(one_q)*s, s
    checked += 1
assert checked == 2
print('RESULT: PASS (一の包含像への置換: 2 件)')
