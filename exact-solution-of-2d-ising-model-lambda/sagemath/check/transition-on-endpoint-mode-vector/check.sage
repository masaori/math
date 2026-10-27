# 対象ラベル: claim_transition_on_endpoint_mode_vector
# 本文の各等号を円分体に含まれる代数的数の厳密等号で照合する。
R = PolynomialRing(QQbar, 't')
t = R.gen()
steps = ((0, 1), (1, 0), (0, -1), (-1, 0))
zeta = QQbar.zeta(8)

def target(edge, L):
    i, j, direction = edge
    di, dj = steps[direction]
    return ((i + di) % L, (j + dj) % L)

def phase(direction, following):
    if following == direction:
        return QQbar(1)
    if following == (direction + 1) % 4:
        return zeta
    if following == (direction - 1) % 4:
        return zeta**(-1)
    return QQbar(0)

def twist(edge, L, a, b):
    i, j, direction = edge
    if direction == 0:
        return (-1)**(a * (j == L - 1))
    if direction == 2:
        return (-1)**(a * (j == 0))
    if direction == 1:
        return (-1)**(b * (i == L - 1))
    return (-1)**(b * (i == 0))

def weight(direction, varpi, varsigma):
    di, dj = steps[direction]
    return varpi**dj * varsigma**di

for L in range(1, 4):
    edges = [(i, j, d) for i in range(L) for j in range(L) for d in range(4)]
    for a in (0, 1):
        for b in (0, 1):
            for varpi in (t**L - (-1)**a).roots(QQbar, multiplicities=False):
                for varsigma in (t**L - (-1)**b).roots(QQbar, multiplicities=False):
                    for e in edges:
                        i, j = target(e, L)
                        direction = e[2]
                        successors = [f for f in edges if f[:2] == (i, j)
                                      and f[2] != (direction + 2) % 4]
                        for d in range(4):
                            vector = lambda f: varpi**target(f, L)[1] * varsigma**target(f, L)[0] if f[2] == d else QQbar(0)
                            full_sum = sum((twist(f, L, a, b) * phase(direction, f[2]) * vector(f)
                                            for f in successors), QQbar(0))
                            small = phase(direction, d) * weight(d, varpi, varsigma) if d != (direction + 2) % 4 else QQbar(0)
                            base = varpi**j * varsigma**i
                            if d == (direction + 2) % 4:
                                assert all(vector(f) == 0 for f in successors)
                                assert full_sum == 0 == small * base
                            else:
                                selected = [f for f in successors if f[2] == d]
                                assert len(selected) == 1
                                f = selected[0]
                                single = twist(f, L, a, b) * phase(direction, d) * vector(f)
                                assert full_sum == single
                                assert single == phase(direction, d) * twist(f, L, a, b) * vector(f)
                                assert twist(f, L, a, b) * vector(f) == weight(d, varpi, varsigma) * base
                                assert single == small * base
                            assert full_sum == small * base
print('PASS: transition on endpoint Fourier vectors for all L=1..3, spins, modes, edges, directions')
