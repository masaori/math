# 対象ラベル: claim_root_of_unity_geometric_sum_zero
#
# 主張: n を自然数、z を 1 の n 乗根（z^n = 1）とし、z ≠ 1 とすると
#       G_n(z) = Σ_{k=0}^{n-1} z^k = 0 である。
#
# 人手証明は 3 段の鎖 (z-1)G_n(z) = z^n - 1 = 1 - 1 = 0 と、
# そこへ「積が零元ならば零元でない方で割れる」を当てる段からなる。
# 各段に対応させて厳密計算（QQbar）で確かめる。浮動小数点は使わない。


def roots_of_unity(n):
    """1 の n 乗根の全体 μ_n を QQbar の中で厳密に列挙する。"""
    return [QQbar.zeta(n) ** k for k in range(n)]


def geometric_sum(z, n):
    """G_n(z) = Σ_{k=0}^{n-1} z^k（n = 0 のときは空和で 0）。"""
    total = QQbar(0)
    for k in range(n):
        total += z ** k
    return total


def check_preparation(nmax):
    print("0. 準備（z ≠ 1 ならば z - 1 ≠ 0）: QQbar")
    for n in range(1, nmax + 1):
        for z in roots_of_unity(n):
            if z == QQbar(1):
                continue
            assert z - QQbar(1) != QQbar(0)
    print("   通過（n = 1..%d）" % nmax)


def check_chain(nmax):
    print("1. 鎖の各段（(z-1)G_n(z) = z^n - 1 = 1 - 1 = 0）: QQbar")
    one = QQbar(1)
    zero = QQbar(0)
    count = 0
    for n in range(1, nmax + 1):
        for z in roots_of_unity(n):
            if z == one:
                continue
            g = geometric_sum(z, n)
            # 第 1 段。伸縮の等式（claim_qbar_geometric_telescope）。
            assert (z - one) * g == z ** n - one
            # 第 2 段。z ∈ μ_n すなわち z^n = 1。
            assert z ** n - one == one - one
            # 第 3 段。同じ元どうしの差は零元。
            assert one - one == zero
            # 鎖の全体。
            assert (z - one) * g == zero
            count += 1
    print("   通過（z ≠ 1 である 1 の冪根 %d 件、n = 1..%d）" % (count, nmax))


def check_claim(nmax):
    print("2. 主張そのもの（G_n(z) = 0）: QQbar")
    one = QQbar(1)
    zero = QQbar(0)
    count = 0
    for n in range(1, nmax + 1):
        for z in roots_of_unity(n):
            if z == one:
                continue
            assert geometric_sum(z, n) == zero
            count += 1
    print("   通過（%d 件、n = 1..%d）" % (count, nmax))


def check_needs_hypothesis(nmax):
    print("3. 仮定 z ≠ 1 が要ること: QQbar")
    # z = 1 のときは G_n(1) = n であり、n ≥ 1 では零元にならない。
    for n in range(1, nmax + 1):
        assert geometric_sum(QQbar(1), n) == QQbar(n)
        assert geometric_sum(QQbar(1), n) != QQbar(0)
    print("   通過（z = 1 では G_n(1) = n ≠ 0、n = 1..%d）" % nmax)


def check_needs_root_of_unity(nmax):
    print("4. 仮定 z ∈ μ_n が要ること: QQbar")
    # 1 の n 乗根でない代数的数では、G_n(z) は一般に零元でない。
    others = [QQbar(2), QQbar(1) / QQbar(3), QQbar(2).sqrt()]
    count = 0
    for n in range(2, nmax + 1):
        for z in others:
            assert z ** n != QQbar(1)
            assert geometric_sum(z, n) != QQbar(0)
            count += 1
    print("   通過（1 の冪根でない元での反例 %d 件）" % count)


def check_noncommutative():
    print("5. 必要十分版の裏取り（可換でない環でも通ること）")
    # 必要十分版は「(z-1) が左逆元を持つこと」と伸縮の等式だけを使う。
    # 可換でない 2 次整数行列環で、z^n = 1 かつ z ≠ 1 の元を取って確かめる。
    R = MatrixSpace(ZZ, 2, 2)
    one = R.one()
    zero = R.zero()
    # 位数 4 の元（90 度回転）と位数 3 の元。
    z4 = R([[0, -1], [1, 0]])
    z3 = R([[0, -1], [1, -1]])
    assert z4 * z3 != z3 * z4
    for (z, n) in [(z4, 4), (z3, 3)]:
        assert z ** n == one
        assert z != one
        g = zero
        for k in range(n):
            g = g + z ** k
        assert (z - one) * g == z ** n - one
        assert (z - one) * g == zero
        assert g == zero
    print("   通過（2 次整数行列環の位数 4・位数 3 の元）")


print("=== claim_root_of_unity_geometric_sum_zero ===")
NMAX = 8
check_preparation(NMAX)
check_chain(NMAX)
check_claim(NMAX)
check_needs_hypothesis(NMAX)
check_needs_root_of_unity(NMAX)
check_noncommutative()
print("すべて通過")
