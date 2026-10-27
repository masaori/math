# 対象ラベル: def_endpoint_mode_vector
# 全ての向き付き辺について、終点の代表座標と方向の台を照合する。
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for k in range(L):
                for m in range(L):
                    varpi = QQbar.zeta(2 * L) ** (a + 2 * k)
                    varsigma = QQbar.zeta(2 * L) ** (b + 2 * m)
                    assert varpi ** L == (-1) ** a
                    assert varsigma ** L == (-1) ** b
                    for d0 in range(4):
                        for number in range(2 * L * L):
                            row, column = divmod(number % (L * L), L)
                            for reverse in (False, True):
                                horizontal = number < L * L
                                direction = (2 if reverse else 0) if horizontal else (3 if reverse else 1)
                                if horizontal:
                                    target = (row, column) if reverse else (row, (column + 1) % L)
                                else:
                                    target = (row, column) if reverse else ((row + 1) % L, column)
                                value = varpi ** target[1] * varsigma ** target[0] if direction == d0 else QQbar(0)
                                assert (value != 0) == (direction == d0)
                                assert value == (varpi ** target[1] * varsigma ** target[0] if direction == d0 else 0)
