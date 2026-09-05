# 対象ラベル: claim_root_of_unity_power_not_one_exists
#
# 主張: n >= 1、n が m を割り切らないならば、w^m != 1 を満たす w in mu_n が存在する。
# 人手証明の各段を QQbar で厳密に確かめる。
# - 準備: 除法 m = n*q + r（0 <= r < n）と r != 0（すなわち 1 <= r）。
# - 鎖: すべての w in mu_n について
#   w^r = 1*w^r = 1^q*w^r = (w^n)^q*w^r = w^(n*q)*w^r = w^(n*q+r) = w^m。
#   （背理法の中の等式のうち、仮定「w^m = 1」を使わない段はすべて成り立つ。）
# - 大小: |mu_n| = n と r < n。
# - 結論: w^m != 1 を満たす w in mu_n が実際に存在する。
# 浮動小数点は使わない。


def roots_of_unity(n):
    return [QQbar.zeta(n) ** j for j in range(n)]


def check_power_not_one_exists(nmax, mmax):
    one = QQbar(1)
    count = 0
    polynomials = PolynomialRing(QQbar, "x")
    x = polynomials.gen()
    for n in range(1, nmax + 1):
        for m in range(mmax + 1):
            if m % n == 0:
                continue  # n | m の組は主張の対象外
            q = m // n
            r = m % n
            # 準備: 除法と r の範囲
            assert m == n * q + r
            assert 0 <= r < n
            assert r != 0
            mu = roots_of_unity(n)
            # 大小: |mu_n| = n（相異なることも確かめる）
            assert len(mu) == n
            assert len(set(mu)) == n
            assert all(w ** n == one for w in mu)
            assert set(mu) == set((x ** n - 1).roots(multiplicities=False))
            for w in mu:
                # 鎖のうち背理法の仮定を使わない段
                assert w ** r == one * (w ** r)
                assert one * (w ** r) == (one ** q) * (w ** r)
                assert (one ** q) * (w ** r) == ((w ** n) ** q) * (w ** r)
                assert ((w ** n) ** q) * (w ** r) == (w ** (n * q)) * (w ** r)
                assert (w ** (n * q)) * (w ** r) == w ** (n * q + r)
                assert w ** (n * q + r) == w ** m
            # 結論: 冪が 1 でない元の存在
            witnesses = [w for w in mu if w ** m != one]
            assert len(witnesses) >= 1
            count += 1
    print(
        "claim_root_of_unity_power_not_one_exists: %d 組（n <= %d, m <= %d, n が m を割らないもの）ですべて通過"
        % (count, nmax, mmax)
    )


check_power_not_one_exists(8, 17)
