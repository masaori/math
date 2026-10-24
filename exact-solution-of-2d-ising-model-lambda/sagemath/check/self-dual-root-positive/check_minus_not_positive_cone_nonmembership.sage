# 対象ラベル: claim_self_dual_root_minus_not_positive
# 本文の行: 正錐への非所属
# 帰属: QQ と QQbar。表示は両埋込みの数体から独立に復元する。
load('sagemath/check/self-dual-root-positive/_plus_mem_prelude.sage')

checked = 0
for s in plus_mem_roots:
    value = -one_k - s
    a, b = reconstruct_in_quadratic_field(value, s)
    assert not ((0 <= a and 0 <= b and (a,b) != (0,0)) or (0 < a and b < 0 and (2*b)*b < a*a) or (a < 0 and 0 < b and a*a < (2*b)*b)), s
    checked += 1
assert checked == 2
print('RESULT: PASS (正錐への非所属: 2 件)')
