# 「部分体に元を代入した値の全体は部分体である」の段を厳密計算で確かめる。
# 対象ラベル: claim_qbar_poly_constant_term_shift_decomposition,
#   claim_subfield_coefficient_polynomials_ring_closed,
#   claim_subfield_polynomial_values_contains_subfield, claim_subfield_polynomial_values_contains_element,
#   claim_subfield_polynomial_values_ring_closed, claim_subfield_polynomial_values_evaluation_closed,
#   claim_minimal_vanishing_polynomial_constant_term_nonzero, claim_subfield_polynomial_values_is_subfield
# 帰属: 数体 Q(s)（s*s = 2）とその相対拡大の厳密計算。浮動小数点を使わない。

import random
random.seed(int(20261118))

failures = []
def check(cond, msg):
    if not cond:
        failures.append(msg)

R.<x> = QQ[]
K.<s> = NumberField(x^2 - 2)     # F = Q(s)
P.<t> = K[]                      # F[t]

def ac(f, k):
    return f[k] if k <= f.degree() else K(0)

def rand_F():
    return K(QQ(random.randint(-9, 9)) / random.randint(1, 5)) + K(QQ(random.randint(-9, 9)) / random.randint(1, 5)) * s

def rand_poly(deg):
    return P([rand_F() for _ in range(deg + 1)]) if deg >= 0 else P(0)

def aev(L, a, f):
    # 本文の aev_w: 零でない係数の項の有限和
    return sum((L(ac(f, k)) * a^k for k in range(f.degree() + 1) if ac(f, k) != 0), L(0))

def shift(p):
    # p' : ac_k(p') = ac_{k+1}(p)
    return P([ac(p, k + 1) for k in range(max(p.degree(), 0))])

minpolys = [t - s, t^2 - s, t^2 - 3, t^3 - 2, t^2 - s*t + 1]
cases = 0
for m in minpolys:
    n = m.degree()
    if n == 1:
        L = K; a = -m[0] / m[1]
    else:
        L = K.extension(m, 'a'); a = L.gen()
    for trial in range(40):
        # 定数項と不定元で割った残りへの分解
        p = rand_poly(random.randint(-1, 7))
        pp = shift(p)
        check(all(ac(pp, k) == ac(p, k + 1) for k in range(12)), "p' の係数")
        tp = t * pp
        check(ac(tp, 0) == sum(ac(t, i) * ac(pp, 0 - i) for i in range(1)), "ac_0(t p') の一行目")
        check(ac(tp, 0) == 0, "ac_0(t p') = 0")
        for k in range(1, 12):
            check(ac(tp, k) == sum(ac(t, i) * ac(pp, k - i) for i in range(k + 1)), "ac_k(t p') の一行目")
            check(ac(tp, k) == ac(t, 1) * ac(pp, k - 1) == ac(pp, k - 1) == ac(p, k), "ac_k(t p') の鎖")
        check(p == P(ac(p, 0)) + t * pp, "分解の等式")
        # 部分体係数の多項式の和・積・符号反転
        f = rand_poly(random.randint(-1, 6)); g = rand_poly(random.randint(-1, 6))
        for k in range(15):
            check(ac(f + g, k) == ac(f, k) + ac(g, k), "和の係数")
            check(ac(f * g, k) == sum(ac(f, i) * ac(g, k - i) for i in range(k + 1)), "積の係数")
            check(ac(-f, k) == -ac(f, k), "符号反転の係数")
        check(all(c in K for c in (f + g).list() + (f * g).list() + (-f).list()), "F[t] への所属")
        # 部分体と元の所属
        c = rand_F()
        check(aev(L, a, P(c)) == L(c), "aev(ĉ) = c")
        check(aev(L, a, t) == a, "aev(t) = α")
        # 値の全体の和・積・符号反転
        y = aev(L, a, f); z = aev(L, a, g)
        check(y + z == aev(L, a, f + g), "和の保存")
        check(y * z == aev(L, a, f * g), "積の保存")
        check(-y == aev(L, a, -f), "符号反転の保存")
        # 値の全体の元を代入した値: aev_y(h) = aev_α(h∘f)
        h = rand_poly(random.randint(-1, 4))
        check(aev(L, y, h) == aev(L, a, h(f)), "aev_y(h) は F[t] の元の α での値")
        for k in range(5):
            check(y^k == aev(L, a, f^k), "冪の段")
        # 逆元
        if y != 0:
            mp = y.minpoly() if n > 1 else (t - y)
            mp = P(mp)
            dm = mp.degree()
            c0 = rand_F()
            while c0 == 0:
                c0 = rand_F()
            pv = P(c0) * mp
            check(aev(L, y, pv) == 0, "p は y を根とする")
            check(all(ac(pv, k) == 0 for k in range(dm + 1, dm + 6)), "p の係数の上界")
            # 次数未満の零化多項式が無いこと（1, y, …, y^{dm-1} の F 上一次独立）
            if n > 1:
                M = matrix(K, [list(L(y^k).list()) for k in range(dm)])
                check(M.rank() == dm, "1, y, …, y^{m-1} の一次独立")
            # 定数項は零でない
            cc = ac(pv, 0)
            check(cc != 0, "ac_0(p) は零でない")
            pvp = shift(pv)
            check(pv == P(cc) + t * pvp, "p = ĉ + t p'")
            check(aev(L, y, pv) == cc + y * aev(L, y, pvp), "0 = c + y aev_y(p')")
            zz = (-cc^(-1)) * aev(L, y, pvp)
            check(y * zz == (-cc^(-1)) * (y * aev(L, y, pvp)), "y z の二行目")
            check((-cc^(-1)) * (y * aev(L, y, pvp)) == (-cc^(-1)) * (-cc), "y z の三行目")
            check(y * zz == 1, "y z = 1")
            check(zz == y^(-1), "y^{-1} = z")
            # 所属: z は F[t] の元 (-c^{-1})·(p'∘f) の α での値
            gz = P(-cc^(-1)) * pvp(f)
            check(all(cf in K for cf in gz.list()), "z の表示の多項式は F[t] に属する")
            check(aev(L, a, gz) == zz, "z は Val_F(α) の元")
            # 定数項が零の零化多項式 t·p は次数の上界 m を満たさない（主張の仮定の外）
            q = t * mp
            check(ac(q, 0) == 0 and ac(q, dm + 1) != 0, "t·p は上界 m を超える")
        cases += 1

if failures:
    print("FAILED:", len(failures))
    for f in failures[:20]:
        print("  ", f)
    raise SystemExit(1)
print("ALL PASSED (%d cases)" % cases)
