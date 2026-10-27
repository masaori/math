# 対象ラベル: def_dual_fourier_matrix_inverse_candidate
for L in range(1, 5):
    edges = [(number, reverse) for number in range(2 * L * L)
             for reverse in (False, True)]
    for a in (0, 1):
        for b in (0, 1):
            root = QQbar.zeta(2 * L)
            modes = [(root ** (a + 2 * k), root ** (b + 2 * m), delta)
                     for k in range(L) for m in range(L) for delta in range(4)]
            kappa = dict(zip(edges, modes))
            assert len(kappa) == len(edges) == len(modes) == 4 * L * L
            dual_entries = {}
            for edge in edges:
                number, reverse = edge
                row, column = divmod(number % (L * L), L)
                horizontal = number < L * L
                direction = (2 if reverse else 0) if horizontal else (3 if reverse else 1)
                if horizontal:
                    target = (row, column) if reverse else (row, (column + 1) % L)
                else:
                    target = (row, column) if reverse else ((row + 1) % L, column)
                for mode in modes:
                    varpi, varsigma, delta = mode
                    dual_entries[mode, edge] = (varpi ** (-target[1]) * varsigma ** (-target[0])
                                                if direction == delta else QQbar(0))
            dual = matrix(QQbar, len(edges), len(edges),
                          lambda i, j: dual_entries[kappa[edges[i]], edges[j]])
            candidate = (QQbar(1) / (L * L)) * dual
            for i, row_edge in enumerate(edges):
                assert list(dual.row(i)) == [dual_entries[kappa[row_edge], edge] for edge in edges]
                for j in range(len(edges)):
                    assert candidate[i, j] == dual[i, j] / (L * L)
print('PASS: dual Fourier matrix and scaled inverse candidate for L=1..4 and all twists')
