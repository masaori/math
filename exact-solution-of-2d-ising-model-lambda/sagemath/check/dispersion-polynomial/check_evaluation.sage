# 対象ラベル: def_dispersion_polynomial
# 分散因子が QQbar[x] に属し、評価値が QQbar の表示式に一致する。
R.<x> = PolynomialRing(QQbar)
varpi = QQbar.zeta(5)
varsigma = QQbar.zeta(7)
q = QQbar(2) / 5
Delta = (1 + x^2)^2 - x*(1 - x^2)*(varpi + varpi^(-1) + varsigma + varsigma^(-1))
assert Delta.parent() == R
assert Delta(q) == (1 + q^2)^2 - q*(1 - q^2)*(varpi + varpi^(-1) + varsigma + varsigma^(-1))
print('RESULT: PASS')
