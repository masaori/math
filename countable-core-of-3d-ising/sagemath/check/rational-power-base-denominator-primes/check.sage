# 対象ラベル: claim_rational_power_base_denominator_primes
# 有限箱の値 Z_L(q)（q = a/b、a と b は互いに素）を整数の商 P_L / b^{#E_L} として表し、
# b を割らない素数 p では v_p(Z_L(q)) >= 0 であること、および点数乗表示
# Z_L(q) = c^{#V_L} を仮定したときに v_p(c) >= 0、既約分数 c = u/v で v_p(v) = 0 に
# なることを確認する。あわせて分子の側が同じ論法では出ないことを、
# a も b も割らない素数が P_L を割る実例で示す。
# 帰属: ZZ・QQ と有限和・有限積だけを使う。極限、浮動小数点、実対数、指数関数は使わない。

# 自由境界の立方箱。頂点は {0,...,L-1}^3、辺は座標をひとつだけ 1 増やす対。
def box_vertices(L):
    return [(x, y, z) for x in range(L) for y in range(L) for z in range(L)]

def box_edges(L):
    E = []
    for v in box_vertices(L):
        for d in range(3):
            w = list(v); w[d] += 1; w = tuple(w)
            if w[d] < L:
                E.append((v, w))
    return E

# 破れ辺数ごとの多重度 Omega_L(m)（全配位の総当たり）。
def multiplicities(L):
    V = box_vertices(L); E = box_edges(L)
    idx = {v: i for i, v in enumerate(V)}
    Om = [ZZ(0)] * (len(E) + 1)
    for s in range(2 ** len(V)):
        m = 0
        for (v, w) in E:
            if ((s >> idx[v]) & 1) != ((s >> idx[w]) & 1):
                m += 1
        Om[m] += 1
    return Om

# 段 1: Z_L(q) = P_L / b^{#E_L} が QQ の等式として成り立つこと（本文の代入と共通因子のくくり出し）。
def P_L(Om, a, b, nE):
    return sum(Om[m] * ZZ(a) ** m * ZZ(b) ** (nE - m) for m in range(nE + 1))

def Z_L_at(Om, q, nE):
    return sum(Om[m] * QQ(q) ** m for m in range(nE + 1))

CASES = [(1, 3), (2, 3), (3, 2), (5, 4), (7, 9), (1, 1)]

print("== 段 1: Z_L(q) = P_L / b^{#E_L} ==")
DATA = {}
for L in [1, 2]:
    Om = multiplicities(L); nE = len(box_edges(L)); nV = len(box_vertices(L))
    assert nE == 3 * L ** 2 * (L - 1), (L, nE)
    assert nV == L ** 3
    DATA[L] = (Om, nE, nV)
    for (a, b) in CASES:
        assert gcd(ZZ(a), ZZ(b)) == 1
        q = QQ(a) / QQ(b)
        lhs = Z_L_at(Om, q, nE)
        p = P_L(Om, a, b, nE)
        assert p > 0, (L, a, b, p)
        assert lhs == QQ(p) / QQ(b) ** nE, (L, a, b)
    print("  L =", L, "PASS（#E_L =", nE, "、#V_L =", nV, "）")

print("== 段 2: p が b を割らないなら v_p(Z_L(q)) = v_p(P_L) >= 0 ==")
for L in [1, 2]:
    Om, nE, nV = DATA[L]
    for (a, b) in CASES:
        q = QQ(a) / QQ(b)
        z = Z_L_at(Om, q, nE); p_int = P_L(Om, a, b, nE)
        for pr in [2, 3, 5, 7, 11, 13]:
            if ZZ(b) % pr == 0:
                continue
            assert ZZ(z.valuation(pr)) == ZZ(p_int.valuation(pr))
            assert ZZ(z.valuation(pr)) >= 0
    print("  L =", L, "PASS")

print("== 段 3: 点数乗表示から v_p(c) >= 0、既約分数で v_p(v) = 0 ==")
# 有理点 1 では Z_L(1) = 2^{#V_L} なので c = 2 が実際に取れる（b = 1 なのですべての素数が対象）。
for L in [1, 2]:
    Om, nE, nV = DATA[L]
    z1 = Z_L_at(Om, QQ(1), nE)
    assert z1 == ZZ(2) ** nV, (L, z1)
    c = QQ(2); u = c.numerator(); v = c.denominator()
    assert gcd(u, v) == 1
    for pr in [2, 3, 5, 7, 11, 13]:
        assert ZZ(nV) * ZZ(c.valuation(pr)) == ZZ(z1.valuation(pr))
        assert ZZ(c.valuation(pr)) >= 0
        assert ZZ(v.valuation(pr)) == 0
    print("  L =", L, "PASS（c = 2、v = 1）")

print("== 段 4: 分子の側は同じ論法では出ない（a も b も割らない素数が P_L を割る実例）==")
found = []
Om, nE, nV = DATA[2]
for (a, b) in CASES:
    p_int = P_L(Om, a, b, nE)
    for pr in prime_range(2, 200):
        if ZZ(a) % pr != 0 and ZZ(b) % pr != 0 and p_int % pr == 0:
            found.append((a, b, pr, ZZ(p_int.valuation(pr))))
            break
assert len(found) > 0, "分子の側の反証例が見つからない"
for (a, b, pr, e) in found:
    print("  q =", a, "/", b, ": 素数", pr, "は a も b も割らないが P_2 を割る（v_p =", e, "）")
print("  PASS（分子の側の制約はこの論法からは出ない）")

print("ALL PASS")
