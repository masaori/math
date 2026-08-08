# 対象ラベル: def_second_polynomial_ring / def_second_constant_embedding /
#             def_second_degree_bound / def_second_monic /
#             claim_second_degree_sum / claim_second_degree_prod /
#             claim_second_monic_prod / claim_second_monic_add_lower
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   整係数多項式を係数とする、もう 1 つの不定元の多項式
#   定義   整係数多項式を定数として送る写像
#   定義   次数が与えられた自然数以下である元の全体
#   定義   モニックな、次数がちょうど与えられた自然数である元の全体
#   主張   次数が n 以下である元の有限和は、次数が n 以下である
#   主張   次数の上界は有限積で足し合わされる
#   主張   モニックな元の有限積はモニックであり、その次数は次数の和である
#   主張   モニックな元に次数の低い元を足してもモニックである
# を、係数を小さい集合に限って総当たりに確かめる。
#
# 確かめること。
#   1. def_second_polynomial_ring。cf_k（t^k の係数）について、本文が書いた 2 つの等式
#      cf_k(f+g) = cf_k(f) + cf_k(g) と cf_k(fg) = sum_{i=0}^{k} cf_i(f) cf_{k-i}(g) が、
#      SageMath 自身の多項式環の和と積に対して成り立つこと。
#      本文はこの 2 つの等式だけから 4 主張を導いているので、これは前提の確認である。
#   2. def_second_constant_embedding。iota が和と積を保ち、iota(kappa(0)) が零元・
#      iota(kappa(1)) が単位元であり、iota が単射であること。
#   3. def_second_degree_bound / def_second_monic。本文の述語（係数で書いたもの）が、
#      SageMath 自身の degree() / leading_coefficient() による判定と一致すること。
#      作り方が独立なので、上界の向き（k > n か k >= n か）の取り違えを検出できる。
#      あわせて M_n の n が一意であること（本文が定義の中で示していること）も見る。
#   4. claim_second_degree_sum。D_n の元の有限和が D_n に入ること（2 項・3 項）。
#   5. claim_second_degree_prod。D_m と D_n の元の積が D_{m+n} に入ること（2 項・3 項）。
#      あわせて、この上界が一般には等号にならないこと（因子が 0 のとき次数が落ちる）も見る。
#      上界の主張であることを検証側でも固定するためである。
#   6. claim_second_monic_prod。M_m と M_n の元の積が M_{m+n} に入ること（2 項・3 項）。
#      空積が M_0 の元であることも見る（人手証明の帰納法の出発点）。
#   7. claim_second_monic_add_lower。M_n の元に D_{n'}（n' < n）の元を足すと M_n に入ること。
#      あわせて n' = n の場合には成り立たないことがある（最高次の係数が変わる）ことも見る。
#      本文の仮定 n' < n が空でないことを固定するためである。
#
# 走らせる範囲（打ち切りを隠さない）。
#   係数は ZZ[x] の 6 元 {0, kappa(1), kappa(2), x, x+1, x^2-1} に限る。
#   D_n は n = 0, 1, 2 について、係数をこの 6 元から取る元を全列挙する（それぞれ 6, 36, 216 個）。
#   M_n は n = 0, 1, 2 について、最高次を kappa(1) に固定し下位を 6 元から取る（1, 6, 36 個）。
#   2 項の主張は上の集合の全対、3 項の主張は係数を 3 元 {0, kappa(1), x} に絞った集合の全 3 つ組。
#   **これは標本である。** 係数環 ZZ[x] も次数も無限にあるので総当たりではない。
#
# 厳密計算のみ（ZZ、ZZ[x]、ZZ[x][t]）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os
from itertools import product as cartesian_product

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
# 不定元を lambda と呼ばないのは本文と同じ理由（lambda は対数順序群の元、かつ Python の予約語）。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def cf(f, k):
    """def_second_polynomial_ring: f の t^k の係数 cf_k(f) を ZZ[x] の元として返す。"""
    return PolynomialRingZx(SecondPolynomialRing(f)[k])


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


