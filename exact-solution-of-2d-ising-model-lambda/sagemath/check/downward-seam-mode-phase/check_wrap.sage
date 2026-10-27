# 対象ラベル: claim_downward_seam_mode_phase
# 下向き縦辺が周期端を横切る場合の各等式。L=1 を含む。
R = PolynomialRing(QQbar, 't')
t = R.gen()
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for varpi in (t**L - (-1)**a).roots(QQbar, multiplicities=False):
                for varsigma in (t**L - (-1)**b).roots(QQbar, multiplicities=False):
                    for j in range(L):
                        i = L - 1
                        target_i, target_j = (i + 1) % L, j
                        epsilon = (-1)**(a * 0 + b * 1)
                        lhs = epsilon * varpi**target_j * varsigma**target_i
                        assert lhs == (-1)**b * varpi**j * varsigma**0
                        assert (-1)**b * varpi**j * varsigma**0 == varpi**j * ((-1)**b * varsigma**0)
                        assert varpi**j * ((-1)**b * varsigma**0) == varpi**j * varsigma**L
                        assert varpi**j * varsigma**L == varpi**j * varsigma**(i + 1)
