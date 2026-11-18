# 「正錐を係数とする平方和に一を足した多項式は偶数次である」の段を厳密計算で確かめる。
# 対象ラベル: claim_subfield_positive_cone_contains_nonzero_squares,
#   claim_qbar_poly_square_top_coefficient,
#   claim_one_plus_weighted_square_sum_polynomial_even_degree
# 帰属: F = Q(s)（s*s = 2）と、その正錐 C_F = { z : z の s -> +sqrt(2) の埋め込みでの値が正 } の厳密計算。
# 正錐の判定は数体の埋め込みの区間演算で行い、所属の判定にだけ使う（等号は数体の中で判定する）。

import random
random.seed(int(20261118))

failures = []
def check(cond, msg):
    if not cond:
        failures.append(msg)

R.<x> = QQ[]
K.<s> = NumberField(x^2 - 2, embedding=1.4)   # F = Q(s)
P.<t> = K[]

def ac(f, k):
    return f[k] if 0 <= k <= f.degree() else K(0)

def in_cone(z):
    # C_F: 正の埋め込み s -> sqrt(2) での値が正（区間で判定。零は除く）
    return z != 0 and RIF(z) > 0

def rand_F():
    return K(QQ(random.randint(-9, 9)) / random.randint(1, 5)) + K(QQ(random.randint(-9, 9)) / random.randint(1, 5)) * s

def rand_cone():
    while True:
        z = rand_F()
        if in_cone(z):
            return z

def rand_poly(deg):
    return P([rand_F() for _ in range(deg + 1)]) if deg >= 0 else P(0)

def poly_mul_coeff(f, g, k):
    # 本文の積の係数: sum_{i=0}^{k} ac_i(f) ac_{k-i}(g)
    return sum((ac(f, i) * ac(g, k - i) for i in range(k + 1)), K(0))

cases = 0
# 零でない元の平方は正錐に属する（a in C_F の場合と -a in C_F の場合）
for trial in range(200):
    a = rand_F()
    if a == 0:
        continue
    check(in_cone(a) or in_cone(-a), "三分法の被覆")
    check(not (in_cone(a) and in_cone(-a)), "三分法の排他性")
    check((-a) * (-a) == a * a, "(-a)(-a) = a a")
    check(in_cone(a * a), "a a in C_F")
    cases += 1
check(in_cone(K(1)), "1 in C_F")

# 係数の上界の二倍の番号の平方の係数
for trial in range(200):
    m = random.randint(0, 6)
    f = rand_poly(m)   # k > m で係数は零
    check(all(ac(f, k) == 0 for k in range(m + 1, m + 10)), "f の係数の上界")
    total = poly_mul_coeff(f, f, 2 * m)
    check(total == ac(f * f, 2 * m), "積の係数の定義")
    split = ac(f, m) * ac(f, 2 * m - m) + sum((ac(f, i) * ac(f, 2 * m - i) for i in range(2 * m + 1) if i != m), K(0))
    check(split == total, "番号 m の項を分ける")
    check(all(ac(f, i) * ac(f, 2 * m - i) == 0 for i in range(2 * m + 1) if i != m), "i != m の項は零")
    check(total == ac(f, m) * ac(f, m), "ac_{2m}(f f) = ac_m(f)^2")
    cases += 1

# 主張: P = 1 + sum c(i) g(i)^2
for trial in range(400):
    n = random.randint(0, 5)
    c = [rand_cone() for _ in range(n)]
    mode = random.randint(0, 3)
    if mode == 0:
        g = [P(0) for _ in range(n)]          # 全ての g(i) が零の場合
    else:
        g = [rand_poly(random.randint(-1, 5)) for _ in range(n)]
    Pp = P(1) + sum((P(c[i]) * g[i] * g[i] for i in range(n)), P(0))
    # 準備の式: ac_k(P) = ac_k(1) + sum c(i) ac_k(g(i) g(i))
    for k in range(14):
        one_k = K(1) if k == 0 else K(0)
        check(ac(Pp, k) == one_k + sum((c[i] * ac(g[i] * g[i], k) for i in range(n)), K(0)), "準備の式")
        check(all(ac(P(c[i]) * g[i] * g[i], k) == sum((ac(P(c[i]), j) * ac(g[i] * g[i], k - j) for j in range(k + 1)), K(0)) for i in range(n)), "定数多項式との積の係数")
    J = [i for i in range(n) if g[i] != 0]
    if not J:
        m = 0
        check(Pp == P(1), "全て零なら P = 1")
    else:
        d = {i: max(k for k in range(g[i].degree() + 1) if ac(g[i], k) != 0) for i in J}
        m = max(d.values())
        j = [i for i in J if d[i] == m][0]
        check(all(ac(g[i], k) == 0 for i in range(n) for k in range(m + 1, m + 8)), "k > m で ac_k(g(i)) = 0")
        check(ac(g[j], m) != 0, "ac_m(g(j)) != 0")
        check(all(ac(g[i] * g[i], 2 * m) == ac(g[i], m) * ac(g[i], m) for i in range(n)), "平方の係数")
        check(all(ac(g[i] * g[i], k) == 0 for i in range(n) for k in range(2 * m + 1, 2 * m + 8)), "k > 2m で平方の係数は零")
        u = [c[i] * (ac(g[i], m) * ac(g[i], m)) for i in range(n)]
        check(all(u[i] == 0 or in_cone(u[i]) for i in range(n)), "u(i) は零か C_F の元")
        check(in_cone(u[j]), "u(j) in C_F")
        r = sum((u[i] for i in range(n) if i != j), K(0))
        check(r == 0 or in_cone(r), "r は零か C_F の元")
        check(in_cone(u[j] + r), "u(j) + r in C_F")
        one_2m = K(1) if m == 0 else K(0)
        check(ac(Pp, 2 * m) == one_2m + (u[j] + r), "ac_{2m}(P) の鎖")
    check(in_cone(ac(Pp, 2 * m)), "ac_{2m}(P) in C_F")
    check(all(ac(Pp, k) == 0 for k in range(2 * m + 1, 2 * m + 10)), "k > 2m で ac_k(P) = 0")
    check(Pp != 0 and Pp.degree() == 2 * m, "P != 0 で最高次の番号は 2m")
    cases += 1

if failures:
    print("FAIL", len(failures), failures[:10])
else:
    print("PASS", cases)
