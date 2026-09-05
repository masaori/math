# 対象ラベル: claim_root_of_unity_power_sum_value
#
# 主張: n >= 1 のとき、S_{n,m} = sum_{z in mu_n} z^m は、n | m なら n、
# n が m を割り切らないなら 0 である。
# c4c1--c4c3 の組み立てを QQbar の厳密計算で確かめる。
# 浮動小数点は使わない。


def roots_of_unity(n):
    return [QQbar.zeta(n) ** j for j in range(n)]


def check_power_sum_value(nmax, mmax):
    count = 0
    polynomials = PolynomialRing(QQbar, "x")
    x = polynomials.gen()
    for n in range(1, nmax + 1):
        mu = roots_of_unity(n)
        assert len(set(mu)) == n
        assert all(w ** n == 1 for w in mu)
        assert set(mu) == set((x ** n - 1).roots(multiplicities=False))
        for m in range(mmax + 1):
            power_sum = sum((w ** m for w in mu), QQbar(0))
            if m % n == 0:
                assert all(w ** m == 1 for w in mu)
                assert power_sum == QQbar(n)
            else:
                witnesses = [w for w in mu if w ** m != 1]
                assert len(witnesses) >= 1
                assert power_sum == 0
            count += 1
    print(
        "claim_root_of_unity_power_sum_value: %d 組（n <= %d, m <= %d）ですべて通過"
        % (count, nmax, mmax)
    )


check_power_sum_value(8, 17)
