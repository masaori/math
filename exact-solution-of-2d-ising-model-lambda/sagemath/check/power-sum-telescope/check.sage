# 対象ラベル: claim_power_sum_telescope
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「倍数を指数とする冪と単位元の逆元との和は、約数を指数とするそれと冪の有限和との積である」
# （t^{dk} + iota(-kappa(1)) = (t^{d} + iota(-kappa(1))) * sum_{j<k} t^{dj}）を、
# 小さい d, k で総当たりに確かめる。
# 計算は ZZ / ZZ[x] / ZZ[x][t] の中の厳密計算だけで行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備の第一。iota(kappa(1)) が ZZ[x][t] の単位元、iota(kappa(0)) が零元であること。
#   2. 準備の第二。iota(kappa(1)) + u = iota(kappa(0))（u := iota(-kappa(1)) が単位元の
#      加法についての逆元であること）。
#   3. 帰納法の出発点（k = 0）。空集合にわたる有限和が零元であり、
#      (t^d + u) * 0 = 0 = iota(kappa(1)) + u = t^{d*0} + u であること。
#   4. 帰納法の一歩の各段（k から k+1 へ）。主張の左辺 t^{d(k+1)} + u から始まる
#      11 段の鎖の各行を順に確かめる。
#   5. 主張そのもの。すべての (d, k) で等式が成り立つこと。
#   6. 主張が空でないこと。両辺が零元でない (d, k) が実際にあること
#      （k = 0 では両辺が零元なので、それだけでは何も確かめたことにならない）。
#   7. 通常の書き方との一致。左辺が t^{dk} - 1、右辺の第 2 因子が 1 + t^d + ... + t^{d(k-1)}
#      に一致すること（引き算を使う書き方と、使わない書き方が同じ元を指していること）。
#   8. 応用の形。d が L の約数のとき（L = d * k）、t^{d} + u が t^{L} + u を割ること。
#      これは次のセクションで使う形であり、ZZ[x][t] の中の整除関係である。
#
# 走らせる範囲（打ち切りを隠さない）。
#   d = 0,...,8 と k = 0,...,8 の全組（81 組）。応用の形は L = 1,...,6 の全約数 d。
#   本文の主張は任意の d, k についてのものなので、有限個で確かめたことは証明ではない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


def iota_kappa(n):
    """整数を ZZ[x][t] の元として使う唯一の経路 iota o kappa。"""
    return iota(const_poly(n))


one = iota_kappa(1)
zero = iota_kappa(0)
u = iota(-const_poly(1))          # u := iota(-kappa(1))

D_RANGE = range(0, 9)
K_RANGE = range(0, 9)


def power_sum(d, k):
    """sum_{j in {j' in N | j' < k}} t^{d j}。有限和を定義どおり足し上げる。"""
    s = zero
    for j in range(k):
        s = s + t**(d * j)
    return s


# 1. 準備の第一。
assert one == SecondPolynomialRing.one(), '1: iota(kappa(1)) が単位元でない'
assert zero == SecondPolynomialRing.zero(), '1: iota(kappa(0)) が零元でない'
for d in D_RANGE:
    assert (t**d + u) * one == t**d + u, '1: 単位元を掛けて変わった'
    assert (t**d + u) * zero == zero, '1: 零元を掛けて零元にならない'

# 2. 準備の第二。
assert one + u == zero, '2: iota(kappa(1)) + u が零元でない'
assert u == iota_kappa(-1), '2: u と iota(kappa(-1)) が一致しない'

# 3. 帰納法の出発点（k = 0）。
for d in D_RANGE:
    assert power_sum(d, 0) == zero, '3: 空集合にわたる和が零元でない'
    assert (t**d + u) * power_sum(d, 0) == zero, '3: 出発点の右辺が零元でない'
    assert t**(d * 0) + u == zero, '3: 出発点の左辺が零元でない'
    assert (t**d + u) * power_sum(d, 0) == t**(d * 0) + u, '3: 出発点の等式が破れた'

