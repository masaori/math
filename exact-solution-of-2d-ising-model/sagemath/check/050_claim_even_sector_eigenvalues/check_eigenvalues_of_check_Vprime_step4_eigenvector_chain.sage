# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 4 の後半の鎖（5 行）
#   V̌'y = V̌'(Q̌_εy) = (V̌'Q̌_ε)y = ((exp ǧ)_ℂ Q̌_ε)y = (exp ǧ)_ℂ(Q̌_εy) = (exp ǧ)_ℂ y
# を、括弧どおりに一行ずつ厳密に確かめる（y = Q̌_εx）。
# 鎖が使う仮定は、前半の鎖の Q̌_εy = y と Step 3 の V̌'Q̌_ε = (exp ǧ(ε))_ℂ Q̌_ε だけである。
# 模型: check_25 と同じく Jordan–Wigner のフェルミ演算子 c_μ から n_μ := c_μ^T c_μ、
# Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := n、R^{(0)} := I − n）を作る。exp(γ_μ/2) を不定元 t_μ に置き、
# V̌' := Π_μ (t_μ^{-1}(I − n_μ) + t_μ n_μ)、(exp ǧ(ε))_ℂ := Π_μ t_μ^{2ε_μ − 1} とする
# （n_μ は互いに可換な冪等行列なので、これは exp(Σ_μ γ_μ(n_μ − 1/2)) の値と同じ形の式である。
# 指数関数の値そのものは ℝ への脱出なので、ここでは不定元の有理関数体 QQ(t) の中で鎖の形だけを確かめる）。
# M = 2, 3、ε を全列挙、x は有理数の列ベクトル 2 本。
# 否定コントロール: 不定元の成分の行列 V、Q と不定元 e、x では、仮定（Q̌_εy = y、Step 3）を使う行だけが
# 等号を外れ、mat_mult_associative・scalar_multiple_factors_out_of_left_factor を引く行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ(t_1, …, t_M) と QQ 上の多項式環（厳密計算）。


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


# 各行は (名前, 値, その行へ移る段が仮定（Q̌_εy = y・Step 3）を使うか)
def step4_second(V, Q, e, y):
    return [
        ("V y", V * y, False),
        ("V (Q y)", V * (Q * y), True),          # 上の等式 Q y = y を右辺から左辺へ
        ("(V Q) y", (V * Q) * y, False),         # mat_mult_associative（q → 1）を右辺から左辺へ
        ("(e Q) y", (e * Q) * y, True),          # Step 3 の極限の鎖
        ("e (Q y)", e * (Q * y), False),         # scalar_multiple_factors_out_of_left_factor（p → 1）
        ("e y", e * y, True),                    # 上の等式 Q y = y
    ]


def check_chain(lines, label, expect_all):
    global count
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, a, b)
            count += 1


count = 0
for M in range(2, 4):
    K = FractionField(PolynomialRing(QQ, ["t%d" % j for j in range(M)]))
    t = K.gens()
    sz = matrix(K, [[1, 0], [0, -1]])
    lower = matrix(K, [[0, 1], [0, 0]])
    id2 = identity_matrix(K, 2)
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    V = Id
    for mu in range(M):
        V = V * (t[mu] ** -1 * (Id - n[mu]) + t[mu] * n[mu])
    xs = [vector(K, [QQ(j * j - 3 * j + 1) / (j + 2) for j in range(2 ** M)]).column(),
          vector(K, [QQ((-1) ** j * (2 * j + 5)) / 3 for j in range(2 ** M)]).column()]
    for eps in cartesian_product([[0, 1]] * M):
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        e = prod(t[mu] ** (2 * eps[mu] - 1) for mu in range(M))
        assert V * Q == e * Q                                # 仮定 Step 3 が模型で成り立つ
        for x in xs:
            y = Q * x
            assert Q * y == y                                # 仮定（前半の鎖）が模型で成り立つ
            check_chain(step4_second(V, Q, e, y), ("step4 second", M, eps), True)

# 否定コントロール: 不定元の成分の 2×2 行列 V、Q と不定元 e、y
R = PolynomialRing(QQ, ["v%d" % j for j in range(4)] + ["q%d" % j for j in range(4)] + ["e", "y0", "y1"])
gens = R.gens()
Vg = matrix(R, 2, 2, gens[0:4])
Qg = matrix(R, 2, 2, gens[4:8])
eg = gens[8]
yg = matrix(R, 2, 1, gens[9:11])
lines = step4_second(Vg, Qg, eg, yg)
check_chain(lines, "generic", False)
neg_control = 0
for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
    if hyp:
        assert A != B, ("generic: 仮定を使う行が不定元でも成り立った", a, b)
        neg_control += 1

print("PASS: eigenvalues_of_check_Vprime Step 4 後半の鎖。厳密等号 %d 段、否定コントロール %d 行" % (count, neg_control))
