# 対象ラベル: claim_first_root_of_unity_set


R.<t> = PolynomialRing(QQbar)


def main():
    print("1. mu_1 の各元が 1 であることを確かめる")
    roots = [w for w, multiplicity in (t - 1).roots(QQbar)]
    assert len(roots) == 1
    for w in roots:
        assert w^1 == 1
        assert w == 1
    print("   通過")

    print("2. 1 が mu_1 に属することを確かめる")
    assert QQbar(1)^1 == 1
    print("   通過")
    print("すべて通過")


main()
