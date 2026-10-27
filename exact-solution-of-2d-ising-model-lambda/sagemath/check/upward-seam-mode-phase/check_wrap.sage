# 対象ラベル: claim_upward_seam_mode_phase
# 上向き縦辺が周期端を横切る場合の各等式。L=1 を含む。
R = PolynomialRing(QQbar, 't')
t = R.gen()
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for varpi in (t**L - (-1)**a).roots(QQbar, multiplicities=False):
                for varsigma in (t**L - (-1)**b).roots(QQbar, multiplicities=False):
                    for j in range(L):
                        i = L - 1
                        source_i, source_j = (i + 1) % L, j
                        epsilon = (-1)**(a * 0 + b * 1)
                        lhs = epsilon * varpi**j * varsigma**i
                        assert lhs == (-1)**b * varpi**j * varsigma**(L - 1)
                        assert (-1)**b * varpi**j * varsigma**(L - 1) == varpi**j * ((-1)**b * varsigma**(L - 1))
                        assert varpi**j * ((-1)**b * varsigma**(L - 1)) == varpi**j * varsigma**(-1)
                        assert varpi**j * varsigma**(-1) == varsigma**(-1) * varpi**j
                        assert varsigma**(-1) * varpi**j == varsigma**(-1) * varpi**source_j * varsigma**source_i
