# 対象ラベル: claim_self_dual_quadratic_roots
# 第二因子から根: 減法の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('extract_minus'):
    lhs = (-1) + (-s)
    rhs = -1 - s
    assert lhs == rhs, ('extract_minus_subtraction', s, xi, lhs, rhs)
print('PASS extract_minus_subtraction: {} exact equalities'.format(len(sd_inputs('extract_minus'))))
