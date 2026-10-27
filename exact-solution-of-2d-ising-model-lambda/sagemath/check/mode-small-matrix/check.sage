# 対象ラベル: def_mode_small_matrix
# 四方向の定義式を円分体内で評価し、明示した行列と照合する。
zeta = QQbar.zeta(8)
step = [(0, 1), (1, 0), (0, -1), (-1, 0)]
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for k in range(L):
                for m in range(L):
                    varpi = QQbar.zeta(2 * L) ** (a + 2 * k)
                    varsigma = QQbar.zeta(2 * L) ** (b + 2 * m)
                    assert varpi ** L == (-1) ** a
                    assert varsigma ** L == (-1) ** b
                    weights = [varpi, varsigma, varpi ** (-1), varsigma ** (-1)]
                    assert weights == [varpi ** column * varsigma ** row for row, column in step]
                    for d in range(4):
                        for e in range(4):
                            if e == d:
                                phase = QQbar(1)
                            elif e == (d + 1) % 4:
                                phase = zeta
                            elif e == (d - 1) % 4:
                                phase = zeta ** (-1)
                            else:
                                phase = QQbar(0)
                            assert phase * weights[e] == (QQbar(0) if e == (d + 2) % 4 else phase * varpi ** step[e][1] * varsigma ** step[e][0])
