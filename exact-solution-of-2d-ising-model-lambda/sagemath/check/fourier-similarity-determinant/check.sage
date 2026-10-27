# 対象ラベル: claim_fourier_similarity_preserves_determinant
xroots = PolynomialRing(QQbar, 't').gen()
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

R = PolynomialRing(QQbar, 'x')
x = R.gen()
for L in range(1, 4):
    edges = [(i, j, d) for i in range(L) for j in range(L) for d in range(4)]
    for a in (0, 1):
        for b in (0, 1):
            modes = [(v, w, d)
                     for v in (xroots**L - (-1)**a).roots(QQbar, multiplicities=False)
                     for w in (xroots**L - (-1)**b).roots(QQbar, multiplicities=False)
                     for d in range(4)]
            F = matrix(QQbar, len(edges), len(edges),
                       lambda i, j: modes[j][0]**target(edges[i], L)[1] *
                       modes[j][1]**target(edges[i], L)[0]
                       if edges[i][2] == modes[j][2] else 0)
            G = matrix(QQbar, len(edges), len(edges),
                       lambda i, j: QQbar(1) / (L * L) *
                       modes[i][0]**(-target(edges[j], L)[1]) *
                       modes[i][1]**(-target(edges[j], L)[0])
                       if modes[i][2] == edges[j][2] else 0)
            M = matrix(QQbar, len(edges), len(edges),
                       lambda i, j: twist(edges[j], L, a, b) *
                       phase(edges[i][2], edges[j][2])
                       if edges[j][:2] == target(edges[i], L)
                       and edges[j][2] != (edges[i][2] + 2) % 4 else 0)
            B = matrix(QQbar, len(modes), len(modes),
                       lambda i, j: phase(modes[i][2], modes[j][2]) *
                       weight(modes[j][2], modes[i][0], modes[i][1])
                       if modes[i][:2] == modes[j][:2]
                       and modes[j][2] != (modes[i][2] + 2) % 4 else 0)
            assert F * G == identity_matrix(QQbar, len(edges))
            assert F.det() * G.det() == 1
            Fp, Gp, Mp, Bp = (A.change_ring(R) for A in (F, G, M, B))
            T = identity_matrix(R, len(edges)) - x * Bp
            assert Fp * T * Gp == identity_matrix(R, len(edges)) - x * Mp
print('PASS: Fourier similarity and determinant cancellation for L=1..3')
