# 対象ラベル: claim_root_of_unity_card

R.<t> = PolynomialRing(QQbar)


def main():
    print("1. mu_n の元の個数は n に等しい（n = 1..8）")
    for n in range(1, 9):
        roots = [w for (w, multiplicity) in (t**n - 1).roots(QQbar)]
        assert all(w**n == 1 for w in roots)
        assert len(set(roots)) == len(roots)
        assert len(roots) <= n
        assert n <= len(roots)
        assert len(roots) == n
    print("   通過")
    print("すべて通過")


main()
