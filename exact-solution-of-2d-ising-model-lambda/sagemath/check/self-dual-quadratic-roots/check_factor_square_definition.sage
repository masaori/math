# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: $\xi^2$ の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = ((xi * xi + 1 * xi) + (xi + 1)) - 2
    rhs = ((xi**2 + 1 * xi) + (xi + 1)) - 2
    assert lhs == rhs, ('factor_square_definition', s, xi, lhs, rhs)
print('PASS factor_square_definition: {} exact equalities'.format(len(sd_inputs('factor'))))
