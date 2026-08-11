# 対象ラベル: claim_qbar_poly_indeterminate_power_coefficient
#            def_qbar_polynomial_ring
#
# 主張: 代数的数を係数とする 1 変数多項式環 Qbar[t] において、
#       ac_j(t^k) は j = k のとき 1、j ≠ k のとき 0 である。
#
# 人手証明の鎖の各段に対応させて、厳密計算（QQbar 係数の多項式環）で確かめる。
# 浮動小数点は使わない。

R.<t> = PolynomialRing(QQbar)


def ac(f, j):
    # ac_j(f)（def_qbar_polynomial_ring の係数）。
    return f[j]


def pow_rec(f, k):
    # f^k を定義どおり反復で作る（f^0 = 1、f^{j+1} = f^j f）。
    acc = R.one()
    for _ in range(k):
        acc = acc * f
    return acc


def check_ring_conventions(jmax):
    # 定義に置いた約束そのもの（不定元と単位元の係数、係数による相等）。
    print("0. 定義の約束（t と 1 の係数、係数による相等）")
    assert ac(t, 1) == QQbar(1)
    for j in range(0, jmax + 1):
        if j != 1:
            assert ac(t, j) == QQbar(0)
    assert ac(R.one(), 0) == QQbar(1)
    for j in range(1, jmax + 1):
        assert ac(R.one(), j) == QQbar(0)
    # 係数がすべて等しい 2 つの多項式は等しい（有限個の係数で見る）。
    f = pow_rec(t, 3) * R(QQbar(sqrt(2))) + R(QQbar(-1))
    g = R(QQbar(-1)) + R(QQbar(sqrt(2))) * pow_rec(t, 3)
    assert all(ac(f, j) == ac(g, j) for j in range(0, jmax + 1))
    assert f == g
    print("   通過（j = 0,...,%d）" % jmax)


def check_base(jmax):
    # 出発点（k = 0）。ac_j(t^0) = ac_j(1)。
    print("1. 出発点（k = 0）")
    zeroth = pow_rec(t, 0)
    assert zeroth == R.one()
    for j in range(0, jmax + 1):
        expected = QQbar(1) if j == 0 else QQbar(0)
        assert ac(zeroth, j) == expected
    print("   通過（j = 0,...,%d）" % jmax)


def check_step(kmax, jmax):
    # 一歩（k から k+1 へ）。場合 1（j = 0）と場合 2（j = j'+1）の鎖の各段。
    print("2. 一歩（鎖の各段）")
    for k in range(0, kmax + 1):
        tk = pow_rec(t, k)
        tk1 = pow_rec(t, k + 1)
        # 第 1 の等号（冪の約束 t^{k+1} = t^k t）
        assert tk1 == tk * t
        # 場合 1（j = 0）
        # 第 2 の等号（積の係数の定義。和は i = 0 の 1 項だけ）
        assert ac(tk * t, 0) == sum(ac(tk, i) * ac(t, 0 - i) for i in range(0, 1))
        # 第 3・第 4 の等号（ac_0(t) = 0）と第 5 の等号（零元との積は零元）
        assert ac(t, 0) == QQbar(0)
        assert ac(tk, 0) * ac(t, 0) == QQbar(0)
        assert ac(tk1, 0) == QQbar(0)
        assert 0 != k + 1
        # 場合 2（j = j'+1）
        for jp in range(0, jmax + 1):
            j = jp + 1
            # 第 2 の等号（積の係数の定義）
            assert ac(tk * t, j) == sum(
                ac(tk, i) * ac(t, j - i) for i in range(0, j + 1)
            )
            # 第 3 の等号（i = j' の項を取り出す）
            rest = sum(
                ac(tk, i) * ac(t, j - i) for i in range(0, j + 1) if i != jp
            )
            assert ac(tk * t, j) == ac(tk, jp) * ac(t, 1) + rest
            # 第 4 の等号（i ≠ j' では j'+1-i ≠ 1 なので ac_{j'+1-i}(t) = 0）
            for i in range(0, j + 1):
                if i != jp:
                    assert j - i != 1
                    assert ac(t, j - i) == QQbar(0)
            # 第 5・第 6・第 7 の等号（零元との積・零元の有限和・加法の単位元）
            assert rest == QQbar(0)
            # 第 8・第 9 の等号（ac_1(t) = 1 と積の単位元）
            assert ac(t, 1) == QQbar(1)
            assert ac(tk, jp) * ac(t, 1) == ac(tk, jp)
            # 第 10 の等号（帰納法の仮定）
            assert ac(tk, jp) == (QQbar(1) if jp == k else QQbar(0))
            # 後者の単射性（j' = k ⟺ j'+1 = k+1）
            assert (jp == k) == (jp + 1 == k + 1)
    print("   通過（k = 0,...,%d、j' = 0,...,%d）" % (kmax, jmax))


def check_claim(kmax, jmax):
    print("3. 主張そのもの（ac_j(t^k) は j = k のとき 1、そうでなければ 0）")
    for k in range(0, kmax + 1):
        tk = pow_rec(t, k)
        for j in range(0, jmax + 1):
            expected = QQbar(1) if j == k else QQbar(0)
            assert ac(tk, j) == expected
    print("   通過（k = 0,...,%d、j = 0,...,%d）" % (kmax, jmax))


def check_usage(kmax):
    # 使い道: 係数を用いた単項式の有限和が、もとの多項式に戻ること
    #        （因数定理でくくり出す部分の足場）。
    print("4. 使い道（係数を用いた単項式の有限和がもとの多項式に戻る）")
    samples = [
        R.zero(),
        R.one(),
        t,
        pow_rec(t, 3) - R(QQbar(2)),
        R(QQbar(sqrt(2))) * pow_rec(t, 2) + R(QQbar(I)) * t + R(QQbar(-1)),
    ]
    for f in samples:
        rebuilt = R.zero()
        for j in range(0, kmax + 1):
            rebuilt = rebuilt + R(ac(f, j)) * pow_rec(t, j)
        assert rebuilt == f
    print("   通過（次数 %d まで）" % kmax)


def main():
    check_ring_conventions(8)
    check_base(8)
    check_step(6, 6)
    check_claim(6, 8)
    check_usage(6)
    print("すべて通過")


main()
