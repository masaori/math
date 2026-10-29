# 対象ラベル: claim_signed_even_subgraph_orbit_product
# (P_L^{a,b})^2 = 単元・二元・四元軌道の因子の平方の積。
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            assert prod(factors)^2 == prod(factor^2 for factor in factors)
            assert prod(factors)[0] == 1
