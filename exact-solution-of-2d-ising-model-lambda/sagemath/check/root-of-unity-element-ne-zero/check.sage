# 対象ラベル: claim_root_of_unity_element_ne_zero


def main():
    print("1. 鎖の各段: 0^n = 0^{(n-1)+1} = 0^{n-1} * 0 = 0（n = 1..8）")
    for n in range(1, 9):
        zero = QQbar(0)
        assert zero**n == zero ** ((n - 1) + 1)
        assert zero ** ((n - 1) + 1) == zero ** (n - 1) * zero
        assert zero ** (n - 1) * zero == QQbar(0)
    print("   通過")

    print("2. 矛盾の核: QQbar で 1 != 0")
    assert QQbar(1) != QQbar(0)
    print("   通過")

    print("3. 主張: mu_n の元は零でない（n = 1..8 の 1 の n 乗根を総当たり）")
    for n in range(1, 9):
        # x^n - 1 の QQbar における根の全体がちょうど mu_n である
        R.<t> = PolynomialRing(QQbar)
        roots = (t**n - 1).roots(multiplicities=False)
        assert len(roots) == n
        for w in roots:
            assert w**n == 1
            assert w != QQbar(0)
    print("   通過")

    print("4. 仮定 n >= 1 が外せないこと: n = 0 では 0 in mu_0（0^0 = 1）")
    assert QQbar(0) ** 0 == 1
    print("   通過")
    print("すべて通過")


main()
