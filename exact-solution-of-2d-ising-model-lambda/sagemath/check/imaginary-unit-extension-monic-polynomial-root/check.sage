# 主張「虚数単位を足した体を係数とする、最高次の係数が一の多項式は、その体に根を持つ」を一行ずつ確かめる。
# 対象ラベル: claim_imaginary_unit_extension_monic_polynomial_root
# 帰属: 標本は QQbar の厳密な元。浮動小数点は使わない。
# 標本の部分体: F = AA（実代数的数）。正の元は平方、奇数次の多項式は根を持つので仮定を満たす。
# ω = i、Lin_F(ω) = QQbar、cj_ω は a + b i ↦ a - b i（a, b ∈ AA）。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

I = QQbar(-1).sqrt()
check(I * I == -1, "ω·ω = -1")
def cj(z):
    z = QQbar(z)
    return QQbar(z.real()) - QQbar(z.imag()) * I
def in_F(x):
    return QQbar(x).imag() == 0

R.<t> = PolynomialRing(QQbar)
def cjp(g):
    return R([cj(c) for c in g.list()])

# (一)
check(cj(0) == 0 and cj(0 + 0 * I) == 0 - 0 * I, "(一) cj(0) = 0")
check(cj(1) == 1 and cj(1 + 0 * I) == 1 - 0 * I, "(一) cj(1) = 1")

s2 = QQbar(2).sqrt()
samples = [
    t - I,                                   # 根は i のみ
    t^2 + (1 + I) * t + s2 * I,
    t^3 - 2 * I * t^2 + (3 - s2 * I) * t + 1 + I,
    t^2 + 1,                                 # 係数が F に入る場合
    t^4 + I * t + (2 - 3 * I),
]
both_cases = set()
for g in samples:
    d = g.degree()
    check(g[d] == 1, "g の番号 d の係数は 1")
    gc = cjp(g)
    # (二)
    for k in range(d + 1, d + 4):
        check(gc[k] == cj(g[k]) == 0, "(二) k > d での係数")
    check(gc[d] == cj(g[d]) == cj(1) == 1, "(二) 番号 d の係数")
    # (三)
    h = g * gc
    check(all(in_F(c) for c in h.list()), "(三) h ∈ F[t]")
    # (四)
    for k in range(2 * d + 1, 2 * d + 4):
        check(h[k] == 0, "(四) k > d + d での係数")
    check(h[2 * d] == g[d] * gc[d] == 1 * 1 == 1, "(四) 番号 d + d の係数の式鎖")
    # 主張: h の全ての根 z について、場合分けの二通りを確かめる
    for (z, _) in h.roots(QQbar):
        check(h(z) == 0, "z は h の根")
        check(g(z) * gc(z) == h(z) == 0, "三行の式鎖")
        if g(z) == 0:
            both_cases.add("z")
            check(g(z) == 0, "aev_z(g) = 0 の場合")
        else:
            both_cases.add("cj(z)")
            check(gc(z) == 0, "零因子が無いので aev_z(cjp(g)) = 0")
            w = cj(z)
            check(g(w) == cj(gc(z)) == cj(0) == 0, "aev_{cj(z)}(g) の四行の式鎖")
check(both_cases == {"z", "cj(z)"}, "二つの場合の両方が標本に現れる")

# d ≥ 1 の仮定が要ることの確認: d = 0 で番号 0 の係数が 1 の多項式（単位元）には根が無い。
check(R(1).roots(QQbar) == [], "d = 0 の単位元には根が無い")

print("PASS %d" % passes)
if failures:
    print("FAIL:", failures)
    raise SystemExit(1)
