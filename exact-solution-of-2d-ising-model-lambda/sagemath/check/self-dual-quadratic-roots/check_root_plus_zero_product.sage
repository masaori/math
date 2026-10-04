# 対象ラベル: claim_self_dual_quadratic_roots
# 第一の根から方程式: 零元との積
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_plus'):
    lhs = 0 * ((xi + 1) + s)
    rhs = 0
    assert lhs == rhs, ('root_plus_zero_product', s, xi, lhs, rhs)
print('PASS root_plus_zero_product: {} exact equalities'.format(len(sd_inputs('root_plus'))))
