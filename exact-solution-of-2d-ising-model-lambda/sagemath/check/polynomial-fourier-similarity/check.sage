# 対象ラベル: claim_polynomial_fourier_similarity
load('sagemath/check/transition-fourier-intertwining/check.sage')

R = PolynomialRing(QQbar, 'x')
x = R.gen()
for L in range(1, 4):
    edges = [(i, j, d) for i in range(L) for j in range(L) for d in range(4)]
    for a in (0, 1):
        for b in (0, 1):
            modes = [(v, w, d)
                     for v in (t**L - (-1)**a).roots(QQbar, multiplicities=False)
                     for w in (t**L - (-1)**b).roots(QQbar, multiplicities=False)
                     for d in range(4)]
            F = matrix(QQbar, len(edges), len(edges),
                       lambda i, j: modes[j][0]**target(edges[i], L)[1] *
                       modes[j][1]**target(edges[i], L)[0]
                       if edges[i][2] == modes[j][2] else 0)
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
            G = matrix(QQbar, len(edges), len(edges),
                       lambda i, j: QQbar(1) / (L * L) *
                       modes[i][0]**(-target(edges[j], L)[1]) *
                       modes[i][1]**(-target(edges[j], L)[0])
                       if modes[i][2] == edges[j][2] else 0)
            Fp, Gp, Mp, Bp = (A.change_ring(R) for A in (F, G, M, B))
            I = identity_matrix(R, len(edges))
            assert Gp * Fp == I
            assert Fp * Gp == I
            assert Mp * Fp == Fp * Bp
            assert Fp * (I - x * Bp) * Gp == I - x * Mp
print('PASS: polynomial Fourier similarity for L=1..3 and all spin structures')
