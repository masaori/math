# 対象ラベル: claim_root_of_unity_finite_card_bound

R.<t> = PolynomialRing(QQbar)


def main():
    print("1. mu_n は t^n - 1 の相異なる根からなる有限集合（n = 1..8）")
    for n in range(1, 9):
        roots = [w for (w, multiplicity) in (t**n - 1).roots(QQbar)]
        assert all(w**n == 1 for w in roots)
        assert len(set(roots)) == len(roots)
        assert len(roots) <= n
    print("   通過")

    print("2. 背理法の自然数の矛盾: |s| = n + 1 と |s| <= n は両立しない")
    for n in range(1, 9):
        card_s = n + 1
        assert not (card_s <= n)
    print("   通過")
    print("すべて通過")


main()
