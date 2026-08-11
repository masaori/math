# 対象ラベル: claim_qbar_factor_quotient_coeff_bound

R.<t> = PolynomialRing(QQbar)


def K(w, k):
    out = R.zero()
    for j in range(k):
        out = out * R(w) + t^j
    return out


def quotient(f, n, w):
    return sum((R(f[k]) * K(w, k) for k in range(n + 1)), R.zero())


WS = [QQbar(1), QQbar(sqrt(2)), QQbar(I), QQbar(sqrt(-3))]
FS = [
    (t^3 - QQbar(2) * t + QQbar(1), 3),
    (t^4 + QQbar(sqrt(2)) * t^2 - t, 4),
    (QQbar(I) * t^2 + t + QQbar(5), 2),
    (R(QQbar(7)), 0),
    (t^5 - QQbar(1), 5),
    # 上界 n が実際の次数より大きい取り方（k > n で係数が零、の条件だけを使う）
    (t^2 + t, 4),
]
J_EXTRA = 3


def main():
    print("1. 主張そのもの（n ≤ j で商の係数が零）")
    for f, n in FS:
        for k in range(n + 1, n + 5):
            assert f[k] == 0
        for w in WS:
            g = quotient(f, n, w)
            for j in range(n, n + J_EXTRA + 1):
                assert g[j] == 0
    print("   通過（f %d 個 × w %d 個 × j ≤ n+%d）" % (len(FS), len(WS), J_EXTRA))

    print("2. 鎖の各段（n ≤ j）")
    for f, n in FS:
        for w in WS:
            g = quotient(f, n, w)
            for j in range(n, n + J_EXTRA + 1):
                line1 = sum((R(f[k]) * K(w, k) for k in range(n + 1)),
                            R.zero())[j]
                line2 = sum((QQbar((R(f[k]) * K(w, k))[j])
                             for k in range(n + 1)), QQbar(0))
                line3 = sum((sum((QQbar(R(f[k])[i] * K(w, k)[j - i])
                                  for i in range(j + 1)), QQbar(0))
                             for k in range(n + 1)), QQbar(0))
                line4 = sum((R(f[k])[0] * K(w, k)[j]
                             + sum((R(f[k])[i] * K(w, k)[j - i]
                                    for i in range(1, j + 1)), QQbar(0))
                             for k in range(n + 1)), QQbar(0))
                line5 = sum((R(f[k])[0] * K(w, k)[j]
                             + sum((QQbar(0) * K(w, k)[j - i]
                                    for i in range(1, j + 1)), QQbar(0))
                             for k in range(n + 1)), QQbar(0))
                line6 = sum((R(f[k])[0] * K(w, k)[j]
                             + sum((QQbar(0)
                                    for i in range(1, j + 1)), QQbar(0))
                             for k in range(n + 1)), QQbar(0))
                line7 = sum((R(f[k])[0] * K(w, k)[j]
                             for k in range(n + 1)), QQbar(0))
                line8 = sum((f[k] * K(w, k)[j]
                             for k in range(n + 1)), QQbar(0))
                line9 = sum((f[k] * QQbar(0)
                             for k in range(n + 1)), QQbar(0))
                line10 = sum((QQbar(0) for k in range(n + 1)), QQbar(0))
                line11 = QQbar(0)
                assert g[j] == line1 == line2 == line3 == line4 == line5 \
                    == line6 == line7 == line8 == line9 == line10 == line11
    print("   通過")

    print("3. 前提の確認（1 ≤ i で定数多項式の係数が零、ac_0 が元に戻る、k ≤ j で K_k の係数が零）")
    for f, n in FS:
        for k in range(n + 1):
            c = R(f[k])
            assert c[0] == f[k]
            for i in range(1, 4):
                assert c[i] == 0
    for w in WS:
        for k in range(6):
            for j in range(k, k + J_EXTRA + 1):
                assert K(w, k)[j] == 0
    print("   通過")
    print("すべて通過")


main()
