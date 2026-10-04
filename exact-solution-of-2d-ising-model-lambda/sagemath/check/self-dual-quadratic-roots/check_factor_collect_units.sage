# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 分配則を逆向きに適用
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = ((xi**2 + (1 * xi + 1 * xi)) + 1) - 2
    rhs = ((xi**2 + (1 + 1) * xi) + 1) - 2
    assert lhs == rhs, ('factor_collect_units', s, xi, lhs, rhs)
print('PASS factor_collect_units: {} exact equalities'.format(len(sd_inputs('factor'))))
