# 対象ラベル: claim_qbar_linear_factor_pow_mul_leading_coeff


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

    print("1. 出発点 j = 0: ac_{m+0}((t-w)^0 C) = ac_{m+0}(1·C) = ac_{m+0}(C) = ac_m(C)（鎖の 3 段）")
    for w in ws:
        lin = t - R(w)
        for C in cs:
            # 上界 m は次数以上なら何でもよいので、次数と次数+2 の 2 通りで確かめる
            for m in [max(C.degree(), 0), max(C.degree(), 0) + 2]:
                step1 = (R.one() * C)[m + 0]
                assert (lin^0 * C)[m + 0] == step1
                step2 = C[m + 0]
                assert step1 == step2
                assert step2 == C[m]
    print("   通過")

    print("2. 一歩: 上界 m+j の確認、冪の等式、先頭の係数の移動（j = 0..5）")
    for w in ws:
        lin = t - R(w)
        for C in cs:
            for m in [max(C.degree(), 0), max(C.degree(), 0) + 2]:
                for j in range(0, 6):
                    P = lin^j * C
                    # 帰納法の仮定
                    assert P[m + j] == C[m]
                    # 前主張: (t-w)^j C は上界 m+j を持つ
                    for k in range(m + j + 1, m + j + 5):
                        assert P[k] == 0
                    # 冪の等式
                    Q = lin^(j + 1) * C
                    assert Q == lin^j * lin * C
                    assert lin^j * lin * C == lin * (lin^j * C)
                    # 鎖の 4 段
                    assert Q[m + (j + 1)] == Q[(m + j) + 1]
                    assert Q[(m + j) + 1] == (lin * P)[(m + j) + 1]
                    assert (lin * P)[(m + j) + 1] == P[m + j]
                    assert P[m + j] == C[m]
    print("   通過")


main()
