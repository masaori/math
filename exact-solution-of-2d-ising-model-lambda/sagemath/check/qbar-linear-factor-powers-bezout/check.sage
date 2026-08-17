# 対象ラベル: claim_qbar_linear_factor_powers_bezout


R.<t> = PolynomialRing(QQbar)


def propagate(a, b, p, q, n):
    """claim_qbar_bezout_power_propagation の再帰式で P,Q を n まで構成する。"""
    P, Q = p, q
    for i in range(0, n):
        P_next = P * p * a + Q * p * b ** (i + 1) + P * q * b
        Q_next = Q * q
        P, Q = P_next, Q_next
    return P, Q


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    pairs = [(w, wp) for w in ws for wp in ws if w != wp]
    assert len(pairs) >= 1
    ks = range(0, 4)
    ms = range(0, 4)

    print("1. 二度の適用で P*a^(k+1)+Q*b^(m+1)=1 が成り立つ")
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        u = R((wp - w) ** (-1))
        p = u
        q = -u
        assert p * a + q * b == R.one()

        for m in ks:
            # 一度目: P1*a + Q1*b^(m+1) = 1
            P1, Q1 = propagate(a, b, p, q, m)
            assert P1 * a + Q1 * b ** (m + 1) == R.one()

            # 二度目: a':=b^(m+1), b':=a, p':=Q1, q':=P1 として n:=k で適用
            ap = b ** (m + 1)
            bp = a
            pp = Q1
            qp = P1
            assert pp * ap + qp * bp == R.one()

            for k in ms:
                P2, Q2 = propagate(ap, bp, pp, qp, k)
                assert P2 * ap + Q2 * bp ** (k + 1) == R.one()
                # P2*b^(m+1) + Q2*a^(k+1) = 1
                assert P2 * b ** (m + 1) + Q2 * a ** (k + 1) == R.one()
                # 主張の形: P:=Q2, Q:=P2
                P, Q = Q2, P2
                assert P * a ** (k + 1) + Q * b ** (m + 1) == R.one()
    print("   通過")


main()