# 4. 帰納法の一歩の各段（k から k+1 へ）。鎖の各行を順に確かめる。
for d in D_RANGE:
    for k in K_RANGE:
        lhs = t**(d * (k + 1)) + u
        step1 = t**(d * (k + 1)) + zero + u
        step2 = t**(d * (k + 1)) + (zero * t**(d * k)) + u
        step3 = t**(d * (k + 1)) + ((one + u) * t**(d * k)) + u
        step4 = t**(d * (k + 1)) + (one * t**(d * k) + u * t**(d * k)) + u
        step5 = t**(d * (k + 1)) + (t**(d * k) + u * t**(d * k)) + u
        step6 = (t**(d * k) + u) + (t**(d * (k + 1)) + u * t**(d * k))
        step7 = (t**(d * k) + u) + (t**d * t**(d * k) + u * t**(d * k))
        step8 = (t**(d * k) + u) + (t**d + u) * t**(d * k)
        step9 = (t**d + u) * power_sum(d, k) + (t**d + u) * t**(d * k)
        step10 = (t**d + u) * (power_sum(d, k) + t**(d * k))
        step11 = (t**d + u) * power_sum(d, k + 1)
        assert lhs == step1, '4: 第 1 段（零元を足しても変わらない）が破れた d=%s k=%s' % (d, k)
        assert step1 == step2, '4: 第 2 段（零元を掛けた積は零元）が破れた'
        assert step2 == step3, '4: 第 3 段（準備の第二）が破れた'
        assert step3 == step4, '4: 第 4 段（分配則）が破れた'
        assert step4 == step5, '4: 第 5 段（単位元）が破れた'
        assert step5 == step6, '4: 第 6 段（加法の結合則と可換則）が破れた'
        assert t**d * t**(d * k) == t**(d + d * k), '4: 指数法則が破れた'
        assert d + d * k == d * (k + 1), '4: 指数の計算が破れた'
        assert step6 == step7, '4: 第 7 段（指数法則）が破れた'
        assert step7 == step8, '4: 第 8 段（分配則）が破れた'
        # 帰納法の仮定（この検証では k についての等式を直接確かめる形で代用する）。
        assert (t**d + u) * power_sum(d, k) == t**(d * k) + u, '4: 帰納法の仮定が破れた'
        assert step8 == step9, '4: 第 9 段（帰納法の仮定）が破れた'
        assert step9 == step10, '4: 第 10 段（分配則）が破れた'
        # 添字の集合に属さない元を 1 つ足した有限和は、もとの和とその項の和である。
        assert step10 == step11, '4: 第 11 段（和へ最大の項を戻す）が破れた'

# 5. 主張そのもの。
for d in D_RANGE:
    for k in K_RANGE:
        assert t**(d * k) + u == (t**d + u) * power_sum(d, k), \
            '5: 主張が破れた d=%s k=%s' % (d, k)

# 6. 主張が空でないこと（両辺が零元でない組が実際にある）。
nonzero_pairs = [(d, k) for d in D_RANGE for k in K_RANGE if t**(d * k) + u != zero]
assert len(nonzero_pairs) > 0, '6: 両辺が零元でない組が無い（主張が空虚）'

# 7. 通常の書き方（引き算を使う形）との一致。
for d in D_RANGE:
    for k in K_RANGE:
        assert t**(d * k) + u == t**(d * k) - one, '7: 左辺が t^{dk} - 1 と一致しない'
        geometric = sum([t**(d * j) for j in range(k)], SecondPolynomialRing.zero())
        assert power_sum(d, k) == geometric, '7: 右辺の第 2 因子が幾何和と一致しない'

# 8. 応用の形。d が L の約数のとき t^{d} + u が t^{L} + u を割る。
application_rows = []
for L in range(1, 7):
    for d in divisors(L):
        k = L // d
        quotient = power_sum(d, k)
        assert (t**d + u) * quotient == t**L + u, \
            '8: 整除関係が破れた L=%s d=%s' % (L, d)
        assert (t**L + u) % (t**d + u) == zero, '8: 剰余が零元でない L=%s d=%s' % (L, d)
        application_rows.append((L, d, k))

print('claim_power_sum_telescope: すべて通過')
print('  d = %s, k = %s の全組（%s 組）' % (list(D_RANGE), list(K_RANGE), len(D_RANGE) * len(K_RANGE)))
print('  両辺が零元でない組: %s 組（k = 0 では両辺が零元）' % len(nonzero_pairs))
print('  応用の形（L, d, k = L/d）: %s' % application_rows)
