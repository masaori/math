# 対象ラベル: claim_twisted_fourier_left_inverse
for L in range(1, 4):
    edges = [(number, reverse) for number in range(2 * L * L)
             for reverse in (False, True)]
    for a in (0, 1):
        for b in (0, 1):
            root = QQbar.zeta(2 * L)
            modes = [(root ** (a + 2 * k), root ** (b + 2 * m), delta)
                     for k in range(L) for m in range(L) for delta in range(4)]
            kappa = dict(zip(edges, modes))
            assert len(kappa) == len(edges) == len(modes)
            target_and_direction = {}
            for edge in edges:
                number, reverse = edge
                row, column = divmod(number % (L * L), L)
                horizontal = number < L * L
                direction = (2 if reverse else 0) if horizontal else (3 if reverse else 1)
                if horizontal:
                    target = (row, column) if reverse else (row, (column + 1) % L)
                else:
                    target = (row, column) if reverse else ((row + 1) % L, column)
                target_and_direction[edge] = (target, direction)

            def mode_entry(edge, mode, dual):
                varpi, varsigma, delta = mode
                (row, column), direction = target_and_direction[edge]
                if direction != delta:
                    return QQbar(0)
                power = -1 if dual else 1
                return varpi ** (power * column) * varsigma ** (power * row)

            fourier = matrix(QQbar, len(edges), len(edges),
                             lambda i, j: mode_entry(edges[i], kappa[edges[j]], False))
            inverse_candidate = matrix(QQbar, len(edges), len(edges),
                                       lambda i, j: mode_entry(edges[j], kappa[edges[i]], True) / (L * L))
            product = inverse_candidate * fourier
            for i, g in enumerate(edges):
                for j, h in enumerate(edges):
                    inner = sum((mode_entry(e, kappa[g], True) * mode_entry(e, kappa[h], False)
                                 for e in edges), QQbar(0))
                    assert inner == (L * L if g == h else 0)
                    assert product[i, j] == (1 if g == h else 0)
print('PASS: twisted Fourier left inverse for L=1..3 and all twists')
