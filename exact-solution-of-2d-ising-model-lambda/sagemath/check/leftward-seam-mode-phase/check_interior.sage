# 対象ラベル: claim_leftward_seam_mode_phase
# 左向き横辺が切断線を横切らない場合の各等式。
R = PolynomialRing(QQbar, 't')
t = R.gen()
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for varpi in (t**L - (-1)**a).roots(QQbar, multiplicities=False):
                for varsigma in (t**L - (-1)**b).roots(QQbar, multiplicities=False):
                    for i in range(L):
                        for j in range(L - 1):
                            source_i, source_j = i, (j + 1) % L
                            epsilon = (-1)**(a * 0 + b * 0)
                            lhs = epsilon * varpi**j * varsigma**i
                            assert lhs == 1 * varpi**j * varsigma**i
                            assert 1 * varpi**j * varsigma**i == varpi**(-1) * varpi**(j + 1) * varsigma**i
                            assert varpi**(-1) * varpi**(j + 1) * varsigma**i == varpi**(-1) * varpi**source_j * varsigma**source_i
