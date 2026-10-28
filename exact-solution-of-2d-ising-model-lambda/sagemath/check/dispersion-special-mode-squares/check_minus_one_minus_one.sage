import os
load(os.path.join(directory, '_prelude.sage'))
# claim_dispersion_special_mode_squares: (-1,-1), definition and two algebraic steps.
a = delta(QQbar(-1), QQbar(-1))
b = (1+x^2)^2 - x*(1-x^2)*(-1-1-1-1)
c = (1+x^2)^2 + 4*x*(1-x^2)
d = (1+2*x-x^2)^2
assert a == b
assert b == c
assert c == d
