# 対象ラベル: claim_qbar_poly_linear_factor_cancellation


R.<t> = PolynomialRing(QQbar)


def assert_chain(values):
    for left, right in zip(values, values[1:]):
        assert left == right


def main():
    ws = [QQbar(0), QQbar(1), QQbar(-1), QQbar(2) / 3, QQbar.zeta(3), QQbar(2).sqrt()]

    print("1. 一次式 t - w の係数（ac_0 = -w、ac_1 = 1、i >= 2 で 0）を確かめる")
    for w in ws:
        lin = t - R(w)
        assert_chain([lin[0], t[0] - R(w)[0], 0 - w, -w])
        assert_chain([lin[1], t[1] - R(w)[1], 1 - 0, 1])
        assert lin[0] == -w
        assert lin[1] == 1
        for i in range(2, 8):
            assert_chain([lin[i], t[i] - R(w)[i], 0 - 0, 0])
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
                lin = t - R(w)
                assert_chain([
                    P[m + 1],
                    sum(lin[i] * C[m + 1 - i] for i in range(m + 2)),
                    lin[0] * C[m + 1] + lin[1] * C[m]
                    + sum(lin[i] * C[m + 1 - i] for i in range(2, m + 2)),
                    (-w) * C[m + 1] + 1 * C[m]
                    + sum(QQbar(0) * C[m + 1 - i] for i in range(2, m + 2)),
                    (-w) * C[m + 1] + C[m] + 0,
                    C[m] + (-w) * C[m + 1],
                ])
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
                    n = max(A.degree(), B.degree(), 0)
                    for j in range(n + 2):
                        for k in range(n + 3):
                            if k + j < n + 1:
                                continue
                            if j == 0:
                                assert_chain([A[k], 0, B[k]])
                            elif k + (j - 1) < n + 1:
                                assert A[k + 1] == B[k + 1]
                                assert_chain([
                                    A[k],
                                    (A[k] + (-w) * A[k + 1]) - (-w) * A[k + 1],
                                    ((t - R(w)) * A)[k + 1] - (-w) * A[k + 1],
                                    ((t - R(w)) * B)[k + 1] - (-w) * A[k + 1],
                                    ((t - R(w)) * B)[k + 1] - (-w) * B[k + 1],
                                    (B[k] + (-w) * B[k + 1]) - (-w) * B[k + 1],
                                    B[k],
                                ])
                            assert A[k] == B[k]
                    assert A == B
    print("   通過")
    print("すべて通過")


main()
