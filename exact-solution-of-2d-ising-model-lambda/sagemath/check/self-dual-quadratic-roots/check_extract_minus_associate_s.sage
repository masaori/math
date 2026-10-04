# 対象ラベル: claim_self_dual_quadratic_roots
# 第二因子から根: 加法の結合則
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_minus'):
    lhs = ((xi + 1) + (s + (-s))) + (-1)
    rhs = (((xi + 1) + s) + (-s)) + (-1)
    assert lhs == rhs, ('extract_minus_associate_s', s, xi, lhs, rhs)
print('PASS extract_minus_associate_s: {} exact equalities'.format(len(sd_inputs('extract_minus'))))
