# 対象ラベル: claim_qbar_distinct_linear_factors_bezout


R.<t> = PolynomialRing(QQbar)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt(), QQbar.zeta(5)]

    pairs = [(w, wp) for w in ws for wp in ws if w != wp]
    assert len(pairs) >= 1

    print("1. u_{w,w'} := (w'-w)^{-1} が well-defined（w'-w ≠ 0）")
    for w, wp in pairs:
        assert wp - w != QQbar(0)
    print("   通過")

    print("2. 恒等式 u_{w,w'}(t-w) - u_{w,w'}(t-w') = 1")
    for w, wp in pairs:
        u = R((wp - w) ** (-1))
        lhs = u * (t - R(w)) - u * (t - R(wp))
        assert lhs == R.one()
    print("   通過")

    print("3. 準備段の各行（分配則・t の相殺・定数embeddingの和・積・体の逆元）")
    for w, wp in pairs:
        u = R((wp - w) ** (-1))
        step1 = u * ((t - R(w)) - (t - R(wp)))
        step2 = u * (R(wp) - R(w))
        step3 = u * R(wp - w)
        step4 = R((wp - w) ** (-1)) * R(wp - w)
        step5 = R((wp - w) ** (-1) * (wp - w))
        step6 = R.one()
        assert u * (t - R(w)) - u * (t - R(wp)) == step1
        assert step1 == step2
        assert step2 == step3
        assert step3 == step4
        assert step4 == step5
        assert step5 == step6
    print("   通過")


main()
