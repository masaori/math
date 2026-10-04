# 対象ラベル: claim_self_dual_quadratic_roots
# 第二因子から根: 零元との和
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_minus'):
    lhs = (0 + (-s)) + (-1)
    rhs = (-s) + (-1)
    assert lhs == rhs, ('extract_minus_remove_zero', s, xi, lhs, rhs)
print('PASS extract_minus_remove_zero: {} exact equalities'.format(len(sd_inputs('extract_minus'))))
