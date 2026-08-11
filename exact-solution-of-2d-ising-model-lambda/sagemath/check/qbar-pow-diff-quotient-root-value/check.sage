# 対象ラベル: claim_qbar_pow_diff_quotient_root_value

R.<t> = PolynomialRing(QQbar)


def K(n, w):
    # claim_qbar_poly_power_difference_factorization の約束をそのまま写す
    value = R(0)
    for i in range(n):
        value = value * QQbar(w) + t**i
    return value


def main():
    samples = [QQbar(2), QQbar(-1) / 3, QQbar(sqrt(2)), QQbar.zeta(3), QQbar(0)]

    print("1. 漸化式の確認: K_0 = 0, K_{n+1} = K_n * w + t^n（n = 0..6）")
    for w in samples:
        prev = R(0)
        for n in range(0, 7):
            assert K(n, w) == prev
            prev = prev * w + t**n
    print("   通過")

    print("2. 出発点: aev_w(K_1(w)) = w^0 = 1 項だけの有限和")
    for w in samples:
        assert K(1, w)(w) == w**0
        assert K(1, w)(w) == sum(w ** (1 - 1) for i in range(1))
    print("   通過")

    print("3. 一歩の鎖: aev_w(K_{n+1}(w)) = aev_w(K_n(w)) * w + w^n（n = 1..6）")
    for w in samples:
        for n in range(1, 7):
            lhs = K(n + 1, w)(w)
            assert lhs == K(n, w)(w) * w + w**n
    print("   通過")

    print("4. 主張: aev_w(K_n(w)) = i < n にわたる w^(n-1) の有限和（n = 1..7）")
    for w in samples:
        for n in range(1, 8):
            assert K(n, w)(w) == sum(w ** (n - 1) for i in range(n))
    print("   通過")
    print("すべて通過")


main()
