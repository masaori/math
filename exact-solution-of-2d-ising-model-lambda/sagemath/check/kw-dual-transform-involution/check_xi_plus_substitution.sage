# 対象ラベル: claim_kw_dual_transform_involution
# 式ペア: \xi\cdot\bigl(1+\mathrm{KW}(\xi)\bigr) = \xi\cdot\bigl(2\cdot(1+\xi)^{-1}\bigr)
load('sagemath/check/kw-dual-transform-involution/_prelude.sage')

count = 0
for xi in test_points:
    assert one + xi != zero
    inverse = (one + xi)^(-1)
    value = kw(xi)
    assert one + value != zero
    value_inverse = (one + value)^(-1)
    double_value = kw(value)
    expr1 = xi*(one+value)
    expr2 = xi*(two*inverse)
    assert expr1 == expr2, (xi, expr1, expr2)
    count += 1
assert count == 16
print("RESULT: PASS xi_plus_substitution; 16 algebraic numbers")
