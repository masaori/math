# 対象ラベル: claim_twisted_mode_power_sum
# 対象: ねじれたモードの和を一の冪根の和へ再添字付けする等号
# 帰属: QQbar
for L in range(1, 7):
    roots = [QQbar.zeta(L) ** j for j in range(L)]
    for twist in (0, 1):
        xi = QQbar(1) if twist == 0 else QQbar.zeta(2 * L)
        assert xi ** L == (-1) ** twist
        modes = [z for z in [QQbar.zeta(2 * L) ** j for j in range(2 * L)]
                 if z ** L == (-1) ** twist]
        assert len(modes) == L
        assert set(modes) == set(xi * y for y in roots)
        for k in range(2 * L + 4):
            assert sum((z ** k for z in modes), QQbar(0)) == sum(
                ((xi * y) ** k for y in roots), QQbar(0))
print('RESULT: PASS — coset reindexing over QQbar')
