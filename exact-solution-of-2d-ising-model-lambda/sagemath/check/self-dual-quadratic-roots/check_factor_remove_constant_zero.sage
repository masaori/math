# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 零元との和
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = (xi**2 + 2 * xi) + (0 + (-1))
    rhs = (xi**2 + 2 * xi) + (-1)
    assert lhs == rhs, ('factor_remove_constant_zero', s, xi, lhs, rhs)
print('PASS factor_remove_constant_zero: {} exact equalities'.format(len(sd_inputs('factor'))))
