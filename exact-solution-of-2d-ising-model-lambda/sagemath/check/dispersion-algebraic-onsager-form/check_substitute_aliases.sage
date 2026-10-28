# 対象ラベル: claim_dispersion_algebraic_onsager_form
P = PolynomialRing(QQ, names=('q', 'p', 's'))
q, p, s = P.gens()
F = P.fraction_field()
q, p, s = map(F, (q, p, s))
C2 = (1 + q^2)/(2*q)
S2 = (1 - q^2)/(2*q)
cp = (p + 1/p)/2
cs = (s + 1/s)/2
left = 4*q^2*(C2^2 - S2*(cp+cs))
right = 4*q^2*((1+q^2)^2/(4*q^2) - (1-q^2)/(2*q)*((p+1/p)/2+(s+1/s)/2))
assert left == right
print('RESULT: PASS aliases')
