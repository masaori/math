# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: -(\xi^2+2\xi)+(-(-1)) = -\bigl((\xi^2+2\xi)+(-1)\bigr)
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = -(xi**2+2*xi)+(-(-1))
    right = -((xi**2+2*xi)+(-1))
    assert left == right, "difference_negation_distribution: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (difference_negation_distribution, %d algebraic points)" % checked)
