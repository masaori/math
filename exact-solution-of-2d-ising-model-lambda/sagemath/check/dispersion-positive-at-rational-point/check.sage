R = PolynomialRing(QQ, names=('q', 'alpha', 'beta', 'gamma', 'delta'))
q, alpha, beta, gamma, delta = R.gens()
S = R['w'].quotient(R['w'].gen()^2 + 1, 'w')
w = S.gen()
u = S(alpha + beta*w)
v = S(gamma + delta*w)
u_inv = S(alpha - beta*w)
v_inv = S(gamma - delta*w)
assert (u*u_inv - 1) == S(alpha^2 + beta^2 - 1)
assert (v*v_inv - 1) == S(gamma^2 + delta^2 - 1)
assert S(2) - u - u_inv == S((1-alpha)^2 + beta^2 - (alpha^2 + beta^2 - 1))
assert S(2) - v - v_inv == S((1-gamma)^2 + delta^2 - (gamma^2 + delta^2 - 1))
D = (1+q^2)^2 - q*(1-q^2)*(u+u_inv+v+v_inv)
assert D - S((q^2+2*q-1)^2) == S(q*(1-q^2))*((S(2)-u-u_inv)+(S(2)-v-v_inv))
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for j in range(length):
                for k in range(length):
                    root_u = QQbar.zeta(2*length)^(2*j+a)
                    root_v = QQbar.zeta(2*length)^(2*k+b)
                    for point in (QQ(1)/5, QQ(1)/2, QQ(4)/5):
                        value = (1+point^2)^2-point*(1-point^2)*(root_u+root_u^(-1)+root_v+root_v^(-1))
                        assert value.imag() == 0
                        assert value.real() >= (point^2+2*point-1)^2 > 0
print('RESULT: PASS dispersion positive at rational point')
