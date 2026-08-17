# 対象ラベル: claim_qbar_root_multiplicity_ge_one_iff_root


R.<t> = PolynomialRing(QQbar)


def support(f):
    return [i for i in range(f.degree() + 1) if f[i] != 0]


def divides_pow(w, k, f):
    """(t - w)^k が f を割り切るか（商が多項式であるかで判定する）。"""
    lin = t - R(w)
    q, r = f.quo_rem(lin^k)
    return r == R.zero()


def mult(w, f):
    """mult_w(f) := max{ k | (t-w)^k ∣ f }。f ≠ 0 の非零係数の番号の最大元まで探せば足りる。"""
    n_f = max(support(f))
    ks = [k for k in range(n_f + 1) if divides_pow(w, k, f)]
    assert len(ks) >= 1
    return max(ks)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    fs = [
        R.one(),
        t^3 - 2 * t + 1,
        (QQbar.zeta(5)) * t^4 + t^2 - QQbar(7),
        (t - 1) * (t - QQbar.zeta(3)),
        QQbar(3) * t,
        (t - QQbar(2) / 3)^3 * (t - QQbar(2).sqrt()),
        (t - QQbar.zeta(3))^2 * (t^2 + 1),
    ]

    print("1. 準備: aev_w(t - w) = aev_w(t) - aev_w(w) = w - w = 0")
    for w in ws:
        lin = t - R(w)
        assert lin(w) == w - w
        assert lin(w) == QQbar(0)
    print("   通過")

    print("2. mult ≥ 1 ⇒ aev_w(f) = 0（鎖 aev_w(f) = aev_w((t-w)^m·(t-w)·g) = ... · 0 · ... = 0）")
    for w in ws:
        lin = t - R(w)
        for f in fs:
            assert f != R.zero()
            k = mult(w, f)
            if k >= 1:
                m = k - 1
                g = f.quo_rem(lin^k)[0]
                assert f == lin^k * g
                assert lin^k == lin^m * lin
                assert f(w) == (lin^m * lin * g)(w)
                assert (lin^m * lin * g)(w) == (lin^m)(w) * lin(w) * g(w)
                assert (lin^m)(w) * lin(w) * g(w) == (lin^m)(w) * QQbar(0) * g(w)
                assert f(w) == QQbar(0)
    print("   通過")

    print("3. aev_w(f) = 0 ⇒ (t-w)^1 ∣ f、よって mult ≥ 1")
    for w in ws:
        for f in fs:
            if f(w) == QQbar(0):
                n_f = max(support(f))
                for i in range(n_f + 1, n_f + 5):
                    assert f[i] == 0
                assert divides_pow(w, 1, f)
                assert mult(w, f) >= 1
    print("   通過")

    print("4. 同値そのもの: mult_w(f) ≥ 1 ⇔ aev_w(f) = 0")
    for w in ws:
        for f in fs:
            assert (mult(w, f) >= 1) == (f(w) == QQbar(0))
    print("   通過")


main()
