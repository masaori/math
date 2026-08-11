# 対象ラベル: claim_qbar_poly_linear_factor_leading_coeff

R.<t> = PolynomialRing(QQbar)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    cs = [
        R.zero(),
        R.one(),
        t^3 - 2 * t + 1,
        QQbar.zeta(5) * t^4 + t^2 - QQbar(7),
        (t - 1) * (t - QQbar.zeta(3)),
    ]

    print("一次因子との積の先頭の係数の鎖を段ごとに確かめる")
    for w in ws:
        lin = t - R(w)
        for C in cs:
            m = max(C.degree(), 0)
            P = lin * C
            # 1 段目: 一次因子との積の番号 m + 1 の係数
            step1 = C[m] + (-w) * C[m + 1]
            assert P[m + 1] == step1
            # 2 段目: m + 1 > m なので C の係数は零
            assert C[m + 1] == 0
            step2 = C[m] + (-w) * QQbar(0)
            assert step1 == step2
            # 3 段目: 零元との積
            step3 = C[m] + QQbar(0)
            assert step2 == step3
            # 4 段目: 零元との和
            assert step3 == C[m]
            assert P[m + 1] == C[m]
    print("すべて通過")


main()
