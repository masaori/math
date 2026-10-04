# 対象ラベル: claim_self_dual_quadratic_roots
# 方程式から積が零: 仮定 $\xi^2+2\xi-1=0$
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
for s, xi in sd_inputs('zero_product'):
    lhs = xi**2 + 2 * xi - 1
    rhs = 0
    assert lhs == rhs, ('zero_product_quadratic_zero', s, xi, lhs, rhs)
print('PASS zero_product_quadratic_zero: {} exact equalities'.format(len(sd_inputs('zero_product'))))
