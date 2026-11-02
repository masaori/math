# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 2 の帰納法（k = 0 の 4 行、k + 1 の 8 行）、Step 3' の帰納法（k = 0 の 4 行、
# k + 1 の 7 行）、Step 4 の Q̌_ε y = y の鎖（y = Q̌_ε x とおいた 8 行）を、括弧どおりに一行ずつ厳密に確かめる。
#   行列の冪は def_exp (1) の A^0 := I、A^{m+1} := A^m A。数の冪は g^0 := 1、g^{k+1} := g^k g。
# 鎖が使う仮定は Step 1 の X̌Q̌ = gQ̌・Q̌X̌ = gQ̌、帰納法の仮定、check_joint_eigenspace_decomposition (1) の
# Q̌^2 = Q̌ だけなので、それを満たす模型として Jordan–Wigner のフェルミ演算子 c_μ から n_μ := c_μ^T c_μ を作り、
# Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := n、R^{(0)} := I − n）、X̌ := Σ_μ γ_μ (n_μ − (1/2)I)（γ_μ は有理数）、
# g := Σ_μ γ_μ(ε_μ − 1/2) を取る（M = 2, 3、ε を全列挙、k = 0, …, 4）。
# 否定コントロール: 不定元の成分の行列 X、Q と不定元 g、x では、Step 1・帰納法の仮定・冪等性を使う行だけが
# 等号を外れ、冪の定義・結合律・単位行列・スカラー倍を引く行は等号のまま残ることを確かめる。
# ℂ の積の交換律の行（(g g^k) Q = (g^k g) Q）は、可換な QQ と多項式環の上では構成上いつも一致するので、
# 写し間違いの検出には効かない（check_22 と同じ扱い）。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。

def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def mpow(A, k):
    # def_exp (1): A^0 := I、A^{m+1} := A^m A
    P = identity_matrix(A.base_ring(), A.nrows())
    for _ in range(k):
        P = P * A
    return P


def npow(g, k):
    # 証明の中の約束: g^0 := 1、g^{k+1} := g^k g
    p = g.parent()(1)
    for _ in range(k):
        p = p * g
    return p


# 各行は (名前, 値, その行へ移る段が仮定（Step 1・帰納法の仮定・冪等性）を使うか)
def step2_base(X, Q, g, Id):
    one = g.parent()(1)
    return [
        ("X^0 Q", mpow(X, 0) * Q, False),
        ("I Q", Id * Q, False),                 # def_exp (1) の A^0 := I
        ("Q", Q, False),                        # identity_matrix_is_left_unit_of_mat_mult
        ("1 Q", one * Q, False),                # scalar_multiple_by_one を右辺から左辺へ
        ("g^0 Q", npow(g, 0) * Q, False),       # g^0 := 1
    ]


def step2_succ(X, Q, g, k):
    return [
        ("X^{k+1} Q", mpow(X, k + 1) * Q, False),
        ("(X^k X) Q", (mpow(X, k) * X) * Q, False),          # def_exp (1) の A^{m+1} := A^m A
        ("X^k (X Q)", mpow(X, k) * (X * Q), False),          # mat_mult_associative
        ("X^k (g Q)", mpow(X, k) * (g * Q), True),           # Step 1
        ("g (X^k Q)", g * (mpow(X, k) * Q), False),          # scalar_multiple_factors_out_of_right_factor
        ("g (g^k Q)", g * (npow(g, k) * Q), True),           # 帰納法の仮定
        ("(g g^k) Q", (g * npow(g, k)) * Q, False),          # scalar_multiple_is_associative
        ("(g^k g) Q", (npow(g, k) * g) * Q, False),          # ℂ の積の交換律
        ("g^{k+1} Q", npow(g, k + 1) * Q, False),            # g^{k+1} := g^k g
    ]


def step3p_base(X, Q, g, Id):
    one = g.parent()(1)
    return [
        ("Q X^0", Q * mpow(X, 0), False),
        ("Q I", Q * Id, False),                 # def_exp (1) の A^0 := I
        ("Q", Q, False),                        # identity_matrix_is_right_unit_of_mat_mult
        ("1 Q", one * Q, False),                # scalar_multiple_by_one を右辺から左辺へ
        ("g^0 Q", npow(g, 0) * Q, False),       # g^0 := 1
    ]


