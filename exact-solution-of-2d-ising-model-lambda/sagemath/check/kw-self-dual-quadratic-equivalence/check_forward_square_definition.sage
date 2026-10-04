# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \bigl((\xi+\xi^2)-\xi\bigr)+2\xi-1 = \bigl((\xi+\xi\cdot\xi)-\xi\bigr)+2\xi-1
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = ((xi+xi**2)-xi)+2*xi-1
    right = ((xi+xi*xi)-xi)+2*xi-1
    assert left == right, "forward_square_definition: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (forward_square_definition, %d algebraic points)" % checked)
