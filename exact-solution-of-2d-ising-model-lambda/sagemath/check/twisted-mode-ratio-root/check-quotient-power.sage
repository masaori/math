# 対象ラベル: claim_twisted_mode_ratio_root
# (z'/z)^L = (z')^L/z^L。すべて QQbar の厳密等号。
for L in range(1, 5):
    root = QQbar.zeta(2 * L)
    for twist in (0, 1):
        modes = [root ** (twist + 2 * k) for k in range(L)]
        for z in modes:
            for z_prime in modes:
                assert z != 0
                assert (z_prime / z) ** L == (z_prime ** L) / (z ** L)
print('PASS: quotient power for all twisted mode pairs, L=1..4')