def step3p_succ(X, Q, g, k):
    return [
        ("Q X^{k+1}", Q * mpow(X, k + 1), False),
        ("Q (X^k X)", Q * (mpow(X, k) * X), False),          # def_exp (1) の A^{m+1} := A^m A
        ("(Q X^k) X", (Q * mpow(X, k)) * X, False),          # mat_mult_associative を右辺から左辺へ
        ("(g^k Q) X", (npow(g, k) * Q) * X, True),           # 帰納法の仮定
        ("g^k (Q X)", npow(g, k) * (Q * X), False),          # scalar_multiple_factors_out_of_left_factor
        ("g^k (g Q)", npow(g, k) * (g * Q), True),           # Step 1 の右から掛ける形
        ("(g^k g) Q", (npow(g, k) * g) * Q, False),          # scalar_multiple_is_associative
        ("g^{k+1} Q", npow(g, k + 1) * Q, False),            # g^{k+1} := g^k g
    ]


def step4(Q, x, Id):
    y = Q * x
    return [
        ("Q y", Q * y, False),
        ("Q (Q x)", Q * (Q * x), False),                     # y = Q x と書いた
        ("(Q Q) x", (Q * Q) * x, False),                     # mat_mult_associative（q → 1）を右辺から左辺へ
        ("((I Q) Q) x", ((Id * Q) * Q) * x, False),          # identity_matrix_is_left_unit_of_mat_mult を右辺から左辺へ
        ("((Q^0 Q) Q) x", ((mpow(Q, 0) * Q) * Q) * x, False),  # def_exp (1) の A^0 := I
        ("(Q^1 Q) x", (mpow(Q, 1) * Q) * x, False),          # def_exp (1) の A^{m+1} := A^m A（m = 0）
        ("Q^2 x", mpow(Q, 2) * x, False),                    # def_exp (1) の A^{m+1} := A^m A（m = 1）
        ("Q x", Q * x, True),                                # check_joint_eigenspace_decomposition (1)
        ("y", y, False),                                     # y = Q x と書いた
    ]


def check_chain(lines, label, expect_all):
    global count
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, a, b)
            count += 1


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
gammas = [QQ(3) / 2, QQ(5) / 7, QQ(2), QQ(11) / 3]
for M in range(2, 4):
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    X = sum(gammas[mu] * (n[mu] - QQ(1) / 2 * Id) for mu in range(M))
    x = vector(QQ, [QQ(j * j - 3 * j + 1) / (j + 2) for j in range(2 ** M)]).column()
    for eps in cartesian_product([[0, 1]] * M):
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        g = sum(gammas[mu] * (eps[mu] - QQ(1) / 2) for mu in range(M))
        assert X * Q == g * Q and Q * X == g * Q and Q * Q == Q   # 鎖の仮定（Step 1・冪等性）が模型で成り立つ
        check_chain(step2_base(X, Q, g, Id), ("step2 base", M, eps), True)
        check_chain(step3p_base(X, Q, g, Id), ("step3' base", M, eps), True)
        for k in range(5):
            assert mpow(X, k) * Q == npow(g, k) * Q and Q * mpow(X, k) == npow(g, k) * Q  # 帰納法の仮定
            check_chain(step2_succ(X, Q, g, k), ("step2", M, eps, k), True)
            check_chain(step3p_succ(X, Q, g, k), ("step3'", M, eps, k), True)
        check_chain(step4(Q, x, Id), ("step4", M, eps), True)

# 否定コントロール: 不定元の成分の 2×2 行列 X、Q と不定元 g、x
R = PolynomialRing(QQ, ["x%d" % j for j in range(4)] + ["q%d" % j for j in range(4)] + ["g", "v0", "v1"])
gens = R.gens()
Xg = matrix(R, 2, 2, gens[0:4])
Qg = matrix(R, 2, 2, gens[4:8])
gg = gens[8]
xg = matrix(R, 2, 1, gens[9:11])
IdR = identity_matrix(R, 2)
neg_control = 0
generic = [step2_base(Xg, Qg, gg, IdR), step3p_base(Xg, Qg, gg, IdR), step4(Qg, xg, IdR)]
for k in range(1, 3):   # k = 0 では X^0 Q = g^0 Q = Q なので帰納法の仮定の行も不定元で成り立つ。k ≥ 1 で比べる
    generic += [step2_succ(Xg, Qg, gg, k), step3p_succ(Xg, Qg, gg, k)]
for lines in generic:
    check_chain(lines, ("generic", lines[0][0]), False)
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", a, b)
            neg_control += 1

print("PASS eigenvalues_of_check_Vprime Step 2・Step 3' の帰納法と Step 4 の鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
