# 対象ラベル: claim_twist_sign_nonzero
# ℤ→QQbar→QQbar[x] の定数埋込みは、二つの符号を零へ送らない。
R = PolynomialRing(QQbar, 'x')
for sign in (ZZ(-1), ZZ(1)):
    embedded = R(QQbar(sign))
    assert embedded != R.zero()
