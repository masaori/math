# 「部分体を係数とする多項式は、最高次の係数が零でない多項式で割れる」の段を厳密計算で確かめる。
# 対象ラベル: claim_subfield_coefficient_polynomial_division
# 帰属: 数体 Q(s)（s*s = 2）と QQ の厳密計算。浮動小数点を使わない。

import random
random.seed(int(20261117))

failures = []
def check(cond, msg):
    if not cond:
        failures.append(msg)

R.<x> = QQ[]
K.<s> = NumberField(x^2 - 2)     # F = Q(s) のモデル
P.<t> = K[]                      # F[t] のモデル（係数が F に属する多項式）

def ac(f, k):
    # 本文の ac_k: k が次数を超えれば零元
    return f[k] if k <= f.degree() else K(0)

def rand_F():
    return K(QQ(random.randint(-9, 9)) / random.randint(1, 5)) + K(QQ(random.randint(-9, 9)) / random.randint(1, 5)) * s

def rand_poly(deg):
    return P([rand_F() for _ in range(deg + 1)])

def in_F_t(f):
    return all(c in K for c in f.list())

def divide(g, h, n, d):
    # 本文の帰納法 P(d) をそのまま辿る。戻り値 (u, r)。
    # 前提: k >= d で ac_k(g) = 0。
    check(all(ac(g, k) == 0 for k in range(d, d + 5 + max(g.degree(), 0))), "g の上界 d=%d" % d)
    if d <= n:
        # 割る必要のない場合: u := 0, r := g
        u, r = P(0), g
        check(u * h + r == g, "割る必要のない場合の等式")
        check(all(ac(r, k) == 0 for k in range(n, n + 5 + max(g.degree(), 0))), "割る必要のない場合の余り")
        return u, r
    e = d - 1                     # 本文の d（一歩の前の番号）。e >= n
    check(e >= n, "一歩の場合分け")
    c = ac(g, e) / ac(h, n)
    m = e - n
    mono = P(c) * t^m
    # 単項式の係数の段
    for i in range(0, m + 4):
        prod_sum = sum(ac(P(c), j) * ac(t^m, i - j) for j in range(0, i + 1))
        check(prod_sum == (c if i == m else 0), "単項式の係数 i=%d m=%d" % (i, m))
        check(ac(mono, i) == (c if i == m else 0), "単項式の係数（多項式環）i=%d" % i)
    check(in_F_t(mono), "単項式の所属")
    # 単項式を掛けた係数の段
    sh = mono * h
    for k in range(0, m + n + 4):
        val = sum(ac(mono, i) * ac(h, k - i) for i in range(0, k + 1))
        expect = c * ac(h, k - m) if k >= m else K(0)
        check(val == expect and ac(sh, k) == expect, "単項式を掛けた係数 k=%d" % k)
    gp = g - sh
    check(in_F_t(gp), "g' の所属")
    for k in range(e + 1, e + 6):
        check(ac(gp, k) == ac(g, k) - c * ac(h, k - m), "k >= d+1 の一行目 k=%d" % k)
        check(ac(g, k) == 0 and ac(h, k - m) == 0, "k >= d+1 の二行目 k=%d" % k)
        check(ac(gp, k) == 0, "k >= d+1 の結論 k=%d" % k)
    check(ac(gp, e) == ac(g, e) - c * ac(h, n), "k = d の一行目")
    check(ac(g, e) - (ac(g, e) / ac(h, n)) * ac(h, n) == ac(g, e) - ac(g, e), "k = d の三行目")
    check(ac(gp, e) == 0, "k = d の結論")
    up, r = divide(gp, h, n, e)
    u = up + mono
    check(in_F_t(u), "u の所属")
    check(g == gp + sh, "合成の一行目")
    check(gp + sh == up * h + r + sh, "合成の二行目")
    check(up * h + r + sh == u * h + r, "合成の三行目")
    return u, r

cases = 0
for trial in range(400):
    n = random.randint(0, 5)
    h = rand_poly(n)
    while ac(h, n) == 0:
        h = rand_poly(n)
    dg = random.randint(-1, 10)
    g = P(0) if dg < 0 else rand_poly(dg)
    # 結論の段: 係数の尽きる番号 d（次数 + 1。g = 0 なら 0）
    d = g.degree() + 1 if g != 0 else 0
    u, r = divide(g, h, n, d)
    check(g == u * h + r, "主張の等式")
    check(in_F_t(u) and in_F_t(r), "商と余りの所属")
    check(all(ac(r, k) == 0 for k in range(n, n + 12)), "余りの係数の上界")
    # Sage の除法と一致（最高次の係数が零でないので商と余りは一意）
    qq, rr = g.quo_rem(h)
    check(qq == u and rr == r, "Sage の除法と一致")
    cases += 1

if failures:
    print("FAILED:", len(failures))
    for f in failures[:20]:
        print("  ", f)
    raise SystemExit(1)
print("ALL PASSED (%d cases)" % cases)
