# 対象ラベル: claim_self_dual_quadratic_roots
# 因数分解: 加法の逆元との和
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('factor'):
    lhs = (xi + 1) * (xi + 1) + (((-(s * (xi + 1))) + s * (xi + 1)) + (-(s * s)))
    rhs = (xi + 1) * (xi + 1) + (0 + (-(s * s)))
    assert lhs == rhs, ('factor_cancel_middle', s, xi, lhs, rhs)
print('PASS factor_cancel_middle: {} exact equalities'.format(len(sd_inputs('factor'))))
