# 対象ラベル: claim_self_dual_quadratic_roots
# 第二の根から方程式: 加法の逆元との和
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_minus'):
    lhs = ((xi + 1) - s) * (((-s) + ((-1) + 1)) + s)
    rhs = ((xi + 1) - s) * (((-s) + 0) + s)
    assert lhs == rhs, ('root_minus_cancel_one', s, xi, lhs, rhs)
print('PASS root_minus_cancel_one: {} exact equalities'.format(len(sd_inputs('root_minus'))))
