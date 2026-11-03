# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 1 の右から掛ける形の鎖（Q̌_εX̌ から ǧ(ε)Q̌_ε までの 14 行）を、各行に書かれた式どおりに
# 本文の定義（mat_mult・def_matrix_scalar_multiple・def_matrix_sum・def_finite_sum_of_matrices・def_matrix_negation・
# def_matrix_difference・def_identity_matrix）で成分から組み、隣り合う項が等しいことを一行ずつ確かめる。
# 模型: Jordan–Wigner のフェルミ演算子 c_μ から n_μ := c_μ^T c_μ、Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := n、R^{(0)} := I − n）、
# 有理数 γ_μ（M = 2, 3, 4、ε を全列挙）。鎖が使う仮定は check_joint_eigenspace_decomposition (3) の Q̌_εň_μ = ε_μQ̌_ε だけである。
# 否定コントロール: 不定元の成分の行列 N_μ、Q と不定元 γ_μ、ε_μ では、(3) を引く行だけが等号を外れ、
# ほかの 13 行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def chain(n, Q, gam, eps, Id):
    """鎖の 15 の項（名前, 値, その項へ移る段が (3) を引くか）。"""
    R = Q.base_ring()
    M = len(n)
    half = R(1) / 2
    hI = body_scalar(half, Id)                                   # (1/2)I
    sc = body_scalar
    mul = body_product
    fs = body_finite_sum
    terms = lambda f: fs([f(mu) for mu in range(M)])
    X = terms(lambda mu: sc(gam[mu], body_difference(n[mu], hI)))
    g = sum(gam[mu] * (eps[mu] + body_neg_scalar(half)) for mu in range(M))   # ǧ の定義（Σ は左から足す）
    return [
        ("Q X", mul(Q, X), False),
        ("Q (Σ γ(n − ½I))", mul(Q, terms(lambda mu: sc(gam[mu], body_difference(n[mu], hI)))), False),
        ("Σ (Q (γ(n − ½I)))", terms(lambda mu: mul(Q, sc(gam[mu], body_difference(n[mu], hI)))), False),
        ("Σ γ(Q (n − ½I))", terms(lambda mu: sc(gam[mu], mul(Q, body_difference(n[mu], hI)))), False),
        ("Σ γ(Q (n + (−(½I))))", terms(lambda mu: sc(gam[mu], mul(Q, body_sum(n[mu], body_negation(hI))))), False),
        ("Σ γ(Qn + Q(−(½I)))", terms(lambda mu: sc(gam[mu], body_sum(mul(Q, n[mu]), mul(Q, body_negation(hI))))), False),
        ("Σ γ(Qn + (−(Q(½I))))", terms(lambda mu: sc(gam[mu], body_sum(mul(Q, n[mu]), body_negation(mul(Q, hI))))), False),
        ("Σ γ(Qn − Q(½I))", terms(lambda mu: sc(gam[mu], body_difference(mul(Q, n[mu]), mul(Q, hI)))), False),
        ("Σ γ(Qn − ½(QI))", terms(lambda mu: sc(gam[mu], body_difference(mul(Q, n[mu]), sc(half, mul(Q, Id))))), False),
        ("Σ γ(Qn − ½Q)", terms(lambda mu: sc(gam[mu], body_difference(mul(Q, n[mu]), sc(half, Q)))), False),
        ("Σ γ(εQ − ½Q)", terms(lambda mu: sc(gam[mu], body_difference(sc(eps[mu], Q), sc(half, Q)))), True),
        ("Σ γ((ε − ½)Q)", terms(lambda mu: sc(gam[mu], sc(eps[mu] + body_neg_scalar(half), Q))), False),
        ("Σ (γ(ε − ½))Q", terms(lambda mu: sc(gam[mu] * (eps[mu] + body_neg_scalar(half)), Q)), False),
        ("(Σ γ(ε − ½))Q", sc(sum(gam[mu] * (eps[mu] + body_neg_scalar(half)) for mu in range(M)), Q), False),
        ("ǧ Q", sc(g, Q), False),
    ]


def check(lines, label, expect_all):
    global count
    failed = []
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if A == B:
            count += 1
        else:
            failed.append((a, b, hyp))
    if expect_all:
        assert not failed, (label, failed)
    return failed


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
gammas = [QQ(3) / 2, QQ(5) / 7, QQ(2), QQ(11) / 3]
for M in range(2, 5):
    Id = body_identity(QQ, 2 ** M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    for eps in cartesian_product([[0, 1]] * M):
        eps = [QQ(e) for e in eps]
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        assert all(Q * n[mu] == eps[mu] * Q for mu in range(M))   # 鎖の仮定 (3) が模型で成り立つ
        lines = chain(n, Q, gammas[:M], eps, Id)
        check(lines, ("model", M, eps), True)
        # 主張の左辺を Sage の演算（独立な経路）で組んだ Q̌X̌ と、右辺 ǧQ̌ と比べる
        Xs = sum(gammas[mu] * (n[mu] - Id / 2) for mu in range(M))
        gs = sum(gammas[mu] * (eps[mu] - QQ(1) / 2) for mu in range(M))
        assert Q * Xs == lines[0][1] == lines[-1][1] == gs * Q

# 否定コントロール: 不定元の成分の 2×2 行列 N_μ、Q と不定元 γ_μ、ε_μ（M = 2）
names = [f"n{mu}_{j}" for mu in range(2) for j in range(4)] + [f"q{j}" for j in range(4)] + ["g0", "g1", "e0", "e1"]
P = PolynomialRing(QQ, names)
G = P.gens()
Ng = [matrix(P, 2, 2, G[0:4]), matrix(P, 2, 2, G[4:8])]
Qg = matrix(P, 2, 2, G[8:12])
failed = check(chain(Ng, Qg, [G[12], G[13]], [G[14], G[15]], body_identity(P, 2)), "generic", False)
assert len(failed) == 1 and failed[0][2], failed   # (3) を引く行だけが外れる
print(f"checked {count} steps (model M = 2, 3, 4 with all eps, and 13 steps of the generic control); the only failing step in the control is the one citing (3)")
print("RESULT: PASS")
