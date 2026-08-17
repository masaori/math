# 対象ラベル: claim_qbar_linear_factor_pow_divides_exponent_le


R.<t> = PolynomialRing(QQbar)


def support(g):
    return [i for i in range(g.degree() + 1) if g[i] != 0]


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    gs = [
        R.one(),
        t^3 - 2 * t + 1,
        (QQbar.zeta(5)) * t^4 + t^2 - QQbar(7),
        (t - 1) * (t - QQbar.zeta(3)),
        QQbar(3) * t,
    ]

    print("1. 準備: g ≠ 0 の非零係数の番号の集合 S(g) は空でなく有限、最大元 m で ac_m(g) ≠ 0、i > m ⇒ ac_i(g) = 0")
    for g in gs:
        S = support(g)
        assert len(S) >= 1
        m = max(S)
        assert g[m] != 0
        for i in range(m + 1, m + 6):
            assert g[i] == 0
    print("   通過")

    print("2. g = 0 なら f = (t-w)^k·0 = 0（f ≠ 0 に反する側）")
    for w in ws:
        lin = t - R(w)
        for k in range(0, 6):
            assert lin^k * R.zero() == R.zero()
    print("   通過")

    print("3. 鎖: ac_{m+k}(f) = ac_{m+k}((t-w)^k g) = ac_m(g) ≠ 0、よって m+k ≤ n（n は f の係数の上界）、k ≤ m+k ≤ n（k = 0..5）")
    for w in ws:
        lin = t - R(w)
        for g in gs:
            m = max(support(g))
            for k in range(0, 6):
                f = lin^k * g
                assert f != 0
                # f の係数の上界 n を次数と次数+2 の 2 通りで取る（上界は次数ちょうどでなくてよい）
                for n in [f.degree(), f.degree() + 2]:
                    for i in range(n + 1, n + 5):
                        assert f[i] == 0
                    assert f[m + k] == (lin^k * g)[m + k]
                    assert (lin^k * g)[m + k] == g[m]
                    assert g[m] != 0
                    # 背理法の帰結: m+k > n なら ac_{m+k}(f) = 0 のはずだが ≠ 0 なので m+k ≤ n
                    assert m + k <= n
                    assert k <= m + k
                    assert m + k <= n
                    assert k <= n
    print("   通過")


main()
