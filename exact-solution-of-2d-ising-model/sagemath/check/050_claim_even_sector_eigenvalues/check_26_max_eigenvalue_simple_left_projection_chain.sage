# 対象ラベル: max_eigenvalue_of_V_plus_simple
# max_eigenvalue_of_V_plus_simple (3) の、固有方程式 V^{(+)}x = Λ̌_max x に左から Q̌_{ε'} を掛ける鎖（5 行）
#   Λ̌_{ε'}(Q̌_{ε'}x) = (Λ̌_{ε'}Q̌_{ε'})x = (Q̌_{ε'}V^{(+)})x = Q̌_{ε'}(V^{(+)}x) = Q̌_{ε'}(Λ̌_max x) = Λ̌_max(Q̌_{ε'}x)
# を、括弧どおりに一行ずつ厳密に確かめる。数ベクトル x は 2^M 行 1 列の行列として置く（mat_mult の約束）。
# 鎖が使う仮定は eigenvalues_of_V_plus (1) の Q̌_ε V^{(+)} = Λ̌_ε Q̌_ε と V^{(+)}x = Λ̌_max x だけなので、それを満たす模型として
# Jordan–Wigner のフェルミ演算子 c_μ から n_μ := c_μ^T c_μ、Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := n、R^{(0)} := I − n）、
# 有理数 Λ_ε を取って V := Σ_ε Λ_ε Q̌_ε、x := Q̌_{(1,…,1)} y（y は有理数の列）とする（M = 2, 3, 4、ε' を全列挙）。
# 否定コントロール: 不定元の成分の行列 Q、V と不定元 λ, λ_max, x では、(1) と固有方程式を使う 2 行だけが等号を外れ、
# スカラー倍の外出しと結合律を引く 3 行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。

def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


# 各行は (名前, 値, その行へ移る段が仮定（(1)・固有方程式）を使うか)
def chain(Q, V, lam, lam_max, x):
    return [
        ("λ'(Q x)", lam * (Q * x), False),
        ("(λ' Q) x", (lam * Q) * x, False),          # scalar_multiple_factors_out_of_left_factor を右辺から左辺へ
        ("(Q V) x", (Q * V) * x, True),               # eigenvalues_of_V_plus (1) を右辺から左辺へ
        ("Q (V x)", Q * (V * x), False),              # mat_mult_associative（q → 1）
        ("Q (λmax x)", Q * (lam_max * x), True),      # V x = λmax x
        ("λmax (Q x)", lam_max * (Q * x), False),     # scalar_multiple_factors_out_of_right_factor
    ]


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    epss = list(cartesian_product([[0, 1]] * M))
    Qs = {}
    for eps in epss:
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        Qs[tuple(eps)] = Q
    lams = {e: QQ(3 + sum((mu + 2) * e[mu] for mu in range(M))) / 7 for e in Qs}
    V = sum(lams[e] * Qs[e] for e in Qs)
    top = tuple([1] * M)
    y = vector(QQ, [QQ(j * j - 2 * j + 5) / (j + 3) for j in range(2 ** M)]).column()
    x = Qs[top] * y
    assert V * x == lams[top] * x                       # 固有方程式（仮定）が模型で成り立つ
    for e in Qs:
        assert Qs[e] * V == lams[e] * Qs[e]             # (1)（仮定）が模型で成り立つ
        lines = chain(Qs[e], V, lams[e], lams[top], x)
        for (a, A, _), (b, B, _) in zip(lines, lines[1:]):
            assert A == B, (M, e, a, b)
            count += 1

# 否定コントロール
R = PolynomialRing(QQ, ["q%d" % j for j in range(4)] + ["v%d" % j for j in range(4)] + ["lam", "lmax", "x0", "x1"])
gens = R.gens()
Qg = matrix(R, 2, 2, gens[0:4])
Vg = matrix(R, 2, 2, gens[4:8])
lines = chain(Qg, Vg, gens[8], gens[9], matrix(R, 2, 1, gens[10:12]))
neg_control = 0
for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
    if hyp:
        assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", a, b)
        neg_control += 1
    else:
        assert A == B, ("generic", a, b)
        count += 1

print("PASS max_eigenvalue_of_V_plus_simple (3) の左から Q̌_{ε'} を掛ける鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
