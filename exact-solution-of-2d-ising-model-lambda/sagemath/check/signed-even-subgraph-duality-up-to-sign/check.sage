import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

K = R.fraction_field()
kw = (1-x)/(1+x)
for length in range(1, 4):
    N = length^2
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            Q = prod(factors, R.one())
            D = prod((delta(*point) for point in points), R.one())
            assert Q.degree() <= 2*N
            assert Q^2 == D
            F = K((1+x)^(2*N))*K(Q)(kw)
            assert F.denominator() == 1
            assert F^2 == (2^N*Q)^2
            assert (F-2^N*Q)*(F+2^N*Q) == 0
print('RESULT: PASS signed even subgraph duality up to sign')
