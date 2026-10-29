R = PolynomialRing(QQbar, 'x')
x = R.gen()

def delta(varpi, varsigma):
    return (1 + x^2)^2 - x * (1 - x^2) * (varpi + varpi^(-1) + varsigma + varsigma^(-1))

def modes(length, twist):
    T = PolynomialRing(QQbar, 't')
    t = T.gen()
    return [root for root, multiplicity in (t^length - (-1)^twist).roots(QQbar)]

def orbit(point):
    varpi, varsigma = point
    return frozenset(((varpi, varsigma), (varpi^(-1), varsigma),
                      (varpi, varsigma^(-1)), (varpi^(-1), varsigma^(-1))))

def orbit_factors(length, a, b):
    points = {(varpi, varsigma) for varpi in modes(length, a) for varsigma in modes(length, b)}
    orbits = {orbit(point) for point in points}
    return points, orbits
