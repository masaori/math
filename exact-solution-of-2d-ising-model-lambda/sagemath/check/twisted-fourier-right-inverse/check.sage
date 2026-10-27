# 対象ラベル: claim_twisted_fourier_right_inverse
for L in range(1, 4):
    edges = [(number, reverse) for number in range(2 * L * L)
             for reverse in (False, True)]
    for a in (0, 1):
        for b in (0, 1):
            root = QQbar.zeta(2 * L)
            horizontal = [root ** (a + 2 * k) for k in range(L)]
            vertical = [root ** (b + 2 * k) for k in range(L)]
            modes = [(varpi, varsigma, delta)
                     for varpi in horizontal for varsigma in vertical
                     for delta in range(4)]
            kappa = dict(zip(edges, modes))
            assert len(kappa) == len(edges) == len(modes)

            def target_direction(edge):
                number, reverse = edge
                row, column = divmod(number % (L * L), L)
                if number < L * L:
                    return ((row, column) if reverse else
                            (row, (column + 1) % L)), (2 if reverse else 0)
                return (((row, column) if reverse else
                         ((row + 1) % L, column)), (3 if reverse else 1))

            assert len({target_direction(edge) for edge in edges}) == len(edges)

            def entry(edge, mode, dual):
                varpi, varsigma, delta = mode
                (row, column), direction = target_direction(edge)
                if direction != delta:
                    return QQbar(0)
                return ((varpi ** (-column) * varsigma ** (-row)) if dual else
                        (varpi ** column * varsigma ** row))

            for e in edges:
                (row_e, column_e), direction_e = target_direction(e)
                for f in edges:
                    (row_f, column_f), direction_f = target_direction(f)
                    sigma_a = (-1) ** a
                    sigma_b = (-1) ** b
                    k_horizontal = column_e + L - column_f
                    k_vertical = row_e + L - row_f
                    horizontal_sum = sum((z ** column_e * z ** (-column_f)
                                          for z in horizontal), QQbar(0))
                    vertical_sum = sum((z ** row_e * z ** (-row_f)
                                        for z in vertical), QQbar(0))
                    assert horizontal_sum == sigma_a * sum(
                        (z ** k_horizontal for z in horizontal), QQbar(0))
                    assert vertical_sum == sigma_b * sum(
                        (z ** k_vertical for z in vertical), QQbar(0))
                    assert horizontal_sum == (L if column_e == column_f else 0)
                    assert vertical_sum == (L if row_e == row_f else 0)
                    inner = sum((entry(e, mode, False) * entry(f, mode, True)
                                 for mode in modes), QQbar(0))
                    expected = ((L * L if (row_e, column_e) == (row_f, column_f)
                                 else 0) if direction_e == direction_f else 0)
                    assert inner == expected
                    assert inner / (L * L) == (1 if e == f else 0)
print('PASS: twisted Fourier right inverse for L=1..3 and all twists')
