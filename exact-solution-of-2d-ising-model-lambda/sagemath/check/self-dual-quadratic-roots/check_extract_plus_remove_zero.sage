# 対象ラベル: claim_self_dual_quadratic_roots
# 第一因子から根: 零元との和
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_plus'):
    lhs = (0 + s) + (-1)
    rhs = s + (-1)
    assert lhs == rhs, ('extract_plus_remove_zero', s, xi, lhs, rhs)
print('PASS extract_plus_remove_zero: {} exact equalities'.format(len(sd_inputs('extract_plus'))))
