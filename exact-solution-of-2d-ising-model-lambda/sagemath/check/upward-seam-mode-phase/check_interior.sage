# 対象ラベル: claim_upward_seam_mode_phase
# 上向き縦辺が切断線を横切らない場合の各等式。
R = PolynomialRing(QQbar, 't')
t = R.gen()
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for varpi in (t**L - (-1)**a).roots(QQbar, multiplicities=False):
                for varsigma in (t**L - (-1)**b).roots(QQbar, multiplicities=False):
                    for j in range(L):
                        for i in range(L - 1):
                            source_i, source_j = (i + 1) % L, j
                            epsilon = (-1)**(a * 0 + b * 0)
                            lhs = epsilon * varpi**j * varsigma**i
                            assert lhs == 1 * varpi**j * varsigma**i
                            assert 1 * varpi**j * varsigma**i == varsigma**(-1) * varpi**j * varsigma**(i + 1)
                            assert varsigma**(-1) * varpi**j * varsigma**(i + 1) == varsigma**(-1) * varpi**source_j * varsigma**source_i
