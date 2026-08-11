# 対象ラベル: claim_qbar_poly_linear_factor_coeff_bound


R.<t> = PolynomialRing(QQbar)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]
    cs = [
        R.zero(),
        R.one(),
        t^3 - 2 * t + 1,
        (QQbar.zeta(5)) * t^4 + t^2 - QQbar(7),
        (t - 1) * (t - QQbar.zeta(3)),
    ]

    print("1. 準備: i >= 2 で ac_i(t - w) = 0 を確かめる（鎖の 3 段）")
    for w in ws:
        lin = t - R(w)
        wc = R(w)
        for i in range(2, 8):
            # 1 段目: 和の係数と加法の逆元
            step1 = R(t)[i] - wc[i]
            assert lin[i] == step1
            # 2 段目: ac_i(t) = 0（i != 1）と ac_i(w の定数) = 0（i >= 1）
            assert R(t)[i] == 0
            assert wc[i] == 0
            step2 = QQbar(0) - QQbar(0)
            assert step1 == step2
            # 3 段目: 零元との差
            assert step2 == QQbar(0)
    print("   通過")

    print("2. 本体の鎖: k > m + 1 で ac_k((t-w)C) = 0 を段ごとに確かめる")
    for w in ws:
        lin = t - R(w)
        for C in cs:
            # 係数の仮定を満たす m を取る（m は次数の上界。零多項式は m = 0 でよい）
            m = max(C.degree(), 0)
            for k_extra in range(2, 6):
                k = m + k_extra  # k > m + 1
                P = lin * C
                # 1 段目: 積の係数
                step1 = sum(lin[i] * C[k - i] for i in range(0, k + 1))
                assert P[k] == step1
                # 2 段目: k >= 2 なので番号 0, 1 の項を取り出す
                assert k >= 2
                step2 = (
                    lin[0] * C[k]
                    + lin[1] * C[k - 1]
                    + sum(lin[i] * C[k - i] for i in range(2, k + 1))
                )
                assert step1 == step2
                # 3 段目: k > m と k - 1 > m により C の係数が零
                assert C[k] == 0
                assert C[k - 1] == 0
                step3 = (
                    lin[0] * QQbar(0)
                    + lin[1] * QQbar(0)
                    + sum(lin[i] * C[k - i] for i in range(2, k + 1))
                )
                assert step2 == step3
                # 4 段目: 準備の i >= 2 の係数が零
                step4 = (
                    lin[0] * QQbar(0)
                    + lin[1] * QQbar(0)
                    + sum(QQbar(0) * C[k - i] for i in range(2, k + 1))
                )
                assert step3 == step4
                # 5 段目: 零元との積は零
                step5 = QQbar(0) + QQbar(0) + sum(QQbar(0) for i in range(2, k + 1))
                assert step4 == step5
                # 6 段目: 零元の有限和と零元との和
                assert step5 == QQbar(0)
                # 結論
                assert P[k] == 0
    print("   通過")
    print("すべて通過")


main()
