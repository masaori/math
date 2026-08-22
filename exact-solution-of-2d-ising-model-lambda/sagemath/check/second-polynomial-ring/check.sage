# 対象ラベル: def_second_polynomial_ring / def_second_constant_embedding
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   整係数多項式を係数とする、もう 1 つの不定元の多項式
#   定義   整係数多項式を定数として送る写像
# を、係数を小さい集合に限って総当たりに確かめる。
#
# 確かめること。
#   1. def_second_polynomial_ring。cf_k（t^k の係数）について、本文が書いた 2 つの等式
#      cf_k(f+g) = cf_k(f) + cf_k(g) と cf_k(fg) = sum_{i=0}^{k} cf_i(f) cf_{k-i}(g) が、
#      SageMath 自身の多項式環の和と積に対して成り立つこと。
#   2. def_second_constant_embedding。iota が和と積を保ち、iota(kappa(0)) が零元・
#      iota(kappa(1)) が単位元であり、iota が単射であること。
#
# 走らせる範囲（打ち切りを隠さない）。
#   係数は ZZ[x] の 6 元 {0, kappa(1), kappa(2), x, x+1, x^2-1} に限る。
#   **これは標本である。** 係数環 ZZ[x] は無限にあるので総当たりではない。
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

# 係数として使う ZZ[x] の元。kappa を通して整数を入れる（本文の約束どおり）。
COEFFS = [const_poly(0), const_poly(1), const_poly(2), x, x + const_poly(1), x ** 2 - const_poly(1)]
SMALL_COEFFS = [const_poly(0), const_poly(1), x]

def sample_elements(n, coeffs):
    """係数を coeffs から取り、t の次数が n 以下である元を全列挙する（標本の作り方）。"""
    out = []
    for tup in cartesian_product(coeffs, repeat=n + 1):
        out.append(sum((iota(c) * t ** k for k, c in enumerate(tup)),
                       SecondPolynomialRing(0)))
    return out


def check_ring_operations():
    """1. cf_k について、本文が書いた和と積の等式が成り立つ。"""
    elements = sample_elements(2, SMALL_COEFFS)
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

check_ring_operations()
check_iota()
print('すべてのアサーションが成立した（係数は ZZ[x] の 6 元に限った標本。厳密計算のみ）')
