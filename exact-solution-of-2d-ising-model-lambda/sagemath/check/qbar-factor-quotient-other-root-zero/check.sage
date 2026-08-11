# 対象ラベル: claim_qbar_factor_quotient_other_root_zero

R.<t> = PolynomialRing(QQbar)


CASES = [
    (QQbar(1), QQbar(-1), t + 1),
    (QQbar(sqrt(2)), QQbar(-sqrt(2)), t^2 - 2),
    (QQbar(I), QQbar(-I), (t + I) * (t - 2)),
    (QQbar(0), QQbar(3), t * (t - 3) * (t + 1)),
]


def main():
    print("1. 主張そのもの")
    for w, wp, g in CASES:
        f = (t - w) * g
        assert wp != w
        assert f(wp) == 0
        assert g(wp) == 0
    print("   通過")

    print("2. 鎖の各段")
    for w, wp, g in CASES:
        f = (t - w) * g
        line1 = f(wp)
        line2 = ((t - w) * g)(wp)
        line3 = (t - w)(wp) * g(wp)
        line4 = (t(wp) - R(w)(wp)) * g(wp)
        line5 = (wp - w) * g(wp)
        assert QQbar(0) == line1 == line2 == line3 == line4 == line5
        assert wp - w != 0
    print("   通過")

    print("3. 相異なるという仮定は外せない")
    w = QQbar(1)
    g = R.one()
    f = (t - w) * g
    assert f(w) == 0
    assert g(w) != 0
    print("   通過")
    print("すべて通過")


main()
