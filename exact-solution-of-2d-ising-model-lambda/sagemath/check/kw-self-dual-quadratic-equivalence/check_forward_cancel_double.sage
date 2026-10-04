# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: (1-2\xi)+2\xi-1 = 1-1
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = (1-2*xi)+2*xi-1
    right = 1-1
    assert left == right, "forward_cancel_double: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (forward_cancel_double, %d algebraic points)" % checked)
