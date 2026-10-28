# 対象ラベル: claim_dispersion_algebraic_onsager_form
P = PolynomialRing(QQ, names=('q', 'p', 's'))
q, p, s = P.gens()
F = P.fraction_field()
q, p, s = map(F, (q, p, s))
left = 4*q^2*((1+q^2)^2/(4*q^2) - (1-q^2)/(2*q)*((p+1/p)/2+(s+1/s)/2))
right = (1+q^2)^2-q*(1-q^2)*((p+1/p)+(s+1/s))
assert left == right
print('RESULT: PASS denominators')
