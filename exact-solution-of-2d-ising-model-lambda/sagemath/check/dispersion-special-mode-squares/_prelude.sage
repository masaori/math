R = PolynomialRing(QQbar, 'x')
x = R.gen()
def delta(varpi, varsigma):
    return (1 + x^2)^2 - x * (1 - x^2) * (varpi + varpi^(-1) + varsigma + varsigma^(-1))
