# 対象ラベル: def_fourier_mode_index_set
# 各ねじれの二つのモード集合と四方向の直積を厳密に照合する。
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            root = QQbar.zeta(2 * L)
            horizontal = {root ** (a + 2 * k) for k in range(L)}
            vertical = {root ** (b + 2 * k) for k in range(L)}
            modes = {(varpi, varsigma, delta)
                     for varpi in horizontal
                     for varsigma in vertical
                     for delta in range(4)}
            assert len(horizontal) == L
            assert len(vertical) == L
            assert len(modes) == 4 * L * L
            for varpi, varsigma, delta in modes:
                assert varpi ** L == (-1) ** a
                assert varsigma ** L == (-1) ** b
                assert 0 <= delta < 4
