# 対象ラベル: claim_self_dual_quadratic_roots
# 第二因子から根: 加法の可換則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_minus'):
    lhs = (-s) + (-1)
    rhs = (-1) + (-s)
    assert lhs == rhs, ('extract_minus_commute', s, xi, lhs, rhs)
print('PASS extract_minus_commute: {} exact equalities'.format(len(sd_inputs('extract_minus'))))