def in_deg_le(f, n):
    """def_second_degree_bound: f in D_n か（k > n のすべての k で cf_k(f) = 0 か）。"""
    for k in range(n + 1, n + 8):
        if cf(f, k) != 0:
            return False
    return True


def in_monic_deg(f, n):
    """def_second_monic: f in M_n か（D_n の元で、cf_n(f) = kappa(1) か）。"""
    return in_deg_le(f, n) and cf(f, n) == const_poly(1)


# 係数として使う ZZ[x] の元。kappa を通して整数を入れる（本文の約束どおり）。
COEFFS = [const_poly(0), const_poly(1), const_poly(2), x, x + const_poly(1), x ** 2 - const_poly(1)]
SMALL_COEFFS = [const_poly(0), const_poly(1), x]


def deg_le_elements(n, coeffs):
    """係数を coeffs から取った、次数 n 以下の元をすべて列挙する（D_n の部分集合）。"""
    return [
        sum((c * t ** k for k, c in enumerate(tup)), SecondPolynomialRing(0))
        for tup in cartesian_product(coeffs, repeat=n + 1)
    ]


def monic_deg_elements(n, coeffs):
    """係数を coeffs から取った、モニックな次数 n の元をすべて列挙する（M_n の部分集合）。"""
    return [
        t ** n + sum((c * t ** k for k, c in enumerate(tup)), SecondPolynomialRing(0))
        for tup in cartesian_product(coeffs, repeat=n)
    ]


def check_ring_operations():
    """1. cf_k について、本文が書いた和と積の等式が成り立つ。"""
    elements = deg_le_elements(2, SMALL_COEFFS)
    for f in elements:
        for g in elements:
            for k in range(6):
                assert cf(f + g, k) == cf(f, k) + cf(g, k), (f, g, k)
                convolution = sum((cf(f, i) * cf(g, k - i) for i in range(k + 1)),
                                  PolynomialRingZx(0))
                assert cf(f * g, k) == convolution, (f, g, k)
    print('OK: cf_k(f+g) と cf_k(fg) が本文の等式どおりであることを',
          len(elements), '個の元の全対 × k = 0..5 で確認した')


def check_iota():
    """2. iota は和と積を保ち、零元・単位元を送り、単射である。"""
    for a in COEFFS:
        for b in COEFFS:
            assert iota(a + b) == iota(a) + iota(b), (a, b)
            assert iota(a * b) == iota(a) * iota(b), (a, b)
            if a != b:
                assert iota(a) != iota(b), (a, b)
        assert cf(iota(a), 0) == a, a
        for k in range(1, 5):
            assert cf(iota(a), k) == 0, (a, k)
    assert iota(const_poly(0)) == SecondPolynomialRing(0)
    assert iota(const_poly(1)) == SecondPolynomialRing(1)
    print('OK: iota は和と積を保ち、iota(kappa(0)) は零元・iota(kappa(1)) は単位元であり、単射である')


def check_predicates_match_sage():
    """3. 本文の述語が Sage 自身の degree / leading_coefficient と一致する。"""
    for n in range(3):
        for f in deg_le_elements(n, COEFFS):
            # Sage の degree は零多項式で -1 を返す。D_n はそれも含む。
            assert in_deg_le(f, n) == (f.degree() <= n), (f, n)
            for n2 in range(4):
                assert in_deg_le(f, n2) == (f.degree() <= n2), (f, n2)
                monic_by_sage = (f.degree() == n2 and f.leading_coefficient() == const_poly(1))
                assert in_monic_deg(f, n2) == monic_by_sage, (f, n2)
        for f in monic_deg_elements(n, COEFFS):
            assert in_monic_deg(f, n), (f, n)
            # M_n の n は一意（本文が定義の中で示していること）。
            for n2 in range(4):
                if n2 != n:
                    assert not in_monic_deg(f, n2), (f, n, n2)
    print('OK: D_n と M_n の判定が Sage の degree / leading_coefficient と一致し、M_n の n は一意である')


