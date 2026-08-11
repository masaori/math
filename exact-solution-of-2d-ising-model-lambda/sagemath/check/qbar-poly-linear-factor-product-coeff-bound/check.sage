# 対象ラベル: claim_qbar_poly_linear_factor_product_coeff_bound


R.<t> = PolynomialRing(QQbar)


def linear_factor_product(roots, m):
    result = R.one()
    for i in range(m):
        result *= t - roots[i]
    return result


def main():
    roots = [
        QQbar(0),
        QQbar(1),
        QQbar(-2),
        QQbar.zeta(3),
        QQbar(2).sqrt(),
        QQbar(-5) / 7,
        QQbar.zeta(5),
    ]

    print("1. 出発点: 空積の正の番号の係数は零")
    empty_product = linear_factor_product(roots, 0)
    assert empty_product == R.one()
    for k in range(1, 6):
        assert empty_product[k] == 0
    print("   通過")

    print("2. 一歩: 最後の因子を先頭へ移し、係数上界を一つ上げる")
    for m in range(0, len(roots)):
        product_m = linear_factor_product(roots, m)
        product_succ = linear_factor_product(roots, m + 1)
        factor = t - roots[m]

        # 有限積の一歩と、最後の因子を先頭へ移す交換則。
        assert product_succ == product_m * factor
        assert product_succ == factor * product_m

        # 帰納法の仮定。
        for k in range(m + 1, m + 6):
            assert product_m[k] == 0

        # 一次因子との積の係数上界を当てた結論。
        for k in range(m + 2, m + 7):
            assert product_succ[k] == 0
    print("   通過")

    print("3. 本体: m 個の一次因子の積の係数は番号 m で尽きる")
    for m in range(0, len(roots) + 1):
        product_m = linear_factor_product(roots, m)
        for k in range(m + 1, m + 7):
            assert product_m[k] == 0
        # 最高次係数は 1。主張が単に過大な上界を置いたものではないことも確かめる。
        assert product_m[m] == 1
    print("   通過")

    print("すべて通過")


main()
