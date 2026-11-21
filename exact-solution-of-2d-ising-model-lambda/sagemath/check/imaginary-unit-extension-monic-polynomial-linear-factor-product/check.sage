# 主張「虚数単位を足した体を係数とする最高次の係数が一の多項式は、その体の元を根とする一次因子の積である」
# の帰納法を一行ずつ確かめる。
# 対象ラベル: claim_imaginary_unit_extension_monic_polynomial_linear_factor_product
# 帰属: 標本は QQbar の厳密な元と QQbar[t] の多項式。浮動小数点は使わない。
# 標本の部分体は二つ。
#   F = AA（実代数的数）: 主張の仮定（正の元は平方、奇数次の多項式は根を持つ）を満たす。Lin_F(ω) = QQbar。
#   F = QQ(√2): 主張の仮定は満たさないが、一歩の (二)〜(五) は根 w ∈ Lin_F(ω) が与えられれば
#   仮定を使わないので、Lin_F(ω) で分解する標本について、商の係数と根の所属を自明でない形で確かめる。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

I = QQbar(-1).sqrt()
s2 = QQbar(2).sqrt()
check(I * I == -1, "ω·ω = -1")
R.<t> = PolynomialRing(QQbar)

def in_AA_lin(z):
    return QQbar(z) in QQbar   # F = AA では Lin_F(ω) = QQbar

def in_QQsqrt2(x):
    x = QQbar(x)
    if x.imag() != 0:
        return False
    m = x.minpoly()
    if m.degree() == 1:
        return True
    if m.degree() != 2:
        return False
    p = -m[1] / 2
    q2 = QQbar((x - p)^2 / 2)
    if q2.minpoly().degree() != 1:
        return False
    if not QQ(q2).is_square():
        return False
    q = QQ(q2).sqrt()
    return x == p + q * s2 or x == p - q * s2
def in_sqrt2_lin(z):
    z = QQbar(z)
    return in_QQsqrt2(z.real()) and in_QQsqrt2(z.imag())

def ac(f, k):
    return f[k] if k <= f.degree() else QQbar(0)

def K_poly(w, n):
    # claim_qbar_poly_power_difference_factorization の K_n(w): K_0 = 0, K_{n+1} = K_n·ŵ + t^n
    k = R(0)
    for m in range(n):
        k = k * R(w) + t ** m
    return k

def factor_quotient(g, w, n):
    # claim_qbar_factor_theorem の商 q = Σ_{k=0}^{n} ac_k(g)^ · K_k(w)
    return sum((R(ac(g, k)) * K_poly(w, k) for k in range(n + 1)), R(0))

def decompose(g, d, in_lin, choose_root, tag):
    # 本文の帰納法をそのまま実行し、各行を確かめて α_{<d} を返す
    check(all(in_lin(ac(g, k)) for k in range(d + 4)), tag + ": 係数は Lin_F(ω)")
    check(all(ac(g, k) == 0 for k in range(d + 1, d + 4)), tag + ": k > d で係数が零")
    check(ac(g, d) == 1, tag + ": 番号 d の係数が 1")
    if d == 0:
        # 出発点: claim_qbar_monic_polynomial_linear_factor_product を d = 0 へ当てると g は空積 = 1
        check(g == R(1) == prod([], R(1)), tag + ": 出発点 g = 空積 = 1")
        check(in_lin(0), tag + ": 出発点 α(i) = 0 ∈ Lin_F(ω)")
        return []
    # (一) 根 w ∈ Lin_F(ω)（claim_imaginary_unit_extension_monic_polynomial_root）
    w = choose_root(g)
    check(in_lin(w) and g(w) == 0, tag + ": (一) 根 w ∈ Lin_F(ω)")
    # (二) 因数定理の商
    q = factor_quotient(g, w, d)
    check(g == (t - R(w)) * q, tag + ": (二) g = (t - ŵ)q")
    # (三) 商の係数の所属
    check(all(in_lin(ac(q, j)) for j in range(d + 4)), tag + ": (三) 商の係数は Lin_F(ω)")
    # (四) k > d で商の係数が零
    check(all(ac(q, k) == 0 for k in range(d, d + 4)), tag + ": (四) k ≥ d で商の係数が零")
    # (五) 先頭の係数の式鎖
    c1 = ac(q, d - 1)
    c2 = ac((t - R(w)) * q, d)
    c3 = ac(g, d)
    check(c1 == c2 == c3 == 1, tag + ": (五) ac_{d}(q) = ac_{d+1}((t-ŵ)q) = ac_{d+1}(g) = 1")
    alpha_prime = decompose(q, d - 1, in_lin, choose_root, tag)
    alpha = alpha_prime + [w]      # α(d-1) := w（本文の番号では一歩の d+1 の d）
    check(all(in_lin(a) for a in alpha), tag + ": α の値は全て Lin_F(ω)")
    # 結論の式鎖
    P_prime = prod([t - R(a) for a in alpha_prime], R(1))
    check(q == P_prime, tag + ": 帰納法の仮定 q = Π(t - α'(i)^)")
    l1 = (t - R(w)) * q
    l2 = (t - R(w)) * P_prime
    l3 = P_prime * (t - R(w))
    l4 = prod([t - R(a) for a in alpha], R(1))
    check(g == l1 == l2 == l3 == l4, tag + ": 結論の五行の式鎖")
    return alpha

# F = AA の標本: 根は QQbar の中で取る（主張の仮定のもとでの根の存在の代わり）
# 根は元の g の根を一度だけ取り、各段ではその中から現在の多項式の根を選ぶ（商の根は元の根に含まれる）
AA_root_pool = []
def root_AA(g):
    for r in AA_root_pool:
        if g(r) == 0:
            return r
    return None
samples_AA = [
    R(1),
    t - I,
    t^2 + (1 + I) * t + s2 * I,
    t^3 - 2 * I * t^2 + (3 - s2 * I) * t + 1 + I,
]
for n, g in enumerate(samples_AA):
    AA_root_pool[:] = g.roots(QQbar, multiplicities=False)
    for r in AA_root_pool:
        r.exactify()
    alpha = decompose(g, g.degree(), in_AA_lin, root_AA, "AA 標本 %d" % n)
    check(len(alpha) == g.degree(), "AA 標本 %d: 因子の個数は d" % n)

# F = QQ(√2) の標本: Lin_F(ω) の元を根に持つ積として作り、根は Lin_F(ω) の中から選ぶ
roots_lin = [1 + I, s2 - 2 * I, QQbar(1) / 3 + s2 * I, -s2, 2 * I]
for r in roots_lin:
    check(in_sqrt2_lin(r), "Q(√2) の根の候補は Lin_F(ω)")
check(not in_sqrt2_lin(QQbar(3).sqrt()), "√3 は Lin_F(ω) に入らない（所属判定が自明でない）")
def root_sqrt2(g):
    for r in roots_lin:
        if g(r) == 0:
            return r
    return None
samples_sqrt2 = [
    (t - roots_lin[0]),
    (t - roots_lin[0]) * (t - roots_lin[1]),
    (t - roots_lin[2]) * (t - roots_lin[3]) * (t - roots_lin[4]),
    (t - roots_lin[0])^2 * (t - roots_lin[4]) * (t - roots_lin[1]),
]
for n, g in enumerate(samples_sqrt2):
    alpha = decompose(g, g.degree(), in_sqrt2_lin, root_sqrt2, "Q(√2) 標本 %d" % n)
    check(len(alpha) == g.degree(), "Q(√2) 標本 %d: 因子の個数は d" % n)

print("PASS %d" % passes)
if failures:
    print("FAIL:", failures)
    raise SystemExit(1)
