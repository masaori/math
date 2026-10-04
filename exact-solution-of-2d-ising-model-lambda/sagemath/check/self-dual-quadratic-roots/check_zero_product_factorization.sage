# 対象ラベル: claim_self_dual_quadratic_roots
# 方程式から積が零: 準備の因数分解の等式
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('zero_product'):
    lhs = ((xi + 1) - s) * ((xi + 1) + s)
    rhs = xi**2 + 2 * xi - 1
    assert lhs == rhs, ('zero_product_factorization', s, xi, lhs, rhs)
print('PASS zero_product_factorization: {} exact equalities'.format(len(sd_inputs('zero_product'))))
