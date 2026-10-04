# 対象ラベル: claim_self_dual_quadratic_roots
# 第一の根から方程式: 加法の可換則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_plus'):
    lhs = (((-1 + s) + 1) - s) * ((xi + 1) + s)
    rhs = (((s + (-1)) + 1) - s) * ((xi + 1) + s)
    assert lhs == rhs, ('root_plus_commute', s, xi, lhs, rhs)
print('PASS root_plus_commute: {} exact equalities'.format(len(sd_inputs('root_plus'))))
