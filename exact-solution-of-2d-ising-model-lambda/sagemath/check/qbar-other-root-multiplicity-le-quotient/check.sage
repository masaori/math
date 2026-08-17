# 対象ラベル: claim_qbar_other_root_multiplicity_le_quotient

R.<t> = PolynomialRing(QQbar)


def top_index(f):
    assert f != R.zero()
    return max(i for i, c in enumerate(f.coefficients(sparse=False)) if c != 0)


def divides(d, f):
    _, r = f.quo_rem(d)
    return r == R.zero()


def mult(w, f):
    assert f != R.zero()
    return max(k for k in range(top_index(f) + 1) if divides((t - R(w)) ** k, f))


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    gs = [R.one(), t, t ** 2 + 1, 3 * t - 2,
          (t - QQbar(1)) ** 2,
          (t - QQbar(2) / 3) ** 3 * (t - QQbar(2).sqrt()),
          (t - QQbar.zeta(3)) ** 2 * (t ** 2 + 1)]

    print("1. w != w' と f=(t-w')g の全組で f,g は非零")
    for w in ws:
        for wp in ws:
            if w == wp:
                continue
            for g in gs:
                f = (t - R(wp)) * g
                assert f != R.zero() and g != R.zero()
    print("   通過")

    print("2. (t-w)^M | f から互いに素な因子 (t-w') を落として (t-w)^M | g")
    for w in ws:
        for wp in ws:
            if w == wp:
                continue
            for g in gs:
                f = (t - R(wp)) * g
                M = mult(w, f)
                assert divides((t - R(w)) ** M, f)
                assert divides((t - R(w)) ** M, g)
                assert M <= mult(w, g)
    print("   通過")

    print("3. 実際には相異なる一次因子を掛けても w の重複度は変わらない")
    for w in ws:
        for wp in ws:
            if w == wp:
                continue
            for g in gs:
                f = (t - R(wp)) * g
                assert mult(w, f) == mult(w, g)
    print("   通過")


main()
