# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: (1-\xi)-(\xi+\xi\cdot\xi) = (1-\xi)-(\xi+\xi^2)
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = (1-xi)-(xi+xi*xi)
    right = (1-xi)-(xi+xi**2)
    assert left == right, "difference_square: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (difference_square, %d algebraic points)" % checked)
