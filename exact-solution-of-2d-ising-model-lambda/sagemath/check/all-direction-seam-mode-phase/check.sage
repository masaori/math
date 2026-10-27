# 対象ラベル: claim_all_direction_seam_mode_phase
# 四方向の既証明の等式を、任意の向き付き辺について合成する。
R = PolynomialRing(QQbar, 't')
t = R.gen()
steps = ((0, 1), (1, 0), (0, -1), (-1, 0))
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for varpi in (t**L - (-1)**a).roots(QQbar, multiplicities=False):
                for varsigma in (t**L - (-1)**b).roots(QQbar, multiplicities=False):
                    assert varpi != 0 and varsigma != 0
                    for i in range(L):
                        for j in range(L):
                            for di, dj in steps:
                                target_i, target_j = (i + di) % L, (j + dj) % L
                                epsilon = (-1)**(a * (dj != 0 and (j == L - 1 if dj == 1 else target_j == L - 1))
                                                 + b * (di != 0 and (i == L - 1 if di == 1 else target_i == L - 1)))
                                target = varpi**target_j * varsigma**target_i
                                source = varpi**j * varsigma**i
                                weight = varpi**dj * varsigma**di
                                if (di, dj) == (0, 1):
                                    assert epsilon * target == varpi**(j + 1) * varsigma**i
                                    assert varpi**(j + 1) * varsigma**i == varpi * source
                                if (di, dj) == (1, 0):
                                    assert epsilon * target == varpi**j * varsigma**(i + 1)
                                    assert varpi**j * varsigma**(i + 1) == varsigma * source
                                assert epsilon * target == weight * source
print('PASS: all four directions, L=1..4, four twists and all modes')
