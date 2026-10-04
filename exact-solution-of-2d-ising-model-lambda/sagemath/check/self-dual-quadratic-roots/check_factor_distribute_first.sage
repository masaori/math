# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 第一の積への分配則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = ((xi + 1) - s) * (xi + 1) + ((xi + 1) - s) * s
    rhs = ((xi + 1) * (xi + 1) - s * (xi + 1)) + ((xi + 1) - s) * s
    assert lhs == rhs, ('factor_distribute_first', s, xi, lhs, rhs)
print('PASS factor_distribute_first: {} exact equalities'.format(len(sd_inputs('factor'))))
