# 対象ラベル: claim_twisted_mode_ratio_root
# (z')^L/z^L = (-1)^twist/(-1)^twist。すべて QQbar の厳密等号。
for L in range(1, 5):
    root = QQbar.zeta(2 * L)
    for twist in (0, 1):
        sign = QQbar(-1) ** twist
        modes = [root ** (twist + 2 * k) for k in range(L)]
        for z in modes:
            for z_prime in modes:
                assert z ** L == sign
                assert z_prime ** L == sign
                assert (z_prime ** L) / (z ** L) == sign / sign
print('PASS: common twisted power for all mode pairs, L=1..4')
