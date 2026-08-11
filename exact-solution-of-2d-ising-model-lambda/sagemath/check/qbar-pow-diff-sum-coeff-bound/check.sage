# 対象ラベル: claim_qbar_pow_diff_sum_coeff_bound

R.<t> = PolynomialRing(QQbar)


def K(w, k):
    out = R.zero()
    for j in range(k):
        out = out * R(w) + t^j
    return out


WS = [QQbar(1), QQbar(sqrt(2)), QQbar(I), QQbar(sqrt(-3))]
N_MAX = 5
J_EXTRA = 3


def main():
    print("1. 主張そのもの（n ≤ j で係数が零）")
    for w in WS:
        for n in range(N_MAX + 1):
            Kn = K(w, n)
            for j in range(n, n + J_EXTRA + 1):
                assert Kn[j] == 0
    print("   通過（w %d 個 × n ≤ %d × j ≤ n+%d）" % (len(WS), N_MAX, J_EXTRA))

    print("2. 出発点の鎖（n = 0）")
    for w in WS:
        for j in range(0, J_EXTRA + 1):
            line1 = R.zero()[j]
            assert K(w, 0)[j] == line1 == 0
    print("   通過")

    print("3. 一歩の鎖（n → n+1、n+1 ≤ j）")
    for w in WS:
        hatw = R(w)
        for n in range(N_MAX):
            Kn = K(w, n)
            Kn1 = K(w, n + 1)
            for j in range(n + 1, n + 1 + J_EXTRA + 1):
                line1 = (Kn * hatw + t^n)[j]
                line2 = (Kn * hatw)[j] + (t^n)[j]
                line3 = (Kn * hatw)[j] + 0
                line4 = (Kn * hatw)[j]
                line5 = sum((Kn[i] * hatw[j - i] for i in range(j + 1)),
                            QQbar(0))
                line6 = sum((Kn[i] * hatw[j - i] for i in range(j)),
                            QQbar(0)) + Kn[j] * hatw[0]
                line7 = sum((Kn[i] * QQbar(0) for i in range(j)),
                            QQbar(0)) + Kn[j] * hatw[0]
                line8 = sum((QQbar(0) for i in range(j)),
                            QQbar(0)) + Kn[j] * hatw[0]
                line9 = Kn[j] * hatw[0]
                line10 = Kn[j] * w
                line11 = QQbar(0) * w
                line12 = QQbar(0)
                assert Kn1[j] == line1 == line2 == line3 == line4 == line5 \
                    == line6 == line7 == line8 == line9 == line10 \
                    == line11 == line12
    print("   通過")
    print("すべて通過")


main()
