# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 和の加法の逆元
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = (xi**2 + 2 * xi) + (1 + (-(1 + 1)))
    rhs = (xi**2 + 2 * xi) + (1 + ((-1) + (-1)))
    assert lhs == rhs, ('factor_negate_sum', s, xi, lhs, rhs)
print('PASS factor_negate_sum: {} exact equalities'.format(len(sd_inputs('factor'))))
