# 「奇数次の元を付け足した体では正錐を係数とする平方和が負の単位元にならない」の段を厳密計算で確かめる。
# 対象ラベル: claim_odd_degree_weighted_square_sum_avoids_minus_one
# 帰属: F = Q（正錐は正の有理数）と F = Q(s)（s*s = 2、正錐は s -> +sqrt(2) の埋め込みで正の元）。
# Val_F(alpha) は F 上の最小多項式による剰余体（数体）で表し、等号はすべてその中で判定する。
# 正錐の判定だけに埋め込みの区間演算を使う。浮動小数点で等号を判定しない。

import random
random.seed(int(20261118))

failures = []
def check(cond, msg):
    if not cond:
        failures.append(msg)

def ac(f, k):
    return f[k] if 0 <= k <= f.degree() else f.base_ring()(0)

cases = 0
factor_checks = 0

def run_case(Fring, in_cone, rand_F, rand_cone, minpoly, trials):
    # minpoly: F 上の既約多項式（次数 n が奇数）。alpha はその根で、Val_F(alpha) = Fring[t]/(minpoly)。
    global cases, factor_checks
    Pt = minpoly.parent()
    t = Pt.gen()
    n = minpoly.degree()
    check(n % 2 == 1, "deg_F(alpha) は奇数")
    check(minpoly.is_irreducible(), "最小多項式は既約")
    Kalpha = Fring.extension(minpoly, 'a')
    a = Kalpha.gen()
    j = (n - 1) // 2
    for trial in range(trials):
        r = random.randint(1, 4)
        c = [rand_cone() for _ in range(r)]
        # 簡約した表示: k >= n で ac_k(g(i)) = 0
        g = [Pt([rand_F() for _ in range(random.randint(0, n))]) if n >= 1 else Pt(0) for _ in range(r)]
        g = [gi if gi.degree() < n else gi % minpoly for gi in g]
        check(all(ac(gi, k) == 0 for gi in g for k in range(n, n + 6)), "k >= n で ac_k(g(i)) = 0")
        y = [gi(a) for gi in g]
        P = Pt(1) + sum((Pt(c[i]) * g[i] * g[i] for i in range(r)), Pt(0))
        # aev_alpha(P) の鎖
        check(P(a) == 1 + sum((c[i] * (g[i](a) * g[i](a)) for i in range(r)), Kalpha(0)), "aev の和・積の保存と定数の値")
        check(P(a) == 1 + sum((c[i] * (y[i] * y[i]) for i in range(r)), Kalpha(0)), "y(i) = aev_alpha(g(i))")
        # 主張の実例: -1 は Sq(C_F; Val_F(alpha)) のこの元ではない
        check(sum((c[i] * (y[i] * y[i]) for i in range(r)), Kalpha(0)) != -1, "-1 でない")
        check(P(a) != 0, "aev_alpha(P) != 0")
        # 偶数次: 最高次の番号 2m、ac_{2m}(P) in C_F、m < n
        check(P != 0, "P != 0")
        m2 = P.degree()
        check(m2 % 2 == 0, "最高次の番号は偶数")
        m = m2 // 2
        check(in_cone(ac(P, 2 * m)), "ac_{2m}(P) in C_F")
        check(m < n, "m < n")
        # n <= m の背理の段: 2m > 2(n-1) なら ac_{2m}(g g) = 0
        for gi in g:
            for mm in range(n, n + 3):
                check(ac(gi * gi, 2 * mm) == 0, "2m > 2(n-1) で平方の係数は零")
        # 奇数次の既約因子が無いこと（あればその根 beta で -1 in Sq(C_F; Val_F(beta)) になり、主張に反する）
        for (q, mult) in P.factor():
            check(q.degree() % 2 == 0, "P の F 上の既約因子は偶数次")
            factor_checks += 1
        cases += 1

# 番号の算術の段: e + n = 2m、m + 1 <= n、n = 2j+1 なら e は奇数で e + 2 <= n
for n in range(1, 40, 2):
    j = (n - 1) // 2
    for m in range(0, n):
        if 2 * m < n:
            continue
        e = 2 * m - n
        check(2 * m >= 2 * j + 1 and m >= j + 1, "m >= j+1")
        check(e == (e + n) - n and e == 2 * m - (2 * j + 1) and e == 2 * (m - j - 1) + 1, "e の鎖")
        check(e % 2 == 1, "e は奇数")
        check(e + n <= 2 * n - 2 and e + 2 <= n and e < n, "e < n")
        cases += 1
    # m + 1 <= n かつ e + n = 2m を満たす e が無い場合（n = 1）
    if n == 1:
        check(all(2 * m < n for m in range(0, n)), "n = 1 では e + n = 2m を満たす m < n が無い")

# 積の最高次の係数の段: ac_{e+n}(h p) = ac_e(h) ac_n(p) != 0、k > e+n で零
Rq.<t> = QQ[]
for trial in range(200):
    e = random.randint(0, 6)
    n = random.randint(1, 6)
    h = Rq([QQ(random.randint(-5, 5)) for _ in range(e)] + [QQ(random.choice([1, 2, -3]))])
    p = Rq([QQ(random.randint(-5, 5)) for _ in range(n)] + [QQ(random.choice([1, -1, 5]))])
    check(ac(h * p, e + n) == ac(h, e) * ac(p, n) and ac(h * p, e + n) != 0, "積の最高次の係数")
    check(all(ac(h * p, k) == 0 for k in range(e + n + 1, e + n + 6)), "k > e+n で積の係数は零")
    cases += 1

# F = Q
def q_rand():
    return QQ(random.randint(-9, 9)) / random.randint(1, 5)
def q_cone():
    return QQ(random.randint(1, 9)) / random.randint(1, 5)
for mp in [t - QQ(5) / 3, t^3 - 2, t^3 - 3*t - 1, t^5 - t - 1, t^5 - 4*t + 2, t^7 - 3]:
    run_case(QQ, lambda z: z > 0, q_rand, q_cone, mp, 60)

# F = Q(s)、s*s = 2
Rx.<x> = QQ[]
Ks.<s> = NumberField(x^2 - 2, embedding=1.4)
Ps.<u> = Ks[]
def s_in_cone(z):
    return z != 0 and RIF(z) > 0
def s_rand():
    return Ks(q_rand()) + Ks(q_rand()) * s
def s_cone():
    while True:
        z = s_rand()
        if s_in_cone(z):
            return z
for mp in [u - (1 + s), u^3 - s, u^3 + s*u + 1, u^5 - 2*u + s]:
    run_case(Ks, s_in_cone, s_rand, s_cone, mp, 40)

if failures:
    print("FAIL", len(failures), failures[:10])
else:
    print("PASS", cases, "factor checks", factor_checks)
