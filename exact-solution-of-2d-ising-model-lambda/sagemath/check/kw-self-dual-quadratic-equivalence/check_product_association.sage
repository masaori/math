# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 式ペア: \bigl((1-\xi)\cdot(1+\xi)^{-1}\bigr)\cdot(1+\xi) = (1-\xi)\cdot\bigl((1+\xi)^{-1}\cdot(1+\xi)\bigr)
# 帰属: QQbar。浮動小数点を使わない。
load('sagemath/check/kw-self-dual-quadratic-equivalence/_prelude.sage')

checked = 0
for xi in test_points:
    left = ((1-xi)*(1+xi)**(-1))*(1+xi)
    right = (1-xi)*((1+xi)**(-1)*(1+xi))
    assert left == right, "product_association: equality failed"
    checked += 1
assert checked == 17
print("RESULT: PASS (product_association, %d algebraic points)" % checked)
