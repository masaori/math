# The rational-function calculation proves each polynomial identity for arbitrary nonzero modes.
R = PolynomialRing(QQ, names=('x', 'w', 's'))
x, w, s = R.gens()
F = R.fraction_field()
x, w, s = F(x), F(w), F(s)
mode_sum = w + 1/w + s + 1/s
dispersion = (1 + x^2)^2 - x*(1 - x^2)*mode_sum
