# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \bigl((1-\xi)-\xi\bigr)+2\xi-1 = \bigl(1-(\xi+\xi)\bigr)+2\xi-1
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = ((1-xi)-xi)+2*xi-1
    right = (1-(xi+xi))+2*xi-1
    assert left == right, "forward_subtraction_association: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (forward_subtraction_association, %d algebraic points)" % checked)
