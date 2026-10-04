# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: -\xi^2+(1-2\xi) = (-\xi^2+1)-2\xi
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = -xi**2+(1-2*xi)
    right = (-xi**2+1)-2*xi
    assert left == right, "difference_left_association: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (difference_left_association, %d algebraic points)" % checked)
