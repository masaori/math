# 対象ラベル: claim_finite_torus_polynomial
P = PolynomialRing(ZZ, 'x')
x = P.gen()
G = {(c, d): P((c+1)*x + (d+1)*x^2 + x^3) for c in (0, 1) for d in (0, 1)}
Q = {(a, b): sum(ZZ(-1)^((1+a)*c+(1+b)*d+c*d) * G[c, d]
                  for c in (0, 1) for d in (0, 1)) for a in (0, 1) for b in (0, 1)}
direct = sum(Q.values())
interchanged = sum(sum(ZZ(-1)^((1+a)*c+(1+b)*d+c*d) * G[c, d]
                        for a in (0, 1) for b in (0, 1)) for c in (0, 1) for d in (0, 1))
collected = sum(sum(ZZ(-1)^((1+a)*c+(1+b)*d+c*d)
                    for a in (0, 1) for b in (0, 1)) * G[c, d]
                for c in (0, 1) for d in (0, 1))
assert direct == interchanged == collected == 4*G[0, 0]
print('RESULT: PASS finite sum interchange')
