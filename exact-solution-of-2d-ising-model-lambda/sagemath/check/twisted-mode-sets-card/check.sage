# 対象ラベル: claim_twisted_mode_sets_card
# 有限の辺長で、乗法平行移動の単射性と横・縦のモード数を厳密に照合する。
for L in range(1, 7):
    roots = [QQbar.zeta(L) ** k for k in range(L)]
    xi = QQbar.zeta(2 * L)
    assert xi ** L == -1
    shifted = [xi * z for z in roots]
    assert len(set(roots)) == L
    assert len(set(shifted)) == L
    for twist in (0, 1):
        expected = 1 if twist == 0 else -1
        modes = [z for z in [QQbar.zeta(2 * L) ** k for k in range(2 * L)]
                 if z ** L == expected]
        assert len(set(modes)) == L
        assert set(modes) == set(roots if twist == 0 else shifted)
