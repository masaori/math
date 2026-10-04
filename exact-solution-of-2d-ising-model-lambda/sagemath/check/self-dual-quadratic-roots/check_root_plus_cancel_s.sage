# 対象ラベル: claim_self_dual_quadratic_roots
# 第一の根から方程式: 元と同じ元との差は零
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_plus'):
    lhs = (s - s) * ((xi + 1) + s)
    rhs = 0 * ((xi + 1) + s)
    assert lhs == rhs, ('root_plus_cancel_s', s, xi, lhs, rhs)
print('PASS root_plus_cancel_s: {} exact equalities'.format(len(sd_inputs('root_plus'))))
