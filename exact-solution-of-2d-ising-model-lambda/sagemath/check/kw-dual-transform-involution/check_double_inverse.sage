# 対象ラベル: claim_kw_dual_transform_involution
# 式ペア: \bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\Bigl(\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\Bigr) = \bigl(1-\mathrm{KW}(\xi)\bigr)\cdot1
load('sagemath/check/kw-dual-transform-involution/_prelude.sage')

count = 0
for xi in test_points:
    assert one + xi != zero
    inverse = (one + xi)^(-1)
    value = kw(xi)
    assert one + value != zero
    value_inverse = (one + value)^(-1)
    double_value = kw(value)
    expr1 = (one-value)*((one+value)*value_inverse)
    expr2 = (one-value)*one
    assert expr1 == expr2, (xi, expr1, expr2)
    count += 1
assert count == 16
print("RESULT: PASS double_inverse; 16 algebraic numbers")
