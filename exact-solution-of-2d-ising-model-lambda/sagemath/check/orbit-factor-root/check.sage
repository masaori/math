# 対象ラベル: claim_orbit_factor_root
#   併せて確かめる定義: def_second_evaluation
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「軌道ごとの因子の値を 0 にする代数的数は 1 の冪根である」
# （ev_{xi,z}(t^m + iota(-kappa(1))) = 0 ならば z in mu_m）を、小さい m で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は SageMath の
# QQbar（厳密な代数的数の体）で表し、1 の m 乗根の全体 mu_m は円分体 QQ(zeta_m) の中で
# 全列挙してから QQbar へ移す。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 定義どおりの ev_{xi,z} を係数の有限和として組み、SageMath の多項式の代入と
#      一致すること（def_second_evaluation が定義であって主張でないことの裏取り）。
#   2. 鎖の第 1 段。ev(t^m + iota(-kappa(1))) = ev(t^m) + ev(iota(-kappa(1)))。
#   3. 鎖の第 2 段。ev(t^m) = z^m。
#   4. 鎖の第 3〜5 段。ev(iota(-kappa(1))) = (-kappa(1))(xi) = -(kappa(1))(xi) = -1。
#      各段を別々の等式として確かめる。
#   5. 鎖の全体。ev(t^m + iota(-kappa(1))) = z^m - 1。
#   6. 主張そのもの。値が 0 になる z がちょうど mu_m の元であること
#      （すなわち値 0 => z in mu_m と、その逆も成り立つこと）。
#   7. 値が 0 にならない z が実際にあること（主張が空虚でないこと）。
#   8. m = 0 の場合。因子は ZZ[x][t] の零元であり、値は常に 0 で、mu_0 = Qbar なので
#      結論が自動的に成り立つこと。
#
# 走らせる範囲（打ち切りを隠さない）。
#   m = 0,...,8、xi は 4 個（0, 1, -3/2, sqrt(2)）、z は mu_m の全元と、
#   1 の冪根でない 3 個（2, 1/3, sqrt(2)）。
#   本文の主張は任意の m, xi, z についてのものなので、有限個で確かめたことは証明ではない。

M_MAX = 8

Zx = PolynomialRing(ZZ, 'x')
x = Zx.gen()
Zxt = PolynomialRing(Zx, 't')
t = Zxt.gen()


def kappa(n):
    """整数から ZZ[x] の定数多項式を与える写像 kappa。"""
    return Zx(n)


def iota(a):
    """ZZ[x] の元を ZZ[x][t] の定数として送る写像 iota。"""
    return Zxt(a)


def ev(f, xi, z):
    """def_second_evaluation の ev_{xi,z} を、定義どおり係数の有限和として組む。"""
    total = QQbar(0)
    for k, c in enumerate(f.list()):
        if c == kappa(0):
            continue
        total += QQbar(c(xi)) * QQbar(z) ** k
    return total


def roots_of_unity(m):
    """1 の m 乗根の全体 mu_m を厳密に全列挙し、QQbar の元として返す。"""
    if m == 0:
        # mu_0 = Qbar。全列挙はできないので、代表を数個だけ返す（呼び出し側で扱いを分ける）。
        return [QQbar(0), QQbar(1), QQbar(-1), QQbar(2), QQbar(2).sqrt()]
    if m == 1:
        return [QQbar(1)]
    if m == 2:
        return [QQbar(1), QQbar(-1)]
    K = CyclotomicField(m)
    zeta = K.gen()
    return [QQbar(zeta ** j) for j in range(m)]


XIS = [QQbar(0), QQbar(1), QQbar(-3) / QQbar(2), QQbar(2).sqrt()]
NON_ROOTS = [QQbar(2), QQbar(1) / QQbar(3), QQbar(2).sqrt()]


def check_m(m):
    factor = t ** m + iota(-kappa(1))

    for xi in XIS:
        # 1: 定義どおりに組んだ ev が SageMath の代入と一致すること。
        for z in roots_of_unity(m)[:3] + NON_ROOTS:
            direct = QQbar(sum(QQbar(c(xi)) * QQbar(z) ** k
                               for k, c in enumerate(factor.list())))
            assert ev(factor, xi, z) == direct, (m, xi, z, '定義どおりの評価と一致しない')

        for z in roots_of_unity(m) + NON_ROOTS:
            zz = QQbar(z)

            # 2: 鎖の第 1 段。和を保つこと。
            assert ev(factor, xi, zz) == ev(t ** m, xi, zz) + ev(iota(-kappa(1)), xi, zz), \
                (m, xi, zz, '第 1 段（和を保つ）が破れた')

            # 3: 鎖の第 2 段。t^m の値は z^m。
            assert ev(t ** m, xi, zz) == zz ** m, (m, xi, zz, '第 2 段（t^m の値）が破れた')

            # 4: 鎖の第 3〜5 段。定数項の値。
            assert ev(iota(-kappa(1)), xi, zz) == QQbar((-kappa(1))(xi)), \
                (m, xi, zz, '第 3 段（iota(a) の値は a(xi)）が破れた')
            assert QQbar((-kappa(1))(xi)) == -QQbar((kappa(1))(xi)), \
                (m, xi, '第 4 段（逆元を逆元へ）が破れた')
            assert QQbar((kappa(1))(xi)) == QQbar(1), (m, xi, '第 5 段（kappa(1) の値は 1）が破れた')

            # 5: 鎖の全体。
            assert ev(factor, xi, zz) == zz ** m - QQbar(1), (m, xi, zz, '鎖の全体が破れた')

            # 6: 主張そのもの。値 0 <=> z^m = 1（m = 0 では両辺とも常に真）。
            is_zero = (ev(factor, xi, zz) == QQbar(0))
            is_root = (zz ** m == QQbar(1))
            assert is_zero == is_root, (m, xi, zz, '主張（値 0 と 1 の冪根であることの一致）が破れた')
            if is_zero:
                assert is_root, (m, xi, zz, '主張の結論が破れた')

        # 7: 値が 0 にならない z が実際にあること（m >= 1 のとき）。
        if m >= 1:
            assert any(ev(factor, xi, QQbar(z)) != QQbar(0) for z in NON_ROOTS), \
                (m, xi, '値が 0 でない z が 1 つも無い（主張が空虚）')

    # 8: m = 0 の場合。因子は ZZ[x][t] の零元。
    if m == 0:
        assert factor == Zxt(0), 'm = 0 で因子が零元になっていない'
        for xi in XIS:
            for z in roots_of_unity(0) + NON_ROOTS:
                assert ev(factor, xi, QQbar(z)) == QQbar(0), (xi, z, 'm = 0 で値が 0 でない')
                assert QQbar(z) ** 0 == QQbar(1), (z, 'm = 0 で z^0 = 1 が破れた')


def main():
    for m in range(0, M_MAX + 1):
        check_m(m)
        print('m = %d: 通過' % m)
    print('すべて通過（m = 0,...,%d、xi は %d 個、z は mu_m の全元と 1 の冪根でない %d 個）'
          % (M_MAX, len(XIS), len(NON_ROOTS)))


main()
