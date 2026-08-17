# 対象ラベル: claim_qbar_linear_factor_pow_mul_coeff_bound


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

    print("1. 出発点 j = 0: (t-w)^0 C = 1·C = C の係数（鎖の 3 段）")
    for w in ws:
        lin = t - R(w)
        for C in cs:
            m = max(C.degree(), 0)
            for k in range(m + 1, m + 5):
                step1 = (R.one() * C)[k]
                assert (lin^0 * C)[k] == step1
                step2 = C[k]
                assert step1 == step2
                assert step2 == QQbar(0)
    print("   通過")

    print("2. 一歩: 冪の等式と、一次因子との積の係数の上界（j = 0..5, k > m + j + 1）")
    for w in ws:
        lin = t - R(w)
        for C in cs:
            m = max(C.degree(), 0)
            for j in range(0, 6):
                P = lin^j * C
                # 帰納法の仮定: k > m + j で ac_k(P) = 0
                for k in range(m + j + 1, m + j + 5):
                    assert P[k] == 0
                # 冪の等式 (t-w)^{j+1} C = (t-w)^j (t-w) C = (t-w) (t-w)^j C
                Q = lin^(j + 1) * C
                assert Q == lin^j * lin * C
                assert lin^j * lin * C == lin * (lin^j * C)
                # 結論: k > m + (j+1) で ac_k = 0
                for k in range(m + j + 2, m + j + 6):
                    assert (lin * P)[k] == 0
                    assert Q[k] == 0
    print("   通過")


main()
