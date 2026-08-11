# 対象ラベル: claim_qbar_evaluation_indeterminate_pow
#
# 主張: w in QQbar と n in NN について aev_w(t^n) = w^n である。
# 人手証明の帰納法の各段を PolynomialRing(QQbar) の厳密計算で確かめる。

R.<t> = PolynomialRing(QQbar)


def poly_pow_rec(f, k):
    acc = R.one()
    for _ in range(k):
        acc = acc * f
    return acc


def qbar_pow_rec(a, k):
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


def aev(w, f):
    total = QQbar(0)
    for k in f.dict():
        total = total + f[k] * qbar_pow_rec(w, k)
    return total


SAMPLE_QBAR = [
    QQbar(0),
    QQbar(1),
    QQbar(-1),
    QQbar(2),
    QQbar(sqrt(2)),
    QQbar(I),
    QQbar(sqrt(2)) - QQbar(1),
    QQbar(-3) / QQbar(2),
    QQbar(sqrt(-3)),
]


def check_base():
    print("1. 出発点（aev_w(t^0) = aev_w(1) = 1 = w^0）")
    for w in SAMPLE_QBAR:
        assert poly_pow_rec(t, 0) == R.one()
        assert aev(w, R.one()) == QQbar(1)
        assert qbar_pow_rec(w, 0) == QQbar(1)
        assert aev(w, poly_pow_rec(t, 0)) == qbar_pow_rec(w, 0)
    print("   通過（標本 %d 個）" % len(SAMPLE_QBAR))


def check_step(nmax):
    print("2. 一歩（aev_w(t^{n+1}) = aev_w(t^n t) = aev_w(t^n)aev_w(t) = w^n w = w^{n+1}）")
    for w in SAMPLE_QBAR:
        for n in range(0, nmax + 1):
            assert poly_pow_rec(t, n + 1) == poly_pow_rec(t, n) * t
            assert aev(w, poly_pow_rec(t, n) * t) == aev(w, poly_pow_rec(t, n)) * aev(w, t)
            assert aev(w, poly_pow_rec(t, n)) == qbar_pow_rec(w, n)
            assert aev(w, t) == w
            assert qbar_pow_rec(w, n + 1) == qbar_pow_rec(w, n) * w
    print("   通過（標本 %d 個、n = 0,...,%d）" % (len(SAMPLE_QBAR), nmax))


def check_claim(nmax):
    print("3. 主張そのもの（aev_w(t^n) = w^n）")
    for w in SAMPLE_QBAR:
        for n in range(0, nmax + 1):
            assert aev(w, poly_pow_rec(t, n)) == qbar_pow_rec(w, n)
    print("   通過（標本 %d 個、n = 0,...,%d）" % (len(SAMPLE_QBAR), nmax))


def main():
    check_base()
    check_step(6)
    check_claim(6)
    print("すべて通過")


main()
