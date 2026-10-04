# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 右側の和への分配則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = (xi + 1) * (xi + 1) - 2
    rhs = ((xi + 1) * xi + (xi + 1) * 1) - 2
    assert lhs == rhs, ('factor_expand_square_right', s, xi, lhs, rhs)
print('PASS factor_expand_square_right: {} exact equalities'.format(len(sd_inputs('factor'))))
