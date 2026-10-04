# 対象ラベル: claim_self_dual_quadratic_roots
# 第二の根から方程式: 準備の因数分解の等式
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('root_minus'):
    lhs = xi**2 + 2 * xi - 1
    rhs = ((xi + 1) - s) * ((xi + 1) + s)
    assert lhs == rhs, ('root_minus_factorization', s, xi, lhs, rhs)
print('PASS root_minus_factorization: {} exact equalities'.format(len(sd_inputs('root_minus'))))
