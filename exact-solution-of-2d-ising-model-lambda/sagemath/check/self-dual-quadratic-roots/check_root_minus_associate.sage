# 対象ラベル: claim_self_dual_quadratic_roots
# 第二の根から方程式: 加法の結合則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_minus'):
    lhs = ((xi + 1) - s) * ((((-s) + (-1)) + 1) + s)
    rhs = ((xi + 1) - s) * (((-s) + ((-1) + 1)) + s)
    assert lhs == rhs, ('root_minus_associate', s, xi, lhs, rhs)
print('PASS root_minus_associate: {} exact equalities'.format(len(sd_inputs('root_minus'))))
