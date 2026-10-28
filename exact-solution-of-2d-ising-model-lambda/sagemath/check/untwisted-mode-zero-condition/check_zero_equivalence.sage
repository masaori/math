# 対象ラベル: claim_untwisted_mode_zero_condition
P = PolynomialRing(QQ, 'q')
q = P.gen()
assert 1-2*q-q^2 == -(q^2+2*q-1)
assert (1-2*q-q^2)^2 == (q^2+2*q-1)^2
assert (q^2+2*q-1).roots(QQbar, multiplicities=False) == (
    (1-2*q-q^2)^2).roots(QQbar, multiplicities=False)
print('RESULT: PASS zero equivalence')
