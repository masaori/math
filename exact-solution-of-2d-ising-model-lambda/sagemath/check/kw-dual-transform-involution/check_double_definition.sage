# 対象ラベル: claim_kw_dual_transform_involution
# 式ペア: \mathrm{KW}(\mathrm{KW}(\xi))\cdot\bigl(1+\mathrm{KW}(\xi)\bigr) = \Bigl(\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\Bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)
load('sagemath/check/kw-dual-transform-involution/_prelude.sage')

count = 0
for xi in test_points:
    assert one + xi != zero
    inverse = (one + xi)^(-1)
    value = kw(xi)
    assert one + value != zero
    value_inverse = (one + value)^(-1)
    double_value = kw(value)
    expr1 = double_value*(one+value)
    expr2 = ((one-value)*value_inverse)*(one+value)
    assert expr1 == expr2, (xi, expr1, expr2)
    count += 1
assert count == 16
print("RESULT: PASS double_definition; 16 algebraic numbers")
