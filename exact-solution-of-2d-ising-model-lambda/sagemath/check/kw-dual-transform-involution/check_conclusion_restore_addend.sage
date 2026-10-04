# 対象ラベル: claim_kw_dual_transform_involution
# 式ペア: \mathrm{KW}(\mathrm{KW}(\xi)) = \bigl(\mathrm{KW}(\mathrm{KW}(\xi))-\xi\bigr)+\xi
load('sagemath/check/kw-dual-transform-involution/_prelude.sage')

count = 0
for xi in test_points:
    assert one + xi != zero
    inverse = (one + xi)^(-1)
    value = kw(xi)
    assert one + value != zero
    value_inverse = (one + value)^(-1)
    double_value = kw(value)
    expr1 = double_value
    expr2 = (double_value-xi)+xi
    assert expr1 == expr2, (xi, expr1, expr2)
    count += 1
assert count == 16
print("RESULT: PASS conclusion_restore_addend; 16 algebraic numbers")
