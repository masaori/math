# 対象ラベル: claim_qbar_bezout_power_propagation


R.<t> = PolynomialRing(QQbar)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    pairs = [(w, wp) for w in ws for wp in ws if w != wp]
    assert len(pairs) >= 1

    ns = range(0, 6)

    print("1. 出発点 n=0: P:=p, Q:=q で P*a+Q*b^1=1")
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        u = R((wp - w) ** (-1))
        p = u
        q = -u
        assert p * a + q * b == R.one()
        P0, Q0 = p, q
        assert P0 * a + Q0 * b ** 1 == R.one()
    print("   通過")

    print("2. 帰納法の一歩の再帰式で P_n, Q_n を構成し、任意の n で P_n*a+Q_n*b^(n+1)=1")
    for w, wp in pairs:
        a = t - R(w)
        b = t - R(wp)
        u = R((wp - w) ** (-1))
        p = u
        q = -u
        assert p * a + q * b == R.one()

        # n = 0 の出発点
        P, Q = p, q
        assert P * a + Q * b ** 1 == R.one()

        for n in range(0, 5):
            # 一歩: P_{n+1} := P_n p a + Q_n p b^{n+1} + P_n q b, Q_{n+1} := Q_n q
            Pn, Qn = P, Q
            P_next = Pn * p * a + Qn * p * b ** (n + 1) + Pn * q * b
            Q_next = Qn * q
            assert P_next * a + Q_next * b ** ((n + 1) + 1) == R.one()
            P, Q = P_next, Q_next
    print("   通過")

    print("3. 帰納法の一歩の鎖の途中の等式を個別に確認（n=1 の一例）")
    w, wp = pairs[0]
    a = t - R(w)
    b = t - R(wp)
    u = R((wp - w) ** (-1))
    p = u
    q = -u
    n = 1
    Pn = p * p * a + q * p * b ** 1 + p * q * b
    Qn = q * q
    lhs = Pn * a + Qn * b ** (n + 1)
    step1 = (Pn * p * a + Qn * p * b ** (n + 1) + Pn * q * b) * a + (Qn * q) * b ** ((n + 1) + 1)
    step2 = Pn * p * a ** 2 + Qn * p * a * b ** (n + 1) + Pn * q * a * b + Qn * q * b ** ((n + 1) + 1)
    step3 = Pn * p * a ** 2 + Qn * p * a * b ** (n + 1) + Pn * q * a * b + Qn * q * (b * b ** (n + 1))
    step4 = p * a * (Pn * a) + p * a * (Qn * b ** (n + 1)) + q * b * (Pn * a) + q * b * (Qn * b ** (n + 1))
    step5 = p * a * (Pn * a + Qn * b ** (n + 1)) + q * b * (Pn * a + Qn * b ** (n + 1))
    step6 = (p * a + q * b) * (Pn * a + Qn * b ** (n + 1))
    step7 = R.one() * R.one()
    step8 = R.one()
    P_next = Pn * p * a + Qn * p * b ** (n + 1) + Pn * q * b
    Q_next = Qn * q
    assert P_next * a + Q_next * b ** ((n + 1) + 1) == step1
    assert step1 == step2
    assert step2 == step3
    assert step3 == step4
    assert step4 == step5
    assert step5 == step6
    assert step6 == step7
    assert step7 == step8
    print("   通過")


main()
