# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: (1-\xi)\cdot\bigl((1+\xi)\cdot(1+\xi)^{-1}\bigr) = (1-\xi)\cdot 1
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = (1-xi)*((1+xi)*(1+xi)**(-1))
    right = (1-xi)*1
    assert left == right, "product_inverse: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (product_inverse, %d algebraic points)" % checked)
