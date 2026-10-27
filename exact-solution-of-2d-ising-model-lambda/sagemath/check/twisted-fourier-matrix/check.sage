# 対象ラベル: def_twisted_fourier_matrix
# κ の列添字への作用と、終点 Fourier ベクトルの成分を照合する。
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
            assert set(kappa.values()) == set(modes)
            vector_entries = {}
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
                    vector_entries[mode, edge] = (varpi ** target[1] * varsigma ** target[0]
                                                  if direction == delta else QQbar(0))
            fourier = matrix(QQbar, len(edges), len(edges),
                             lambda i, j: vector_entries[kappa[edges[j]], edges[i]])
            assert fourier.nrows() == fourier.ncols() == 4 * L * L
            for j, column_edge in enumerate(edges):
                mode = kappa[column_edge]
                assert list(fourier.column(j)) == [vector_entries[mode, edge] for edge in edges]
                assert sum(fourier[i, j] != 0 for i in range(len(edges))) == L * L
print('PASS: Fourier matrix entries for L=1..4 and all twists')
