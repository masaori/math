# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 第一の項に単位元との積を挿入
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = ((xi**2 + (xi + xi)) + 1) - 2
    rhs = ((xi**2 + (1 * xi + xi)) + 1) - 2
    assert lhs == rhs, ('factor_first_unit', s, xi, lhs, rhs)
print('PASS factor_first_unit: {} exact equalities'.format(len(sd_inputs('factor'))))
