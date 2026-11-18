# 「奇数次の多項式は部分体上の次数が奇数の根を持つ」の段を厳密計算で確かめる。
# 対象ラベル: claim_qbar_poly_product_top_coefficient,
#   claim_odd_degree_polynomial_has_odd_degree_root
# 帰属: F = Q と F = Q(s)（s*s = 2）の厳密計算。根は F 上の既約因子で表し、
#   deg_F(beta) は beta の F 上の既約因子の次数（最小次数の零化多項式は既約因子の定数倍）として読む。
#   F = Q の場合は根を QQbar の元として取り、値が零であることも QQbar で判定する。浮動小数点は使わない。

import random
random.seed(int(20261118))

failures = []
def check(cond, msg):
    if not cond:
        failures.append(msg)

R.<x> = QQ[]
K.<s> = NumberField(x^2 - 2)

def ac(f, k):
    return f[k] if 0 <= k <= f.degree() else f.base_ring()(0)

def poly_mul_coeff(f, g, k):
    return sum((ac(f, i) * ac(g, k - i) for i in range(k + 1)), f.base_ring()(0))

cases = 0
even_steps = [0]

# 係数の上界の和の番号での積の係数
for base in [QQ, K]:
    P.<t> = base[]
    def rand_el():
        a = QQ(random.randint(-9, 9)) / random.randint(1, 4)
        if base is K:
            return base(a) + base(QQ(random.randint(-9, 9)) / random.randint(1, 4)) * s
        return base(a)
    for trial in range(150):
        a = random.randint(0, 5); b = random.randint(0, 5)
        f = P([rand_el() for _ in range(a + 1)]); g = P([rand_el() for _ in range(b + 1)])
        check(all(ac(f, k) == 0 for k in range(a + 1, a + 8)), "f の上界")
        check(all(ac(g, k) == 0 for k in range(b + 1, b + 8)), "g の上界")
        total = poly_mul_coeff(f, g, a + b)
        check(total == ac(f * g, a + b), "積の係数の定義")
        check(all(ac(f, i) * ac(g, a + b - i) == 0 for i in range(a + b + 1) if i != a), "i != a の項は零")
        split = ac(f, a) * ac(g, (a + b) - a) + sum((ac(f, i) * ac(g, a + b - i) for i in range(a + b + 1) if i != a), base(0))
        check(split == total, "番号 a の項を分ける")
        check(total == ac(f, a) * ac(g, b), "ac_{a+b}(f g) = ac_a(f) ac_b(g)")
        cases += 1

# 主張: 証明の帰納法をそのまま手続きにして、各段を確かめる
def odd_root(f, n, depth=0):
    # 戻り値: (beta を表す F 上の既約因子 q, deg_F(beta))
    P = f.parent()
    check(n % 2 == 1 and ac(f, n) != 0 and all(ac(f, k) == 0 for k in range(n + 1, n + 6)), "主張の仮定")
    # 根を取る: f の F 上の既約因子のうち一つ（無作為に選ぶ）の根を beta とする
    facs = [q for (q, e) in f.factor()]
    q = random.choice(facs)
    p = q.monic()                 # beta の最小次数の零化多項式（定数倍は p を取り直すだけ）
    d = p.degree()
    check(ac(p, d) != 0, "ac_d(p) != 0")
    check(d >= 1, "d >= 1")
    if P.base_ring() is QQ:
        beta = p.roots(QQbar)[0][0]
        check(f.change_ring(QQbar)(beta) == 0, "aev_beta(f) = 0")
        check(p.change_ring(QQbar)(beta) == 0, "aev_beta(p) = 0")
        check(beta.minpoly().degree() == d, "deg_F(beta) = d")
    else:
        check(p.is_irreducible(), "p は F 上既約（deg_F(beta) = d）")
    # 割る
    u, r = f.quo_rem(p)
    check(r == 0 and f == u * p, "f = u p")
    check(u != 0, "u != 0")
    e = u.degree()
    check(ac(u, e) != 0 and all(ac(u, k) == 0 for k in range(e + 1, e + 6)), "e の取り方")
    check(ac(f, e + d) == ac(u, e) * ac(p, d), "ac_{e+d}(f) = ac_e(u) ac_d(p)")
    check(ac(u, e) * ac(p, d) != 0, "積は零でない")
    check(all(ac(u * p, k) == 0 for k in range(e + d + 1, e + d + 6)), "k > e+d で ac_k(u p) = 0")
    check(e + d == n, "e + d = n")
    if d % 2 == 1:
        check(d <= n, "d <= n")
        return (p, d)
    even_steps[0] += 1
    h = d // 2; j = (n - 1) // 2
    check(d == 2 * h and h <= j, "d = 2h, h <= j")
    check(e == (e + d) - d == n - d == (2 * j + 1) - 2 * h == 2 * (j - h) + 1, "e の鎖")
    check(e < n, "e < n")
    (q2, d2) = odd_root(u, e, depth + 1)
    # aev_gamma(f) = aev_gamma(u) aev_gamma(p) = 0: gamma は u の既約因子 q2 の根なので f = u p の因子でもある
    check(f % q2 == 0, "q2 | f（aev_gamma(f) = 0）")
    if P.base_ring() is QQ:
        gamma = q2.roots(QQbar)[0][0]
        check(u.change_ring(QQbar)(gamma) == 0, "aev_gamma(u) = 0")
        check(f.change_ring(QQbar)(gamma) == u.change_ring(QQbar)(gamma) * p.change_ring(QQbar)(gamma), "値は積を保つ")
        check(f.change_ring(QQbar)(gamma) == 0, "aev_gamma(f) = 0")
    check(d2 % 2 == 1 and d2 <= e and d2 < n, "deg_F(gamma) は奇数で e 以下")
    return (q2, d2)

for base in [QQ, K]:
    P.<t> = base[]
    def rand_el():
        a = QQ(random.randint(-6, 6)) / random.randint(1, 3)
        if base is K:
            return base(a) + base(QQ(random.randint(-6, 6)) / random.randint(1, 3)) * s
        return base(a)
    def rand_irred(deg):
        while True:
            q = P([rand_el() for _ in range(deg)] + [base(1)])
            if q.is_irreducible():
                return q
    for trial in range(120):
        # 偶数次の既約因子を多めに含めて、帰納法の段（d が偶数の場合）を通す
        while True:
            parts = [rand_irred(random.choice([1, 2, 2, 3, 4])) for _ in range(random.randint(1, 4))]
            f = prod(parts) * rand_el()
            if f != 0 and f.degree() % 2 == 1:
                break
        n = f.degree()
        (q, d) = odd_root(f, n)
        check(d % 2 == 1 and d <= n and f % q == 0, "主張の結論")
        cases += 1

if failures:
    print("FAIL", len(failures), failures[:10])
else:
    check(even_steps[0] > 0, "d が偶数の段を通った")
    print("PASS", cases, "（d が偶数で帰納法の仮定を当てた段", even_steps[0], "回）")
