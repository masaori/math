# 対象ラベル: claim_qbar_poly_linear_factor_cancellation


R.<t> = PolynomialRing(QQbar)


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]

    print("1. 一次式 t - w の係数（ac_0 = -w、ac_1 = 1、i >= 2 で 0）を確かめる")
    for w in ws:
        lin = t - R(w)
        assert lin[0] == -w
        assert lin[1] == 1
        for i in range(2, 8):
            assert lin[i] == 0
    print("   通過")

    print("2. 積の係数 ac_{m+1}((t-w)C) = ac_m(C) + (-w) ac_{m+1}(C) を確かめる")
    cs = [
        R.zero(),
        R.one(),
        t^3 - 2 * t + 1,
        (QQbar.zeta(5)) * t^4 + t^2 - QQbar(7),
        (t - 1) * (t - QQbar.zeta(3)),
    ]
    for w in ws:
        for C in cs:
            P = (t - R(w)) * C
            for m in range(0, 10):
                assert P[m + 1] == C[m] + (-w) * C[m + 1]
    print("   通過")

    print("3. 帰納法（係数を上の番号から順に取り戻す鎖）を確かめる")
    # P = (t-w)A から、k > n で 0 を出発点に
    # ac_k(A) = ac_{k+1}(P) + w * ac_{k+1}(A) で下へ辿ると A が一意に戻ること。
    for w in ws:
        for A in cs:
            n = max(A.degree(), 0)
            P = (t - R(w)) * A
            rec = {}
            for k in range(n + 1, n + 3):
                rec[k] = QQbar(0)
            for k in range(n, -1, -1):
                rec[k] = P[k + 1] + w * rec[k + 1]
            for k in range(0, n + 3):
                assert rec[k] == A[k]
    print("   通過")

    print("4. 消去そのもの（(t-w)A = (t-w)B ならば A = B）を確かめる")
    for w in ws:
        for A in cs:
            for B in cs:
                if (t - R(w)) * A == (t - R(w)) * B:
                    assert A == B
    print("   通過")
    print("すべて通過")


main()
