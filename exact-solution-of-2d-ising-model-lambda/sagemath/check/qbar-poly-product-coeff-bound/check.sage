# 対象ラベル: claim_qbar_poly_product_coeff_bound


R.<t> = PolynomialRing(QQbar)


def main():
    ps = [
        (R.zero(), 0),
        (R.one(), 0),
        (QQbar(3) * t - 1, 1),
        (t^3 - 2 * t + 1, 3),
        ((QQbar.zeta(3)) * t^2 + QQbar(2).sqrt(), 2),
    ]
    qs = [
        (R.zero(), 0),
        (R(QQbar(-5) / 7), 0),
        (t - QQbar.zeta(5), 1),
        ((t - 1) * (t - QQbar.zeta(3)), 2),
        (t^4 + (QQbar(2) / 3) * t - QQbar(1), 4),
    ]

    print("1. 本体の鎖: k > p + q で ac_k(PQ) = 0 を段ごとに確かめる")
    for (P, p) in ps:
        # 係数の仮定: k > p で ac_k(P) = 0
        for k in range(p + 1, p + 6):
            assert P[k] == 0
        for (Q, q) in qs:
            for k in range(q + 1, q + 6):
                assert Q[k] == 0
            prod = P * Q
            for k_extra in range(1, 5):
                k = p + q + k_extra  # k > p + q
                # 前提: p < k
                assert p < k
                # 1 段目: 積の係数
                step1 = sum(P[i] * Q[k - i] for i in range(0, k + 1))
                assert prod[k] == step1
                # 2 段目: 有限和を番号 p で 2 つに分ける
                step2 = sum(P[i] * Q[k - i] for i in range(0, p + 1)) + sum(
                    P[i] * Q[k - i] for i in range(p + 1, k + 1)
                )
                assert step1 == step2
                # 3 段目: i <= p のとき k - i >= k - p > q なので ac_{k-i}(Q) = 0
                for i in range(0, p + 1):
                    assert k - i > q
                    assert Q[k - i] == 0
                step3 = sum(P[i] * QQbar(0) for i in range(0, p + 1)) + sum(
                    P[i] * Q[k - i] for i in range(p + 1, k + 1)
                )
                assert step2 == step3
                # 4 段目: i >= p + 1 のとき i > p なので ac_i(P) = 0
                for i in range(p + 1, k + 1):
                    assert P[i] == 0
                step4 = sum(P[i] * QQbar(0) for i in range(0, p + 1)) + sum(
                    QQbar(0) * Q[k - i] for i in range(p + 1, k + 1)
                )
                assert step3 == step4
                # 5 段目: 零元との積は零
                step5 = sum(QQbar(0) for i in range(0, p + 1)) + sum(
                    QQbar(0) for i in range(p + 1, k + 1)
                )
                assert step4 == step5
                # 6 段目: 零元の有限和
                step6 = QQbar(0) + QQbar(0)
                assert step5 == step6
                # 7 段目: 零元との和
                assert step6 == QQbar(0)
    print("   通過")

    print("すべて通過")


main()
