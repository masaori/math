# 対象ラベル: claim_qbar_finite_root_multiplicity_sum_le_coeff_bound

R.<t> = PolynomialRing(QQbar)


def divides(d, f):
    _, r = f.quo_rem(d)
    return r == R.zero()


def mult(w, f):
    assert f != R.zero()
    n = f.degree()
    return max(k for k in range(n + 1) if divides((t - R(w)) ** k, f))


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3,
          QQbar.zeta(3), QQbar(2).sqrt()]
    polynomials = [
        R.one(),
        t,
        (t - 1) ** 2,
        (t + 1) ** 3 * (t - QQbar(2) / 3),
        (t - QQbar.zeta(3)) ** 2 * (t - QQbar(2).sqrt()) ** 3,
        (t - 1) ** 2 * (t + 1) ** 3 * (t ** 2 + 1),
    ]

    print("1. 有限集合上の重複度の和は係数の上界を超えない")
    for f in polynomials:
        n = f.degree()
        for mask in range(1 << len(ws)):
            s = [w for i, w in enumerate(ws) if mask & (1 << i)]
            assert sum(mult(w, f) for w in s) <= n
    print("   通過")

    print("2. 一次因子を一つ割り出す帰納法の一歩")
    for f in polynomials:
        n = f.degree()
        if n == 0:
            continue
        for w0 in ws:
            if mult(w0, f) == 0:
                continue
            g, remainder = f.quo_rem(t - R(w0))
            assert remainder == R.zero() and g != R.zero()
            assert g.degree() <= n - 1
            assert mult(w0, f) <= mult(w0, g) + 1
            for w in ws:
                if w != w0:
                    assert mult(w, f) <= mult(w, g)
    print("   通過")


main()