def check_degree_sum():
    """4. D_n の元の有限和は D_n の元である。"""
    for n in range(3):
        elements = deg_le_elements(n, COEFFS)
        # 空和は零元であり、どの D_n にも属する（帰納法の出発点）。
        assert in_deg_le(SecondPolynomialRing(0), n), n
        for f in elements:
            for g in elements:
                assert in_deg_le(f + g, n), (f, g, n)
        small = deg_le_elements(n, SMALL_COEFFS)
        for f in small:
            for g in small:
                for h in small:
                    assert in_deg_le(f + g + h, n), (f, g, h, n)
    print('OK: D_n の元の 2 項和・3 項和が D_n に属することを n = 0, 1, 2 で確認した')


def check_degree_prod():
    """5. D_m と D_n の元の積は D_{m+n} の元である（上界であり、等号ではない）。"""
    for m in range(3):
        for n in range(3):
            for f in deg_le_elements(m, COEFFS):
                for g in deg_le_elements(n, COEFFS):
                    assert in_deg_le(f * g, m + n), (f, g, m, n)
    for m in range(3):
        small_f = deg_le_elements(m, SMALL_COEFFS)
        for f in small_f:
            for g in small_f:
                for h in small_f:
                    assert in_deg_le(f * g * h, 3 * m), (f, g, h, m)
    # 空積は単位元であり D_0 に属する（帰納法の出発点）。
    assert in_deg_le(SecondPolynomialRing(1), 0)
    # 上界が等号でない例（因子が零元のとき次数が落ちる）。本文が上界の形で述べていることの確認。
    f0 = t + const_poly(1)
    assert in_deg_le(f0, 1) and in_deg_le(f0 * SecondPolynomialRing(0), 2)
    assert (f0 * SecondPolynomialRing(0)).degree() < 2
    print('OK: D_m と D_n の元の積が D_{m+n} に属すること（2 項の全対・3 項）と、')
    print('    その上界が一般には等号でないことを確認した')


def check_monic_prod():
    """6. M_m と M_n の元の積は M_{m+n} の元である。"""
    for m in range(3):
        for n in range(3):
            for f in monic_deg_elements(m, COEFFS):
                for g in monic_deg_elements(n, COEFFS):
                    assert in_monic_deg(f * g, m + n), (f, g, m, n)
    for m in range(3):
        small_f = monic_deg_elements(m, SMALL_COEFFS)
        for f in small_f:
            for g in small_f:
                for h in small_f:
                    assert in_monic_deg(f * g * h, 3 * m), (f, g, h, m)
    # 空積は単位元 iota(kappa(1)) であり M_0 に属する（帰納法の出発点）。
    assert in_monic_deg(iota(const_poly(1)), 0)
    print('OK: M_m と M_n の元の積が M_{m+n} に属することを（2 項の全対・3 項）確認した')


def check_monic_add_lower():
    """7. M_n の元に D_{n'}（n' < n）の元を足しても M_n の元である。"""
    for n in range(1, 4):
        for f in monic_deg_elements(n, COEFFS):
            for n2 in range(n):
                for g in deg_le_elements(n2, COEFFS):
                    assert in_monic_deg(f + g, n), (f, g, n, n2)
    # n' = n では成り立たないことがある（最高次の係数が変わる）。仮定 n' < n が空でないことの確認。
    f1 = t ** 2
    g1 = t ** 2
    assert in_monic_deg(f1, 2) and in_deg_le(g1, 2)
    assert not in_monic_deg(f1 + g1, 2)
    print('OK: M_n の元に D_{n\'}（n\' < n）の元を足すと M_n に属することを n = 1, 2, 3 で確認し、')
    print('    n\' = n では成り立たない例があることも確認した')


check_ring_operations()
check_iota()
check_predicates_match_sage()
check_degree_sum()
check_degree_prod()
check_monic_prod()
check_monic_add_lower()
print('すべてのアサーションが成立した（係数は ZZ[x] の 6 元に限った標本。厳密計算のみ）')
