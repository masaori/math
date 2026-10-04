# 対象ラベル: claim_kw_dual_transform_involution
# 式ペア: \bigl(1+(1+(\xi+(-\xi)))\bigr)\cdot(1+\xi)^{-1} = \bigl(1+(1+0)\bigr)\cdot(1+\xi)^{-1}
load('sagemath/check/kw-dual-transform-involution/_prelude.sage')

count = 0
for xi in test_points:
    assert one + xi != zero
    inverse = (one + xi)^(-1)
    value = kw(xi)
    assert one + value != zero
    value_inverse = (one + value)^(-1)
    double_value = kw(value)
    expr1 = (one+(one+(xi+(-xi))))*inverse
    expr2 = (one+(one+zero))*inverse
    assert expr1 == expr2, (xi, expr1, expr2)
    count += 1
assert count == 16
print("RESULT: PASS plus_cancel; 16 algebraic numbers")
