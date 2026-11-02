# 対象ラベル: two_by_two_transfer_identity
# 証明の行:
#   (a) 準備の x_C - y_C = (x - y)_C の鎖 6 行（QQ の点で、本文の定義どおり C = R² の成分の演算で）。
#       初めの 3 行は def_complex_difference・multiply_by_minus_one・inclusion_rr_to_cc の定義を展開しただけなので、
#       同じ式になり独立には確かめない。実効があるのは積の像・和の像・実数の四則の 3 行である。
#   (b) 中間目標「部分和の成分」: (S_N)_ij の鎖 各 4 行（対角と非対角）を N = 0..24 で厳密に。
#   (c) 中間目標「部分和の成分の極限」: |(S_N)_ij - (cosh τ)_C| の鎖 6 行と |(S_N)_ij - (sinh τ)_C| の鎖 6 行のうち、
#       等号の行の中身（a_N - cosh τ = ((E_N(τ) - exp τ) + (E_N(-τ) - exp(-τ)))/2 など）を QQ(τ, X, Y)（X, Y は exp(±τ) の不定元）で、
#       不等号の行と u_N, v_N → 0、極限の行列 exp(τσ^x) = [[cosh τ, sinh τ], [sinh τ, cosh τ]] を τ ∈ QQ の点でボールで。
# 帰属: (a)(b) は厳密。(c) の極限は RealBallField(512) へ脱出する（理由: 極限）。exp(B_τ) は本文の部分和に尾の評価を
#   半径として足した行列のボール、cosh τ・sinh τ は本文の def_cosh_sinh を本文の exp のボールで組んだもの。
#   許容誤差は置かず、重なりと半径の小ささで判定する。
load("_prelude.sage")

# (a) x_C - y_C = (x - y)_C。本文の C は R² で、x_C = (x, 0)、積と和は definition_of_cc。
def c_mul(z, w): return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])
def c_add(z, w): return (z[0] + w[0], z[1] + w[1])
def c_inc(x): return (QQ(x), QQ(0))
for (x, y) in [(QQ(3), QQ(5)), (QQ(-7)/3, QQ(1)/2), (QQ(0), QQ(-4)), (QQ(11)/7, QQ(11)/7)]:
    neg_y = c_mul(c_inc(-1), c_inc(y))                                # multiply_by_minus_one: -y_C = (-1)_C y_C
    chain = [c_add(c_inc(x), neg_y),                                  # def_complex_difference: x_C + (-y_C)
             c_add(c_inc(x), c_mul(c_inc(-1), c_inc(y))),             # (-1_C) y_C、(-1)_C y_C（定義の展開）
             c_add(c_inc(x), c_inc((-1) * y)),                        # real_inclusion_preserves_product
             c_inc(x + (-1) * y),                                     # real_inclusion_preserves_finite_sum（2 項）
             c_inc(x - y)]
    for k in range(len(chain) - 1):
        assert chain[k] == chain[k + 1], (x, y, k)
print("x_C - y_C = (x - y)_C の鎖が 4 組の有理数で R² の成分の演算として一致する")

# (b) 部分和の成分
B = inc(tr) * SX
P = scalar_power_by_definition
for N in range(0, 25):
    S = matrix_partial_sum(B, N)
    for (i, j, sgn) in [(1, 1, 1), (2, 2, 1), (1, 2, -1), (2, 1, -1)]:
        terms = [(P(tr, m) + sgn * P(-tr, m)) / (2 * factorial(m)) for m in range(N + 1)]
        split = (sum(P(tr, m) / factorial(m) for m in range(N + 1)) + sgn * sum(P(-tr, m) / factorial(m) for m in range(N + 1))) / 2
        chain = [
            entry(S, i, j),
            sum(entry((QQ(1) / factorial(m)) * matrix_power_by_definition(B, m), i, j) for m in range(N + 1)),
            sum(inc(c) for c in terms),                                   # 各項の成分の中間目標
            inc(sum(terms)),                                              # real_inclusion_preserves_finite_sum（和を取ってから写す）
            inc(split),                                                   # 実数の有限和の分配則
            inc((E_partial(tr, N) + sgn * E_partial(-tr, N)) / 2),        # E_N の定義
        ]
        for k in range(len(chain) - 1):
            assert chain[k] == chain[k + 1], (N, i, j, k)
print("N = 0..24 で部分和の成分の鎖（対角・非対角 各 5 行）が厳密に一致する")

# (c) 等号の行の中身を QQ(τ)(X, Y) で（X = exp(τ)、Y = exp(-τ) の不定元。cosh・sinh は本文の定義）
F = FractionField(PolynomialRing(QQ, ['X', 'Y'])); X, Y = F.gens()
for N in range(0, 13):
    for t0 in [QQ(1)/3, QQ(-5)/2]:
        Ep = E_partial(t0, N); Em = E_partial(-t0, N)
        aN = (Ep + Em) / 2; bN = (Ep - Em) / 2
        coshv = cosh_by_definition(X, Y); sinhv = sinh_by_definition(X, Y)
        assert aN - coshv == ((Ep - X) + (Em - Y)) / 2
        assert bN - sinhv == ((Ep - X) - (Em - Y)) / 2
print("等号の行（a_N - cosh τ、b_N - sinh τ の書き換え）が exp(±τ) の不定元で一致する")

TAU_POINTS = [QQ(1)/1000, QQ(1)/3, QQ(1), QQ(5)/2, QQ(7), -QQ(3)/2]
for t0 in TAU_POINTS:
    eP = exp_ball(t0); eM = exp_ball(-t0)
    cb = cosh_by_definition(eP, eM); sb = sinh_by_definition(eP, eM)
    for N in [5, 20, 60, 120]:
        u = (RBF512(E_partial(t0, N)) - eP).abs(); v = (RBF512(E_partial(-t0, N)) - eM).abs()
        a = RBF512((E_partial(t0, N) + E_partial(-t0, N)) / 2); b = RBF512((E_partial(t0, N) - E_partial(-t0, N)) / 2)
        assert (a - cb).abs().lower() <= ((u + v) / 2).upper()        # 三角不等式の行
        assert (b - sb).abs().lower() <= ((u + v) / 2).upper()
    assert ((RBF512(E_partial(t0, 200)) - eP).abs()).upper() < 2^-300  # u_N → 0（大きな N で小さい）
    assert ((RBF512(E_partial(-t0, 200)) - eM).abs()).upper() < 2^-300 # v_N → 0
    Bc = matrix(RBF512, [[0, t0], [t0, 0]])
    Eb = exp_matrix_ball(Bc)                                          # exp(B_τ)
    for (i, j, val) in [(0, 0, cb), (1, 1, cb), (0, 1, sb), (1, 0, sb)]:
        assert Eb[i, j].overlaps(val) and Eb[i, j].rad() < 2^-400 and val.rad() < 2^-400, (t0, i, j)
    assert not Eb[0, 0].overlaps(sb) and not Eb[0, 1].overlaps(cb)    # 否定コントロール
print(f"{len(TAU_POINTS)} 点の τ ∈ QQ で、三角不等式の行と u_N, v_N → 0 が成り立ち、exp(τσ^x) の行列のボールが [[cosh τ, sinh τ], [sinh τ, cosh τ]] と重なる")
print("RESULT: PASS")
