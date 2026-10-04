# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: (1-\xi)-(\xi+\xi^2) = 1-\xi-\xi-\xi^2
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = (1-xi)-(xi+xi**2)
    right = 1-xi-xi-xi**2
    assert left == right, "difference_subtract_sum: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (difference_subtract_sum, %d algebraic points)" % checked)
