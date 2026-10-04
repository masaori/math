# 対象ラベル: claim_self_dual_quadratic_roots
# 第二因子から根: 上で得た $(\xi+1)+s=0$
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_minus'):
    lhs = (((xi + 1) + s) + (-s)) + (-1)
    rhs = (0 + (-s)) + (-1)
    assert lhs == rhs, ('extract_minus_second_factor_zero', s, xi, lhs, rhs)
print('PASS extract_minus_second_factor_zero: {} exact equalities'.format(len(sd_inputs('extract_minus'))))
