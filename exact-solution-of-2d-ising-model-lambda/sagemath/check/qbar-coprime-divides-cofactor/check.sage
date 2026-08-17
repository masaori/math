# 対象ラベル: claim_qbar_coprime_divides_cofactor


R.<t> = PolynomialRing(QQbar)


def propagate(a, b, p, q, n):
    """claim_qbar_bezout_power_propagation の再帰式で P,Q を n まで構成する。"""
    P, Q = p, q
    for i in range(0, n):
        P_next = P * p * a + Q * p * b ** (i + 1) + P * q * b
        Q_next = Q * q
        P, Q = P_next, Q_next
    return P, Q


def bezout_powers(a, b, p, q, k, m):
    """claim_qbar_linear_factor_powers_bezout の二度適用で P*a^(k+1)+Q*b^(m+1)=1 を作る。"""
    P1, Q1 = propagate(a, b, p, q, m)
    P2, Q2 = propagate(b ** (m + 1), a, Q1, P1, k)
    return Q2, P2


def divides(d, f):
    """def_qbar_linear_factor_power_divides の意味の整除（商と余りで判定）。"""
    _, r = f.quo_rem(d)
    return r == R.zero()


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    pairs = [(w, wp) for w in ws for wp in ws if w != wp]
    ks = range(0, 3)
    ms = range(0, 3)
    gs_base = [R.one(), t, t ** 2 + 1, 3 * t - 2, t ** 3 - QQbar(2)]

    print("1. Bezout 恒等式 P*a^(k+1)+Q*b^(m+1)=1 が立つ")
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        u = R((wp - w) ** (-1))
        for k in ks:
            for m in ms:
                P, Q = bezout_powers(a, b, u, -u, k, m)
                assert P * a ** (k + 1) + Q * b ** (m + 1) == R.one()
    print("   通過")

    print("2. 仮定 b^(m+1) | a^(k+1)*g のもとで、鎖の各段が等式として成り立つ")
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        u = R((wp - w) ** (-1))
        for k in ks:
            for m in ms:
                P, Q = bezout_powers(a, b, u, -u, k, m)
                for g0 in gs_base:
                    # 仮定を満たす g を作る（b^(m+1) を含ませる）。
                    g = b ** (m + 1) * g0
                    hh, r = (a ** (k + 1) * g).quo_rem(b ** (m + 1))
                    assert r == R.zero()
                    # g = 1*g = (P a^{k+1} + Q b^{m+1}) g = P(a^{k+1}g) + Q(b^{m+1}g)
                    #       = P(b^{m+1}h) + Q(b^{m+1}g) = b^{m+1}(P h + Q g)
                    assert g == R.one() * g
                    assert R.one() * g == (P * a ** (k + 1) + Q * b ** (m + 1)) * g
                    assert (P * a ** (k + 1) + Q * b ** (m + 1)) * g == P * (
                        a ** (k + 1) * g
                    ) + Q * (b ** (m + 1) * g)
                    assert P * (a ** (k + 1) * g) + Q * (b ** (m + 1) * g) == P * (
                        b ** (m + 1) * hh
                    ) + Q * (b ** (m + 1) * g)
                    assert P * (b ** (m + 1) * hh) + Q * (b ** (m + 1) * g) == b ** (
                        m + 1
                    ) * (P * hh + Q * g)
    print("   通過")

    print("3. 結論 b^(m+1) | g")
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        for k in ks:
            for m in ms:
                for g0 in gs_base:
                    g = b ** (m + 1) * g0
                    assert divides(b ** (m + 1), a ** (k + 1) * g)
                    assert divides(b ** (m + 1), g)
    print("   通過")

    print("4. 仮定が成り立たない g では結論も成り立たない（含意が空虚でないことの確認）")
    found = False
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        for m in ms:
            g = R.one()
            if not divides(b ** (m + 1), a ** 1 * g):
                assert not divides(b ** (m + 1), g)
                found = True
    assert found
    print("   通過")


main()
