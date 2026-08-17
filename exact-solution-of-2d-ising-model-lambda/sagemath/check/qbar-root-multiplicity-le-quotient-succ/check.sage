# 対象ラベル: claim_qbar_root_multiplicity_le_quotient_succ


R.<t> = PolynomialRing(QQbar)


def top_index(f):
    """非零多項式の非零係数の番号の最大元（def_qbar_root_multiplicity の n_f）。"""
    assert f != R.zero()
    cs = f.coefficients(sparse=False)
    return max(i for i, c in enumerate(cs) if c != 0)


def divides(d, f):
    _, r = f.quo_rem(d)
    return r == R.zero()


def mult(w, f):
    """重複度（(t-w)^k で割り切れる k の最大元。上界は n_f）。"""
    assert f != R.zero()
    n = top_index(f)
    ks = [k for k in range(0, n + 1) if divides((t - R(w)) ** k, f)]
    return max(ks)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    gs = [
        R.one(),
        t,
        t ** 2 + 1,
        3 * t - 2,
        (t - QQbar(1)) ** 2,
        (t - QQbar(2) / 3) ** 3 * (t - QQbar(2).sqrt()),
        (t - QQbar.zeta(3)) ** 2 * (t ** 2 + 1),
    ]

    print("1. g != 0 かつ f = (t-w)g なら f != 0")
    for w in ws:
        for g in gs:
            f = (t - R(w)) * g
            assert g != R.zero()
            assert f != R.zero()
    print("   通過")

    print("2. mult_w(f) <= mult_w(g) + 1")
    for w in ws:
        for g in gs:
            f = (t - R(w)) * g
            assert mult(w, f) <= mult(w, g) + 1
    print("   通過")

    print("3. M >= 1 のとき (t-w)^{M-1} h = g（一次因子の消去）")
    for w in ws:
        for g in gs:
            f = (t - R(w)) * g
            M = mult(w, f)
            if M < 1:
                continue
            Mp = M - 1
            h, r = f.quo_rem((t - R(w)) ** (Mp + 1))
            assert r == R.zero()
            # (t-w)((t-w)^{M'}h) = (t-w)^{M'+1}h = f = (t-w)g
            assert (t - R(w)) * ((t - R(w)) ** Mp * h) == (t - R(w)) ** (Mp + 1) * h
            assert (t - R(w)) ** (Mp + 1) * h == f
            assert f == (t - R(w)) * g
            # 消去して等式そのものを得る
            assert (t - R(w)) ** Mp * h == g
            assert divides((t - R(w)) ** Mp, g)
            assert Mp <= mult(w, g)
    print("   通過")

    print("4. 実際には等号 mult_w(f) = mult_w(g) + 1 が成り立つ（上界が最良であること）")
    for w in ws:
        for g in gs:
            f = (t - R(w)) * g
            assert mult(w, f) == mult(w, g) + 1
    print("   通過")


main()
