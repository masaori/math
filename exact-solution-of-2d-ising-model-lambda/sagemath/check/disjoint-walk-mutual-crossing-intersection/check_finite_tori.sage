# 対象ラベル: claim_disjoint_walk_mutual_crossing_intersection
# 辺長一から三で、辺を共有しない偶辺鎖の局所横断数と交差形式を検査する。
load('sagemath/check/even-edge-chain-intersection/defs.sage')

for L in (1, 2, 3):
    generators = [horizontal(L), vertical(L)] + [square(L, i, j) for i in range(L) for j in range(L)]
    chains = {frozenset()}
    for generator in generators:
        chains |= {frozenset(set(C).symmetric_difference(generator)) for C in list(chains)}
    for C0 in chains:
        C = set(C0)
        for D0 in chains:
            D = set(D0)
            if C & D:
                continue
            crossings = 0
            for i in range(L):
                for j in range(L):
                    c_left = edge_key(L, 'H', i, j - 1) in C
                    c_right = edge_key(L, 'H', i, j) in C
                    c_up = edge_key(L, 'V', i - 1, j) in C
                    c_down = edge_key(L, 'V', i, j) in C
                    d_left = edge_key(L, 'H', i, j - 1) in D
                    d_right = edge_key(L, 'H', i, j) in D
                    d_up = edge_key(L, 'V', i - 1, j) in D
                    d_down = edge_key(L, 'V', i, j) in D
                    crossings += ZZ(c_left and c_right and d_up and d_down)
                    crossings += ZZ(d_left and d_right and c_up and c_down)
            hC, vC = seams(L, C)
            hD, vD = seams(L, D)
            assert crossings % 2 == intersect(L, C, D)
            assert crossings % 2 == (hC * vD + vC * hD) % 2
print('RESULT: PASS finite torus parity')
