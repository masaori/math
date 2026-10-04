# 対象ラベル: claim_self_dual_quadratic_roots
# 第一因子から根: 加法の可換則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_plus'):
    lhs = s + (-1)
    rhs = (-1) + s
    assert lhs == rhs, ('extract_plus_commute', s, xi, lhs, rhs)
print('PASS extract_plus_commute: {} exact equalities'.format(len(sd_inputs('extract_plus'))))
