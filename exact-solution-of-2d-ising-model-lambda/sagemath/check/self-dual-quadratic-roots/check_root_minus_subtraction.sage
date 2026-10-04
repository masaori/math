# 対象ラベル: claim_self_dual_quadratic_roots
# 第二の根から方程式: 減法の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_minus'):
    lhs = ((xi + 1) - s) * (((-1 - s) + 1) + s)
    rhs = ((xi + 1) - s) * ((((-1) + (-s)) + 1) + s)
    assert lhs == rhs, ('root_minus_subtraction', s, xi, lhs, rhs)
print('PASS root_minus_subtraction: {} exact equalities'.format(len(sd_inputs('root_minus'))))
