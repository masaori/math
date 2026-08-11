# 対象ラベル: claim_qbar_distinct_roots_card_bound

R.<t> = PolynomialRing(QQbar)

CASES = [
    (R(t - 1), [QQbar(1)], 1),
    (R((t - 1) * (t + 1)), [QQbar(-1), QQbar(1)], 2),
    (R((t - QQbar(I)) * (t + QQbar(I)) * (t - 2)), [QQbar(I), QQbar(-I), QQbar(2)], 3),
    (R((t - QQbar(sqrt(2)))^2 * (t + QQbar(sqrt(2)))), [QQbar(sqrt(2)), QQbar(-sqrt(2))], 3),
]


def main():
    print("1. 主張そのもの")
    for f, roots, n in CASES:
        assert f != 0
        assert all(f[k] == 0 for k in range(n + 1, n + 5))
        assert all(f(w) == 0 for w in roots)
        assert len(set(roots)) <= n
    print("   通過（4 組）")

    print("2. 帰納法の一歩")
    for f, roots, n in CASES:
        w = roots[0]
        g, remainder = f.quo_rem(t - w)
        assert remainder == 0
        assert g != 0
        assert all(g[j] == 0 for j in range(n, n + 4))
        remaining = [wp for wp in roots if wp != w]
        assert all(g(wp) == 0 for wp in remaining)
        assert len(roots) == len(remaining) + 1
        assert len(remaining) <= n - 1
    print("   通過")

    print("3. 零多項式を除く仮定は外せない")
    f = R.zero()
    roots = [QQbar(k) for k in range(4)]
    n = 0
    assert all(f(w) == 0 for w in roots)
    assert len(roots) > n
    print("   通過")
    print("すべて通過")


main()
