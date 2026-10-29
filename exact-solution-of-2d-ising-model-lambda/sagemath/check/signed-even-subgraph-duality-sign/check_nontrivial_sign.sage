# 対象ラベル: claim_signed_even_subgraph_duality_sign
K = R.fraction_field()
kw = (1-x)/(1+x)
for length in range(1, 4):
    N = length^2
    for a, b in ((0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        Q = prod(factors, R.one())
        F = K((1+x)^(2*N))*K(Q)(kw)
        assert F(xc) == 2^N*Q(xc)
        assert F == 2^N*K(Q)
        assert Q(1) == 2^N
