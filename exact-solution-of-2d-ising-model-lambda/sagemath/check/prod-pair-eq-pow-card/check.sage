# 対象ラベル: claim_prod_pair_eq_pow_card
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「各因子の積が同じ値であるとき、軌道の集合にわたる 2 つの有限積の積は、
#   その値の個数を指数とする冪である」
#   （すべての O in s について a(O) * b(O) = c ならば
#     (prod_{O in s} a(O)) * prod_{O in s} b(O) = c^{|s|}）
# を、小さい L で総当たりに確かめる。
# 計算は ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 出発点（s = 空集合）の鎖の 5 段。
#      空集合にわたる 2 つの有限積 -> 単位元 * 積 -> 単位元 * 単位元 -> 単位元 -> c^0 -> c^{|空集合|}。
#   2. 帰納法の一歩（s に属さない O_0 を 1 つ足す）の鎖の 7 段。
#      有限積を分ける段 2 つ・乗法の結合則と可換則・帰納法の仮定・仮定 a(O_0) b(O_0) = c・
#      冪の定義・元の個数が 1 増えること。
#   3. 主張そのもの。O_L のすべての部分集合 s について等式が成り立つこと。
#   4. 主張が空虚でないこと。|s| >= 2 で、かつ a(O) が O によって実際に異なる例があること。
#   5. 仮定が外せないこと。1 つの O_0 だけ a(O_0) b(O_0) != c にすると等式が破れる例があること。
#
# 添字集合の作り方（本文と同じく O_L の部分集合を走る）:
#   O_L は行配位 R_L の巡回シフトによる軌道の全体である（def_row_config_orbit_set）。
#   a, b, c は本文では任意の写像・元なので、2 通りの取り方で確かめる。
#     (i) 応用の形。c = t^L + u、a(O) = t^{|O|} + u、b(O) = sum_{j < L/|O|} t^{|O| j}
#         （claim_orbit_sum_divides_pow_L がこの形を与える）。
#     (ii) 一般の形。c を 3 つの因子の積とし、各 O へ因子の分け方を変えて割り当てる
#         （a(O) が O ごとに違う値を取り、応用の形に特有の構造を使っていないことを見る）。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1,...,5 は O_L のすべての部分集合（|O_L| <= 8 なので高々 256 通り）。
#   L = 6 は O_L の元が 14 個で部分集合が 16384 通りあるので、
#   全体集合・すべての 1 元部分集合・すべての 2 元部分集合に絞る（下で件数を出力する）。
#   本文の主張は任意の s についてのものなので、有限個で確かめたことは証明ではない。

import os
from itertools import combinations, product as iproduct

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
u = iota_kappa(-1)   # u := iota(-kappa(1))。単位元の加法についての逆元。


