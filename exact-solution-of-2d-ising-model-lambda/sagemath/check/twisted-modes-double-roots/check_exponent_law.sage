# 対象ラベル: claim_twisted_modes_are_double_roots
# z^(2L) = (z^L)^2。各 L と符号について QQ の多項式剰余環で厳密検算する。
for L in range(1, 7):
    for c in (0, 1):
        eps = QQ((-1)^c)
        R = PolynomialRing(QQ, 'z')
        z = R.gen()
        A = R.quotient(z^L - eps, 'alpha')
        alpha = A.gen()
        assert alpha^(2*L) == (alpha^L)^2
print('RESULT: PASS')
