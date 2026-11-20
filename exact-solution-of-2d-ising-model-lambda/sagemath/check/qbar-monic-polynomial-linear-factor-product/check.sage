# 主張「番号 d の係数が 1 でそれより上の係数が零の多項式は、代数的数を根とする d 個の一次因子の積である」
# の帰納法の式鎖を一行ずつ確かめる。
# 対象ラベル: claim_qbar_monic_polynomial_linear_factor_product
# 帰属: 係数は数体（円分体 Q(ζ_8)、x^3 - 2 の Q 上の分解体）の元。どちらも代数的数の部分体。
# 根は各数体の中で多項式の根として取る（本文の代数閉性による根の存在の代わり）。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def K_poly(T, w, n):
    # claim_qbar_poly_power_difference_factorization の K_n(w): K_0 = 0, K_{n+1} = K_n·ŵ + t^n
    t = T.gen()
    k = T(0)
    for m in range(n):
        k = k * T(w) + t ** m
    return k

def ac(f, k):
    return f[k] if k <= f.degree() else f.base_ring()(0)

def factor_quotient(T, f, w, n):
    # claim_qbar_factor_theorem の商 g = Σ_{k=0}^{n} ac_k(f)^ · K_k(w)
    return sum((T(ac(f, k)) * K_poly(T, w, k) for k in range(n + 1)), T(0))

def decompose(T, f, d, tag):
    # 本文の帰納法をそのまま実行し、各行を確かめて α_{<d} を返す
    t = T.gen()
    # 仮定: k > d で ac_k(f) = 0、ac_d(f) = 1
    check(all(ac(f, k) == 0 for k in range(d + 1, d + 4)), tag + ": 上界の仮定")
    check(ac(f, d) == 1, tag + ": 番号 d の係数が 1")
    if d == 0:
        # 出発点の式鎖
        line1 = sum((T(ac(f, k)) * t ** k for k in range(1)), T(0))
        line2 = T(ac(f, 0)) * t ** 0
        line3 = T(1) * T(1)
        check(f == line1, tag + ": 出発点 第一の等号（単項式分解）")
        check(line1 == line2, tag + ": 出発点 第二の等号（一項の和）")
        check(line2 == line3, tag + ": 出発点 第三の等号")
        check(line3 == T(1), tag + ": 出発点 第四の等号")
        check(T(1) == prod([], T(1)), tag + ": 出発点 空積")
        return []
    dm = d - 1
    roots = f.roots(multiplicities=False)
    check(len(roots) >= 1, tag + ": 根の存在")
    w = roots[0]
    check(f(w) == 0, tag + ": aev_w(f) = 0")
    g = factor_quotient(T, f, w, d)
    check(f == (t - T(w)) * g, tag + ": 因数定理 f = (t - ŵ)g")
    check(all(ac(g, k) == 0 for k in range(d, d + 4)), tag + ": 商の係数は番号 d 以上で零")
    # 先頭の係数の式鎖
    c1 = ac(g, dm)
    c2 = ac((t - T(w)) * g, dm + 1)
    c3 = ac(f, dm + 1)
    check(c1 == c2, tag + ": 先頭 第一の等号（一次因子との積の先頭の係数）")
    check(c2 == c3, tag + ": 先頭 第二の等号")
    check(c3 == 1, tag + ": 先頭 第三の等号")
    alpha_p = decompose(T, g, dm, tag + "/商")
    alpha = alpha_p[:dm] + [w]
    P_prime = prod([t - T(a) for a in alpha_p], T(1))
    check(g == P_prime, tag + ": α' の取り方")
    e1 = (t - T(w)) * g
    e2 = (t - T(w)) * P_prime
    e3 = P_prime * (t - T(w))
    e4 = prod([t - T(alpha[i]) for i in range(dm)], T(1)) * (t - T(alpha[dm]))
    e5 = prod([t - T(alpha[i]) for i in range(d)], T(1))
    check(f == e1, tag + ": 一歩 第一の等号")
    check(e1 == e2, tag + ": 一歩 第二の等号")
    check(e2 == e3, tag + ": 一歩 第三の等号（積の可換則）")
    check(e3 == e4, tag + ": 一歩 第四の等号（α の定め方）")
    check(e4 == e5, tag + ": 一歩 第五の等号（有限積の約束）")
    return alpha

samples = []
K8.<z> = CyclotomicField(8)
T8.<t> = PolynomialRing(K8)
s2 = z + z^-1
samples.append(("Q(ζ8): 1", T8, T8(1), 0))
samples.append(("Q(ζ8): t^4 + 1", T8, t^4 + 1, 4))
samples.append(("Q(ζ8): (t^2 - 2)(t - 1/3)", T8, (t^2 - 2) * (t - 1/3), 3))
samples.append(("Q(ζ8): (t - 1)^3 (t + i)", T8, (t - 1)^3 * (t + z^2), 4))
samples.append(("Q(ζ8): t^2 - √2 t + 1", T8, t^2 - s2 * t + 1, 2))
samples.append(("Q(ζ8): t - ζ8", T8, t - z, 1))
xq = polygen(QQ, 'xq')
L = NumberField(xq^3 - 2, 'b').galois_closure('a')
TL.<u> = PolynomialRing(L)
samples.append(("分解体: u^3 - 2", TL, u^3 - 2, 3))
samples.append(("分解体: (u^3 - 2)(u^2 + u + 1)", TL, (u^3 - 2) * (u^2 + u + 1), 5))
samples.append(("分解体: (u^3 - 2)^2", TL, (u^3 - 2)^2, 6))

for tag, T, f, d in samples:
    alpha = decompose(T, f, d, tag)
    check(len(alpha) == d, tag + ": 根の個数")
    check(f == prod([T.gen() - T(a) for a in alpha], T(1)), tag + ": 結論の等式")

# 対照: 番号 d の係数が 1 でない多項式では、d 個の一次因子の積に等しくならない
f_bad = 2 * t^2 + 1
roots_bad = [r for r, m in f_bad.roots() for _ in range(m)]
check(f_bad != prod([t - T8(r) for r in roots_bad], T8(1)), "対照: 先頭の係数が 2 なら一次因子の積と一致しない")

if failures:
    print("FAIL", len(failures))
    for m in failures:
        print("  ", m)
else:
    print("PASS", passes)
