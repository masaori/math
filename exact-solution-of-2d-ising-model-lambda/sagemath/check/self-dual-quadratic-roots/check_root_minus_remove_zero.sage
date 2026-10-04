# 対象ラベル: claim_self_dual_quadratic_roots
# 第二の根から方程式: 零元との和
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_minus'):
    lhs = ((xi + 1) - s) * (((-s) + 0) + s)
    rhs = ((xi + 1) - s) * ((-s) + s)
    assert lhs == rhs, ('root_minus_remove_zero', s, xi, lhs, rhs)
print('PASS root_minus_remove_zero: {} exact equalities'.format(len(sd_inputs('root_minus'))))
