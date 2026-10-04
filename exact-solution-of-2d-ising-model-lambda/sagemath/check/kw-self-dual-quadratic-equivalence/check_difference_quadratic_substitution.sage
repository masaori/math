# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: -\bigl(\xi^2+2\xi-1\bigr) = -0
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in quadratic_points:
    left = -(xi**2+2*xi-1)
    right = -0
    assert left == right, "difference_quadratic_substitution: equality failed"
    checked += 1
assert checked == 2
print("RESULT: PASS (difference_quadratic_substitution, %d algebraic points)" % checked)
