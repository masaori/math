# 対象ラベル: claim_second_evaluation_prod
#   併せて引く定義: def_second_evaluation
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「代数的数における値を取る写像は、有限積を有限積へ写す」
# （ev_{xi,z}(prod_{i in s} f_i) = prod_{i in s} ev_{xi,z}(f_i)）を、小さい s で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は SageMath の
# QQbar（厳密な代数的数の体）で表す。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 帰納法の出発点。s が空のとき ev(1) = 1（左辺は ZZ[x][t] の単位元の値、
#      右辺は Qbar の単位元）。
#   2. 帰納法の一歩の第 2 段。ev が積を保つこと（ev(f*g) = ev(f)*ev(g)）。
#   3. 主張そのもの。s のすべての部分集合について両辺が一致すること。
#   4. 応用の形。因子を軌道ごとの因子 t^m + iota(-kappa(1)) に取ったときにも成り立つこと
#      （次のセクションが chi_U の積へこれを当てるため）。
#   5. 主張が空虚でないこと。両辺の値が 1 でも 0 でもない組が実際にあること。
#   6. ev が和を保つことをこの証明が使っていないことの裏取りとして、和を保たない写像でも
#      「単位元を保ち積を保つ」だけあれば同じ結論が出ること（写像 f |-> ev(f)^2 は
#      和を保たないが積は保つ）。
#
# 走らせる範囲（打ち切りを隠さない）。
#   因子の族は 5 個の ZZ[x][t] の元からなり、その全 32 部分集合を s として走る。
#   xi は 4 個（0, 1, -3/2, sqrt(2)）、z は 4 個（0, 2, -1/3, sqrt(2)）。
#   応用の形は m = 0,...,4 の 5 個の因子の全 32 部分集合。
#   本文の主張は任意の s, f, xi, z についてのものなので、有限個で確かめたことは証明ではない。

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


def subsets(items):
    """有限集合の全部分集合を、添字の集合として列挙する。"""
    out = []
    for mask in range(2 ** len(items)):
        out.append([items[i] for i in range(len(items)) if (mask >> i) & 1])
    return out


FAMILY = [
    t ** 2 + iota(x),
    t + iota(-kappa(1)),
    iota(kappa(3)),
    t ** 3 + iota(kappa(2)) * t + iota(x ** 2 - kappa(1)),
    t,
]

ORBIT_FACTORS = [t ** m + iota(-kappa(1)) for m in range(0, 5)]

XIS = [QQbar(0), QQbar(1), QQbar(-3) / QQbar(2), QQbar(2).sqrt()]
ZS = [QQbar(0), QQbar(2), QQbar(-1) / QQbar(3), QQbar(2).sqrt()]


def prod_left(fs):
    """ZZ[x][t] の中の有限積（左辺の積）。"""
    p = Zxt(1)
    for f in fs:
        p = p * f
    return p


def prod_right(fs, xi, z):
    """Qbar の中の有限積（右辺の積）。"""
    p = QQbar(1)
    for f in fs:
        p = p * ev(f, xi, z)
    return p


def check_family(family, name):
    nontrivial = False
    for xi in XIS:
        for z in ZS:
            # 1: 帰納法の出発点。空の積の値は Qbar の単位元。
            assert ev(Zxt(1), xi, z) == QQbar(1), (xi, z, '空の積（単位元）の値が 1 でない')

            for fs in subsets(family):
                # 3（応用の形なら 4）: 主張そのもの。
                lhs = ev(prod_left(fs), xi, z)
                rhs = prod_right(fs, xi, z)
                assert lhs == rhs, (name, xi, z, len(fs), '有限積を有限積へ写すことが破れた')

                # 5: 空虚でないこと。
                if lhs != QQbar(0) and lhs != QQbar(1) and len(fs) >= 2:
                    nontrivial = True

            # 2: 帰納法の一歩の第 2 段。ev が積を保つこと。
            for f in family:
                for g in family:
                    assert ev(f * g, xi, z) == ev(f, xi, z) * ev(g, xi, z), \
                        (name, xi, z, '第 2 段（ev が積を保つこと）が破れた')

    assert nontrivial, (name, '両辺が 1 でも 0 でもない組が 1 つも無い（主張が空虚）')


def check_mul_only():
    """6: 和を保たないが単位元と積を保つ写像でも同じ結論が出ること。"""
    def h(f, xi, z):
        return ev(f, xi, z) ** 2

    xi = XIS[3]
    z = ZS[1]

    # 和は保たない（保たない例が実際にあること）。
    f0, f1 = FAMILY[0], FAMILY[1]
    assert h(f0 + f1, xi, z) != h(f0, xi, z) + h(f1, xi, z), \
        '和を保たない写像のつもりが和を保っている（裏取りにならない）'

    for fs in subsets(FAMILY):
        lhs = h(prod_left(fs), xi, z)
        rhs = QQbar(1)
        for f in fs:
            rhs = rhs * h(f, xi, z)
        assert lhs == rhs, (len(fs), '和を保たない写像で有限積の保存が破れた')


def main():
    check_family(FAMILY, '一般の形')
    print('一般の形（5 個の因子の全 32 部分集合）: 通過')
    check_family(ORBIT_FACTORS, '応用の形（軌道ごとの因子）')
    print('応用の形（m = 0,...,4 の因子の全 32 部分集合）: 通過')
    check_mul_only()
    print('和を保たない写像での裏取り: 通過')
    print('すべて通過（xi は %d 個、z は %d 個）' % (len(XIS), len(ZS)))


main()
