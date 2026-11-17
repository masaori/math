# 「最小次数の零化多項式による整除と、代入した値の全体の表示」の段を厳密計算で確かめる。
# 対象ラベル: def_subfield_polynomial_values, claim_vanishing_polynomial_below_degree_is_zero,
#   claim_minimal_vanishing_polynomial_leading_coefficient_nonzero,
#   claim_minimal_vanishing_polynomial_divides, claim_subfield_polynomial_values_reduced_representation
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
    # 本文の aev_α: 零でない係数の項の有限和
    return sum((L(ac(f, k)) * a^k for k in range(f.degree() + 1) if ac(f, k) != 0), L(0))

# α ごとに、F 上の既約多項式 m（α の F 上の最小多項式）を与える
minpolys = [t - s, t^2 - s, t^2 - 3, t^3 - 2, t^2 - s*t + 1]
cases = 0
for m in minpolys:
    check(m.is_irreducible(), "m の既約性 %s" % m)
    n = m.degree()
    if n == 1:
        L = K; a = -m[0] / m[1]
    else:
        L = K.extension(m, 'a'); a = L.gen()
    check(aev(L, a, m) == 0, "α は m の根")
    # 次数の定義: 1, α, …, α^{n-1} は F 上一次独立（相対次数が n）、したがって deg_F(α) = n
    if n > 1:
        check(L.relative_degree() == n, "相対次数 %s" % m)
    for trial in range(60):
        # 次数未満の零化多項式は零: 係数の上界が n 未満の零でない q は α を根としない
        q = rand_poly(random.randint(0, n - 1))
        if q != 0:
            check(aev(L, a, q) != 0, "次数未満の零でない多項式の値は零でない")
        # 最小次数の零化多項式 p（m の零でない定数倍）
        c = rand_F()
        while c == 0:
            c = rand_F()
        p = P(c) * m
        check(all(ac(p, k) == 0 for k in range(n + 1, n + 6)), "p の係数の上界")
        check(aev(L, a, p) == 0, "p は α を根とする")
        # 番号 n の係数は零でない
        check(ac(p, n) != 0, "ac_n(p) は零でない")
        # 整除: α を根とする f = u0 · p
        u0 = rand_poly(random.randint(-1, 6))
        f = u0 * p
        check(aev(L, a, f) == 0, "f は α を根とする")
        u, r = f.quo_rem(p)
        check(f == u * p + r, "除法の等式")
        check(all(ac(r, k) == 0 for k in range(n, n + 8)), "余りの係数の上界")
        check(aev(L, a, r) == aev(L, a, f) - aev(L, a, u) * aev(L, a, p), "余りの値の一行目")
        check(aev(L, a, f) - aev(L, a, u) * aev(L, a, p) == 0 - aev(L, a, u) * 0, "余りの値の二行目")
        check(aev(L, a, r) == 0, "余りの値は零")
        check(r == 0, "余りは零")
        check(f == u * p and u == u0, "f = u · p")
        # 値の表示: 任意の f ∈ F[t] の値は、係数の上界が n 未満の r の値に等しい
        f = rand_poly(random.randint(-1, 9))
        u, r = f.quo_rem(p)
        y = aev(L, a, f)
        check(y == aev(L, a, u * p + r), "値の表示の一行目")
        check(aev(L, a, u * p + r) == aev(L, a, u) * aev(L, a, p) + aev(L, a, r), "値の表示の二行目")
        check(aev(L, a, u) * aev(L, a, p) + aev(L, a, r) == aev(L, a, u) * 0 + aev(L, a, r), "値の表示の三行目")
        check(y == aev(L, a, r), "値の表示の結論")
        check(all(ac(r, k) == 0 for k in range(n, n + 8)), "表示の多項式の係数の上界")
        check(all(cc in K for cc in r.list()), "表示の多項式の所属")
        cases += 1

if failures:
    print("FAILED:", len(failures))
    for f in failures[:20]:
        print("  ", f)
    raise SystemExit(1)
print("ALL PASSED (%d cases)" % cases)
