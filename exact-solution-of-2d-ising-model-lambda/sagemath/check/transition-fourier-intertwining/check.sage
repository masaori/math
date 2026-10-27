# 対象ラベル: claim_transition_fourier_intertwining
# M F = F B を辺長一から三の全てのスピン構造で QQbar の厳密等号として検証する。
load('sagemath/check/transition-on-endpoint-mode-vector/check.sage')

for L in range(1, 4):
    edges = [(i, j, d) for i in range(L) for j in range(L) for d in range(4)]
    for a in (0, 1):
        for b in (0, 1):
            modes = [(v, w, d)
                     for v in (t**L - (-1)**a).roots(QQbar, multiplicities=False)
                     for w in (t**L - (-1)**b).roots(QQbar, multiplicities=False)
                     for d in range(4)]
            assert len(modes) == len(edges)
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
            for i in range(len(edges)):
                for j in range(len(edges)):
                    lhs = sum((M[i, k] * F[k, j] for k in range(len(edges))), QQbar(0))
                    rhs = sum((F[i, k] * B[k, j] for k in range(len(edges))), QQbar(0))
                    v, w, d = modes[j]
                    direction = edges[i][2]
                    small = phase(direction, d) * weight(d, v, w) if d != (direction + 2) % 4 else QQbar(0)
                    base = v**target(edges[i], L)[1] * w**target(edges[i], L)[0]
                    selected = [k for k in range(len(edges))
                                if modes[k] == (v, w, direction)]
                    assert len(selected) == 1
                    assert lhs == small * base
                    assert rhs == F[i, selected[0]] * B[selected[0], j]
                    assert rhs == base * small
                    assert lhs == rhs
print('PASS: M F = F B for all L=1..3 and spin structures')
