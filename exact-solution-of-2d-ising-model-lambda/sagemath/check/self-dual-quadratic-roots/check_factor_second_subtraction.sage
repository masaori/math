# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 第二の差の減法の定義
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = ((xi + 1) * (xi + 1) + (-(s * (xi + 1)))) + (s * (xi + 1) - s * s)
    rhs = ((xi + 1) * (xi + 1) + (-(s * (xi + 1)))) + (s * (xi + 1) + (-(s * s)))
    assert lhs == rhs, ('factor_second_subtraction', s, xi, lhs, rhs)
print('PASS factor_second_subtraction: {} exact equalities'.format(len(sd_inputs('factor'))))
