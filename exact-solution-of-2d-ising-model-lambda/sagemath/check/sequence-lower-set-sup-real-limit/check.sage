# 対象ラベル: claim_sequence_lower_set_sup_eq_real_limit
# 有理数倍の log 2 による証人と、有限個の列の項に対する順序を検算する。
# 実数の極限と下組の上限は有限検算では証明できない。
R = RealField(150)
c = R(2).log()
assert c > 0
for target in (QQ(2), QQ(-3) / 2):
    I = R(target).log() if target > 0 else -R(3).log() / 2
    terms = [I + R((-1)**L) / L for L in range(1, 1001)]
    for gap in (R(1) / 3, R(1) / 7):
        b = I - gap
        r = QQ((b / c + I / c) / 2)
        s = QQ((I / c - r) / 2)
        mu = R(r) * c
        epsilon = R(s) * c
        assert s > 0 and b < mu < mu + epsilon < I
        cutoff = next(N for N in range(1, 800)
                      if all(mu + epsilon < terms[L-1] for L in range(N, 1001)))
        assert all(mu + epsilon < terms[L-1] for L in range(cutoff, 1001))
print('RESULT: PASS')
