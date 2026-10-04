# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: $2:=1+1$ の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = (xi**2 + 2 * xi) + (1 + (-2))
    rhs = (xi**2 + 2 * xi) + (1 + (-(1 + 1)))
    assert lhs == rhs, ('factor_expand_two', s, xi, lhs, rhs)
print('PASS factor_expand_two: {} exact equalities'.format(len(sd_inputs('factor'))))
