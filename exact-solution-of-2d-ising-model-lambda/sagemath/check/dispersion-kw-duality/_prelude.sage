# 対象ラベル: claim_dispersion_kw_duality
P = PolynomialRing(QQ, names=('x', 'p', 's'))
x, p, s = P.gens()
F = P.fraction_field()
x, p, s = map(F, (x, p, s))
kw = (1 - x)/(1 + x)
mode_sum = p + 1/p + s + 1/s
def dispersion(y):
    return (1 + y^2)^2 - y*(1 - y^2)*mode_sum
