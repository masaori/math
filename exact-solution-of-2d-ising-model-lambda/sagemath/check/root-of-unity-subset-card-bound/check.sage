# 対象ラベル: claim_root_of_unity_subset_card_bound

R.<t> = PolynomialRing(QQbar)


def mu(n, bound):
    """1 の n 乗根を QQbar の中で列挙する（t^n - 1 の根として厳密に取る）。"""
    return [w for (w, _) in (t**n - 1).roots(QQbar)]


def main():
    print("1. 準備の多項式 f = t^n + (-1) の 3 条件（n = 1..6）")
    for n in range(1, 7):
        f = t**n + QQbar(-1)
        # 第 1: f ≠ 0（番号 0 の係数が -1）
        assert f[0] == QQbar(-1)
        assert f != 0
        # 第 2: n < k で係数が零
        assert all(f[k] == 0 for k in range(n + 1, n + 5))
        # 第 3: μ_n の元は根
        roots = mu(n, n)
        assert all(w**n == 1 for w in roots)
        assert all(f(w) == 0 for w in roots)
    print("   通過（n = 1..6）")

    print("2. 主張そのもの: μ_n の有限部分集合の元の個数は n 以下（n = 1..6、全部分集合）")
    from itertools import combinations
    for n in range(1, 7):
        roots = mu(n, n)
        # μ_n 全体もその部分集合も n 以下（全列挙は n=6 で 2^6 = 64 個）
        assert len(set(roots)) <= n
        for r in range(len(roots) + 1):
            for s in combinations(roots, r):
                assert len(set(s)) <= n
    print("   通過")

    print("3. 仮定 n ≥ 1 は外せない（n = 0 では μ_0 = QQbar なので 1 元の部分集合が反例）")
    n = 0
    w = QQbar(2)
    assert w**n == 1          # 冪の約束 z^0 = 1 により、どの代数的数も μ_0 の元である
    s = [w]
    assert len(s) > n         # |s| = 1 > 0 = n
    print("   通過")
    print("すべて通過")


main()
