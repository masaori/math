# 主張「次数の 2 の冪の指数を一つ下げた部分体係数の一次因子の積が虚数単位を足した体に根を持てば、
# 指数を一つ上げた積も根を持つ」の段を、標本で一行ずつ確かめる。
# 対象ラベル: claim_subfield_polynomial_root_induction_step
# 帰属: 標本は有理係数の多項式の分解体（数体）の厳密な元。F を実代数的数の体、K = F(ω) を代数的数の全体と読むと、
# K への所属は自明であり、この検査が確かめるのは等号・係数の所属・数え上げ・鳩の巣の段である。
# 浮動小数点は使わない。

from itertools import combinations

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def is_odd(n):
    return n % 2 == 1

def two_adic(d):
    k = 0
    while d % 2 == 0:
        d //= 2; k += 1
    return k, d

S.<x> = QQ[]
# 有理係数（F に含まれる）で、次数の 2 進付値 k ≥ 1 の多項式の標本。根は分解体（数体）の元として厳密に扱う
samples = [x^2 - 2*x + 5, x^2 + 1, x^2 + 3, x^4 - 10*x^2 + 1, x^4 + 1, x^6 - 1, x^6 + x^3 + 1]
for f0 in samples:
    d = f0.degree()
    k, m = two_adic(d)
    check(k >= 1 and is_odd(m) and d == 2^k * m, "d = 2^k·m、k ≥ 1、m は奇数")
    check(2^k * m >= 1 * 1 and 1 * 1 == 1, "準備の式鎖: d = 2^k·m ≥ 1·1 = 1")
    Lf = (f0 * (x^2 + 1)).splitting_field('z')
    omega = (x^2 + 1).roots(Lf)[0][0]
    check(omega * omega == -1, "ω^2 = -1")
    R.<t> = PolynomialRing(Lf)
    alpha = []
    for rt, mult in f0.roots(Lf):
        alpha += [rt] * mult
    check(len(alpha) == d and prod(t - a for a in alpha) == R(f0.list()), "f = ∏(t - α(i))")
    Pr = [(i, j) for i in range(d) for j in range(d) if i < j]
    N = len(Pr)
    check(N + N == d * (d - 1), "対の個数 N+N = d(d-1)")
    mp = m * (d - 1)
    check(is_odd(mp) and N == 2^(k - 1) * mp, "m' = m(d-1) は奇数で N = 2^{k-1}·m'")
    nu = Pr
    for choice in range(N):
        # 帰納法の仮定が与える r_c を、全ての c で同じ番号 choice に取る場合と、c ごとにずらす場合
        for shift in [0, 1]:
            phi = []
            rsel = []
            for c in range(N + 1):
                beta = [alpha[i] + alpha[j] + c * alpha[i] * alpha[j] for (i, j) in nu]
                g = prod(t - b for b in beta)
                check(all(co in QQ for co in g.list()), "g_c ∈ F[t]（f が有理係数なので有理係数）")
                r_c = (choice + shift * c) % N
                check(g(beta[r_c]) == 0, "β_c(r_c) は g_c の根")
                rsel.append(r_c)
                phi.append(nu[r_c])
            found = None
            for c, cp in combinations(range(N + 1), 2):
                if phi[c] == phi[cp]:
                    found = (c, cp); break
            check(found is not None, "鳩の巣: c < c' で φ(c) = φ(c')")
            c, cp = found
            i, j = phi[c]
            a, b = alpha[i], alpha[j]
            i1, j1 = nu[rsel[c]]; i2, j2 = nu[rsel[cp]]
            u = a + b + c * a * b
            up = a + b + cp * a * b
            check(u == alpha[i1] + alpha[j1] + c * alpha[i1] * alpha[j1], "第一のずらしの式鎖の第一の等号")
            check(up == alpha[i2] + alpha[j2] + cp * alpha[i2] * alpha[j2], "第二のずらしの式鎖の第一の等号")
            check((u - up) / (c - cp) == a * b and u - c * (a * b) == a + b, "二つのずらしから積と和")
            p = -(a + b); q = a * b
            for gam, _ in (t^2 + p * t + q).roots():
                check(1 * gam^2 + p * gam + q == 0, "1·γ^2 + pγ + q = 0")
                check(gam * gam - (a + b) * gam + a * b == 1 * gam^2 + p * gam + q, "式鎖の第一の等号")
                check(gam == a or gam == b, "和が入る二数の主張の結論 γ ∈ {α(i), α(j)}")
            check(prod(a - al for al in alpha) == 0 and i < d, "α(i) は f の根で i < d")

print("PASS %d" % passes if not failures else "FAIL %s" % failures)
