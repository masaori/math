# 対象ラベル: claim_self_dual_quadratic_roots
# 第一因子から根: 減法の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_plus'):
    lhs = (((xi + 1) + (-s)) + s) + (-1)
    rhs = (((xi + 1) - s) + s) + (-1)
    assert lhs == rhs, ('extract_plus_subtraction', s, xi, lhs, rhs)
print('PASS extract_plus_subtraction: {} exact equalities'.format(len(sd_inputs('extract_plus'))))
