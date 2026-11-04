# 対象ラベル: trace_of_check_Vprime（Step 2 の展開の行に続く 6 行）
#   Π_μ (exp(γ_μ(1 − 1/2)) + exp(γ_μ(0 − 1/2)))
#   = Π_μ (exp(γ_μ·1/2) + exp(γ_μ(0 − 1/2)))        (ℝ で 1 − 1/2 = 1/2)
#   = Π_μ (exp(γ_μ·1/2) + exp(γ_μ(−1/2)))           (ℝ で 0 − a = −a、a → 1/2)
#   = Π_μ (exp(γ_μ·1/2) + exp(−(γ_μ·1/2)))          (ℝ で a(−b) = −(ab)、a → γ_μ、b → 1/2)
#   = Π_μ (exp(γ_μ/2) + exp(−(γ_μ/2)))              (ℝ で a·1/2 = a/2、a → γ_μ、各因子の 2 箇所)
#   = Π_μ 2·((exp(γ_μ/2) + exp(−(γ_μ/2)))/2)        (ℝ で 2 ≠ 0 なので b = 2·(b/2))
#   = Π_μ 2cosh(γ_μ/2)                              (def_cosh_sinh の cosh、x → γ_μ/2、右辺から左辺へ)
# γ_μ := γ(θ~_μ)。
# 厳密な部: 書き換えの 5 行（cosh の行を除く）は因子の中の一つの計算規則なので、書き換えた部分式どうしを厳密に比べる
#   （a·1/2 = a/2 の行は 2 箇所を別々に数えて 6 段）。cosh の行は球の部だけで確かめる。
#   指数の引数の 4 行は γ を QQ 上の多項式環 QQ[γ] の不定元に置いて恒等式として、b = 2·(b/2) は
#   b を QQ 上の有理関数体の不定元に置いて確かめる（γ・b が ℝ の元であることは使わず、体の計算だけで閉じる）。
# 球の部: γ(θ~_μ)・exp・cosh の値は ℝ への脱出（arccosh・exp・cos・cosh の値）なので、区間演算 RealBallField(200) の球で扱い、
#   7 つの行の積を M_col = 2..6、K の 4 組で組んで、隣どうしの行の球が交わること（半径 1e-40 未満）を確かめる。
#   有限積は def_finite_product_of_real_numbers どおり左から畳み込む。最後の行の cosh は Sage の cosh で計算し、
#   def_cosh_sinh の式で組んだ前の行と独立に比べる（実質の比較はこの行）。
# 否定コントロール: 旧い行の書き方で起こりやすい誤り（0 − 1/2 を +1/2 にする、cosh の引数を γ にする、2 を落とす）が、
#   厳密な部では恒等式でなく、球の部では 2 行目の積と交わらないことを確かめる（2 行目から最後の行までは互いに等しい）。

RB = RealBallField(200)
pi_b = RB.pi()


def K_star_b(K):
    # 双対結合定数 K* := -(1/2) log(tanh K)（_shared/spin_ops.sage の K_star と同じ式）
    return -(RB(K).tanh().log()) / 2


def gamma_tilde_b(M, mu, K1, K2):
    # γ(θ~_μ) := arccosh(γ_1(θ~_μ))、γ_1(θ) = c_1c_2^* − s_1s_2^* cos θ、θ~_μ = 2π(μ − 1/2)/M
    K2s = K_star_b(K2)
    c1, s1 = (2 * RB(K1)).cosh(), (2 * RB(K1)).sinh()
    c2s, s2s = (2 * K2s).cosh(), (2 * K2s).sinh()
    th = 2 * pi_b * (RB(mu) - RB(1) / 2) / M
    g1 = c1 * c2s - s1 * s2s * th.cos()
    assert g1 >= 1, ("gamma_1 < 1", M, mu, K1, K2)
    return g1.arccosh()


def finite_prod(ys):
    p = ys[0]
    for y in ys[1:]:
        p = p * y
    return p


def same(a, b):
    assert a.rad() < 1e-40 and b.rad() < 1e-40
    return a.overlaps(b)


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]

# 厳密な部
P = PolynomialRing(QQ, 'gam')
gam = P.gen()
h = QQ(1) / 2
exact_steps = [
    (gam * (1 - h), gam * h),          # 1 − 1/2 = 1/2
    (gam * (0 - h), gam * (-h)),       # 0 − a = −a
    (gam * (-h), -(gam * h)),          # a(−b) = −(ab)
    (gam * h, gam / 2),                # a·1/2 = a/2（1 つ目の箇所）
    (-(gam * h), -(gam / 2)),          # a·1/2 = a/2（2 つ目の箇所）
]
for a, b in exact_steps:
    assert a == b
Fb = FractionField(PolynomialRing(QQ, 'b'))
bb = Fb.gen()
assert bb == 2 * (bb / 2)              # b = 2·(b/2)
exact = len(exact_steps) + 1
exact_broken = 0
for a, b in [(gam * (0 - h), gam * h), (gam * h, gam), (bb, bb / 2)]:
    if a != b:
        exact_broken += 1
assert exact_broken == 3

# 球の部
count = 0
broken = 0
half = RB(1) / 2
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        g = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        lines = [
            finite_prod([(g[m] * (RB(1) - half)).exp() + (g[m] * (RB(0) - half)).exp() for m in range(M)]),
            finite_prod([(g[m] * half).exp() + (g[m] * (RB(0) - half)).exp() for m in range(M)]),
            finite_prod([(g[m] * half).exp() + (g[m] * (-half)).exp() for m in range(M)]),
            finite_prod([(g[m] * half).exp() + (-(g[m] * half)).exp() for m in range(M)]),
            finite_prod([(g[m] / 2).exp() + (-(g[m] / 2)).exp() for m in range(M)]),
            finite_prod([2 * (((g[m] / 2).exp() + (-(g[m] / 2)).exp()) / 2) for m in range(M)]),
            finite_prod([2 * (g[m] / 2).cosh() for m in range(M)]),
        ]
        for a, b in zip(lines, lines[1:]):
            assert same(a, b), (M, K1, K2)
            count += 1
        bad = [
            finite_prod([(g[m] * half).exp() + (g[m] * half).exp() for m in range(M)]),
            finite_prod([2 * g[m].cosh() for m in range(M)]),
            finite_prod([(g[m] / 2).cosh() for m in range(M)]),
        ]
        for x in bad:
            if not same(x, lines[1]):
                broken += 1
assert broken == 3 * 5 * len(PARAMS)
print(f"checked {exact} rewriting steps exactly (QQ[γ] and QQ(b))")
print(f"exact negative controls detected: {exact_broken}")
print(f"checked {count} lines with balls (M_col = 2..6, {len(PARAMS)} coupling pairs)")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
