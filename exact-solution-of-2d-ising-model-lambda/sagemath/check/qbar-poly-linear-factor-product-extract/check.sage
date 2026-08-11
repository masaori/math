# 対象ラベル: claim_qbar_poly_linear_factor_product_extract

R.<t> = PolynomialRing(QQbar)


def linear_factor_product(values):
    value = R.one()
    for w in values:
        value *= t - w
    return value


def main():
    print("1. 帰納法の出発点と一歩を確かめる")
    samples = [QQbar(2), QQbar(-3), QQbar.zeta(3), QQbar(2), QQbar.zeta(5)]
    assert linear_factor_product([]) == 1
    for j in range(len(samples)):
        previous = linear_factor_product(samples[:j])
        current = linear_factor_product(samples[:j + 1])
        assert current == previous * (t - samples[j])
    print("   通過")

    print("2. 各番号の因子を先頭へ取り出せることを確かめる")
    for j in range(1, len(samples) + 1):
        product = linear_factor_product(samples[:j])
        for i in range(j):
            remaining = samples[:i] + samples[i + 1:j]
            B = linear_factor_product(remaining)
            assert product == (t - samples[i]) * B
    print("   通過")
    print("すべて通過")


main()
