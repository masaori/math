# 対象ラベル: claim_signed_even_subgraph_duality_sign
for length in range(1, 4):
    N = length^2
    values = {}
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            Q = prod(factors, R.one())
            assert Q(0) == 1
            values[(a, b)] = Q(1)
    assert sum(values.values()) == 2^(N+1)
    assert values[(0, 0)] == 2*2^N - 3*2^N == -2^N
    points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, 0, 0)
    Q = prod(factors, R.one())
    F = K((1+x)^(2*N))*K(Q)(kw)
    assert F == -2^N*K(Q)
