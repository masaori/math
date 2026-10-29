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

def fixed_factor(point):
    varpi, varsigma = point
    if (varpi, varsigma) == (1, 1):
        return 1 - 2*x - x^2
    if (varpi, varsigma) == (-1, -1):
        return 1 + 2*x - x^2
    assert (varpi, varsigma) in ((1, -1), (-1, 1))
    return 1 + x^2

def orbit_data(length, a, b):
    points = {(varpi, varsigma) for varpi in modes(length, a) for varsigma in modes(length, b)}
    return points, {orbit(point) for point in points}

def orbit_products(length, a, b):
    points, orbits = orbit_data(length, a, b)
    fixed = [next(iter(group)) for group in orbits if len(group) == 1]
    paired = [next(iter(group)) for group in orbits if len(group) == 2]
    quadrupled = [next(iter(group)) for group in orbits if len(group) == 4]
    factors = [fixed_factor(point) for point in fixed]
    factors += [delta(*point) for point in paired]
    factors += [delta(*point)^2 for point in quadrupled]
    return points, orbits, factors, fixed, paired, quadrupled
