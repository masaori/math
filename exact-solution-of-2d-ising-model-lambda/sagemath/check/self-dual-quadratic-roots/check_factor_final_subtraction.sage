# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 減法の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = ((xi**2 + 2 * xi) + 1) - 2
    rhs = ((xi**2 + 2 * xi) + 1) + (-2)
    assert lhs == rhs, ('factor_final_subtraction', s, xi, lhs, rhs)
print('PASS factor_final_subtraction: {} exact equalities'.format(len(sd_inputs('factor'))))