def row_configs(L):
    """def_row_config: 行配位 R_L = {tau : {0,...,L-1} -> {+1,-1}} をタプルで表す。"""
    return list(iproduct([1, -1], repeat=L))


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(y +_{Z/LZ} 1bar)。"""
    return tuple(tau[(y + 1) % L] for y in range(L))


def orbits(L):
    """def_row_config_orbit_set: 巡回シフトによる軌道の全体 O_L。"""
    seen = set()
    out = []
    for tau in row_configs(L):
        if tau in seen:
            continue
        orb = set()
        cur = tau
        while cur not in orb:
            orb.add(cur)
            cur = row_shift(L, cur)
        seen |= orb
        out.append(frozenset(orb))
    return out


def geom(L, card):
    """sum_{j < L/card} t^{card * j}（claim_orbit_sum_divides_pow_L の相手の側）。"""
    k = L // card
    s = iota_kappa(0)
    for j in range(k):
        s += t ** (card * j)
    return s


def prod_over(sub, f):
    """有限積 prod_{O in sub} f(O)。空集合にわたる有限積は単位元である。"""
    p = one
    for O in sub:
        p *= f(O)
    return p


# ---------------------------------------------------------------
# a, b, c の 2 通りの取り方
# ---------------------------------------------------------------

def setting_application(L, orbs):
    """(i) 応用の形。c = t^L + u、a(O) = t^{|O|} + u、b(O) = sum_{j < L/|O|} t^{|O| j}。"""
    c = t ** L + u
    a = {O: t ** len(O) + u for O in orbs}
    b = {O: geom(L, len(O)) for O in orbs}
    return a, b, c


def setting_general(L, orbs):
    """(ii) 一般の形。c を 3 因子の積とし、O ごとに因子の分け方を変える。"""
    f1 = t + iota_kappa(1)
    f2 = t + iota(PolynomialRingZx(x))     # 係数に x を含む因子（ZZ[x][t] の中で動くこと）
    f3 = t ** 2 + iota_kappa(3)
    c = f1 * f2 * f3
    splits = [
        (one, f1 * f2 * f3),
        (f1, f2 * f3),
        (f2, f1 * f3),
        (f3, f1 * f2),
        (f1 * f2, f3),
        (f1 * f3, f2),
        (f2 * f3, f1),
        (f1 * f2 * f3, one),
    ]
    a = {}
    b = {}
    for i, O in enumerate(sorted(orbs, key=lambda s: (len(s), sorted(s)))):
        p, q = splits[i % len(splits)]
        a[O] = p
        b[O] = q
    return a, b, c


SETTINGS = [("応用の形", setting_application), ("一般の形", setting_general)]


def subsets_to_check(L, orbs):
    """走らせる部分集合。L <= 5 は全部分集合、L = 6 は全体・1 元・2 元に絞る。"""
    n = len(orbs)
    if L <= 5:
        out = []
        for r in range(n + 1):
            out += [list(s) for s in combinations(orbs, r)]
        return out, "すべての部分集合"
    out = [list(orbs)]
    out += [[O] for O in orbs]
    out += [list(s) for s in combinations(orbs, 2)]
    return out, "全体集合・1 元部分集合・2 元部分集合"


# ---------------------------------------------------------------
# 1. 出発点（s = 空集合）の鎖の 5 段
# ---------------------------------------------------------------
print("== 1. 出発点（s = 空集合）の鎖の 5 段 ==")
for L in range(1, 7):
    orbs = orbits(L)
    for name, make in SETTINGS:
        a, b, c = make(L, orbs)
        lhs = prod_over([], lambda O: a[O]) * prod_over([], lambda O: b[O])
        step1 = one * prod_over([], lambda O: b[O])
        step2 = one * one
        step3 = one
        step4 = c ** 0
        step5 = c ** len([])
        assert lhs == step1, (L, name, "空集合にわたる有限積は単位元である")
        assert step1 == step2, (L, name, "空集合にわたる有限積は単位元である")
        assert step2 == step3, (L, name, "iota(kappa(1)) は単位元である")
        assert step3 == step4, (L, name, "零乗は単位元である")
        assert step4 == step5, (L, name, "|空集合| = 0")
print("  通過（L = 1,...,6、2 通りの取り方）")


# ---------------------------------------------------------------
# 2. 帰納法の一歩の鎖の 7 段
# ---------------------------------------------------------------
print("== 2. 帰納法の一歩の鎖の 7 段 ==")
step_count = 0
for L in range(1, 7):
    orbs = orbits(L)
    subs, _range_note = subsets_to_check(L, orbs)
    for name, make in SETTINGS:
        a, b, c = make(L, orbs)
        for s in subs:
            for O0 in orbs:
                if O0 in s:
                    continue
                s1 = list(s) + [O0]
                lhs = prod_over(s1, lambda O: a[O]) * prod_over(s1, lambda O: b[O])
                # 第 1 段: a 側の有限積を分ける
                e1 = (prod_over(s, lambda O: a[O]) * a[O0]) * prod_over(s1, lambda O: b[O])
                # 第 2 段: b 側の有限積を分ける
                e2 = (prod_over(s, lambda O: a[O]) * a[O0]) * (prod_over(s, lambda O: b[O]) * b[O0])
                # 第 3 段: 乗法の結合則と可換則
                e3 = (prod_over(s, lambda O: a[O]) * prod_over(s, lambda O: b[O])) * (a[O0] * b[O0])
                # 第 4 段: 帰納法の仮定
                e4 = c ** len(s) * (a[O0] * b[O0])
                # 第 5 段: 仮定 a(O_0) b(O_0) = c
                e5 = c ** len(s) * c
                # 第 6 段: 冪の定義
                e6 = c ** (len(s) + 1)
                # 第 7 段: 属さない元を 1 つ足した有限集合の元の個数は 1 増える
                e7 = c ** len(s1)
                assert lhs == e1, (L, name, "有限積を分ける段（a 側）")
                assert e1 == e2, (L, name, "有限積を分ける段（b 側）")
                assert e2 == e3, (L, name, "乗法の結合則と可換則")
                assert e3 == e4, (L, name, "帰納法の仮定")
                assert e4 == e5, (L, name, "仮定 a(O_0) b(O_0) = c")
                assert e5 == e6, (L, name, "冪の定義")
                assert e6 == e7, (L, name, "元の個数が 1 増える")
                step_count += 1
print("  通過（一歩の組は %d 通り）" % step_count)


# ---------------------------------------------------------------
# 3. 主張そのもの
# ---------------------------------------------------------------
print("== 3. 主張そのもの ==")
claim_count = 0
for L in range(1, 7):
    orbs = orbits(L)
    subs, range_note = subsets_to_check(L, orbs)
    for name, make in SETTINGS:
        a, b, c = make(L, orbs)
        # 仮定の確認（すべての O について a(O) b(O) = c）
        for O in orbs:
            assert a[O] * b[O] == c, (L, name, "仮定 a(O) b(O) = c が成り立っていない")
        for s in subs:
            lhs = prod_over(s, lambda O: a[O]) * prod_over(s, lambda O: b[O])
            assert lhs == c ** len(s), (L, name, "主張が破れた", len(s))
            claim_count += 1
    print("  L = %d: 軌道 %d 個、%s（%d 通り）を確認" % (L, len(orbs), range_note, len(subs)))
print("  通過（部分集合と取り方の組は %d 通り）" % claim_count)


# ---------------------------------------------------------------
# 4. 主張が空虚でないこと
# ---------------------------------------------------------------
print("== 4. 主張が空虚でないこと ==")
for L in range(2, 7):
    orbs = orbits(L)
    a, b, c = setting_general(L, orbs)
    distinct = len(set(str(a[O]) for O in orbs))
    assert distinct >= 2, (L, "a(O) が O によらず一定になっている")
    s = list(orbs)
    assert len(s) >= 2, (L, "部分集合の元が 2 個未満")
    assert c ** len(s) != one, (L, "右辺が単位元で、確かめたことにならない")
    print("  L = %d: |s| = %d、a(O) の相異なる値は %d 個、右辺の次数は %d"
          % (L, len(s), distinct, (c ** len(s)).degree()))


# ---------------------------------------------------------------
# 5. 仮定が外せないこと
# ---------------------------------------------------------------
print("== 5. 仮定が外せないこと ==")
broken = 0
for L in range(2, 7):
    orbs = orbits(L)
    a, b, c = setting_general(L, orbs)
    O0 = sorted(orbs, key=lambda s: (len(s), sorted(s)))[0]
    b_bad = dict(b)
    b_bad[O0] = b[O0] + one          # a(O_0) b(O_0) != c になるように 1 つだけ壊す
    assert a[O0] * b_bad[O0] != c, (L, "壊し方が効いていない")
    s = list(orbs)
    lhs = prod_over(s, lambda O: a[O]) * prod_over(s, lambda O: b_bad[O])
    assert lhs != c ** len(s), (L, "仮定を壊しても等式が成り立ってしまった")
    broken += 1
print("  通過（L = 2,...,6 の %d 例で、1 つ壊すと等式が破れた）" % broken)

print("すべて通過")
