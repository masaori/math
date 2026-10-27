# 対象ラベル: claim_edge_mode_index_bijection
for L in range(1, 5):
    edges = [(edge, orientation) for edge in range(2 * L * L)
             for orientation in (0, 1)]
    for a in (0, 1):
        for b in (0, 1):
            root = QQbar.zeta(2 * L)
            modes = [(root ** (a + 2 * i), root ** (b + 2 * j), direction)
                     for i in range(L) for j in range(L)
                     for direction in range(4)]
            assert len(edges) == len(modes) == 4 * L * L
            assert len(set(edges)) == len(edges)
            assert len(set(modes)) == len(modes)
            correspondence = dict(zip(edges, modes))
            assert len(correspondence) == len(edges)
            assert set(correspondence.values()) == set(modes)
            for varpi, varsigma, direction in modes:
                assert varpi ** L == (-1) ** a
                assert varsigma ** L == (-1) ** b
                assert 0 <= direction < 4
print('PASS: an edge-mode index bijection exists for L=1..4 and all twists')
