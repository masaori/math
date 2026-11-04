# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 1 の左から掛ける形の鎖（X̌Q̌_ε から ǧ(ε)Q̌_ε までの 14 行）を、各行に書かれた式どおりに
# 本文の定義（mat_mult・def_matrix_scalar_multiple・def_matrix_sum・def_finite_sum_of_matrices・def_matrix_negation・
# def_matrix_difference・def_identity_matrix）で成分から組み、隣り合う項が等しいことを一行ずつ確かめる。
# ň_μ と γ_μ は _vprime_settings.sage の chain_settings から取る（既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と有理数 γ_μ、
# M = 2, 3, 4。check_with_check_psi.sage からは本文の ψ̌ の ň_μ と不定元 γ_μ）。Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň、R^{(0)} := I − ň）、
# ε を全列挙。鎖が使う仮定は check_joint_eigenspace_decomposition (3) の ň_μQ̌_ε = ε_μQ̌_ε だけである。
# 否定コントロール: 不定元の成分の行列 N_μ、Q と不定元 γ_μ、ε_μ では、(3) を引く行だけが等号を外れ、
# ほかの 13 行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ か、本文の ψ̌ の数体 F 上の多項式環か、QQ 上の多項式環（否定コントロール）（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_vprime_settings.sage")


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
        ("X Q", mul(X, Q), False),
        ("(Σ γ(n − ½I)) Q", mul(terms(lambda mu: sc(gam[mu], body_difference(n[mu], hI))), Q), False),
        ("Σ ((γ(n − ½I)) Q)", terms(lambda mu: mul(sc(gam[mu], body_difference(n[mu], hI)), Q)), False),
        ("Σ γ((n − ½I) Q)", terms(lambda mu: sc(gam[mu], mul(body_difference(n[mu], hI), Q))), False),
        ("Σ γ((n + (−(½I))) Q)", terms(lambda mu: sc(gam[mu], mul(body_sum(n[mu], body_negation(hI)), Q))), False),
        ("Σ γ(nQ + (−(½I))Q)", terms(lambda mu: sc(gam[mu], body_sum(mul(n[mu], Q), mul(body_negation(hI), Q)))), False),
        ("Σ γ(nQ + (−((½I)Q)))", terms(lambda mu: sc(gam[mu], body_sum(mul(n[mu], Q), body_negation(mul(hI, Q))))), False),
        ("Σ γ(nQ − (½I)Q)", terms(lambda mu: sc(gam[mu], body_difference(mul(n[mu], Q), mul(hI, Q)))), False),
        ("Σ γ(nQ − ½(IQ))", terms(lambda mu: sc(gam[mu], body_difference(mul(n[mu], Q), sc(half, mul(Id, Q))))), False),
        ("Σ γ(nQ − ½Q)", terms(lambda mu: sc(gam[mu], body_difference(mul(n[mu], Q), sc(half, Q)))), False),
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
for (tag, M, R, n, gammas) in chain_settings([2, 3, 4], symbolic_gamma=True):
    Id = body_identity(R, 2 ** M)
    for eps in cartesian_product([[0, 1]] * M):
        eps = [R(e) for e in eps]
        Q = joint_projector(n, eps, Id)
        assert all(n[mu] * Q == eps[mu] * Q for mu in range(M))   # 鎖の仮定 (3) が ň_μ の供給元で成り立つ
        lines = chain(n, Q, gammas, eps, Id)
        check(lines, (tag, eps), True)
        # 主張の左辺を Sage の演算（独立な経路）で組んだ X̌Q̌ と、右辺 ǧQ̌ と比べる
        Xs = sum(gammas[mu] * (n[mu] - Id / 2) for mu in range(M))
        gs = sum(gammas[mu] * (eps[mu] - R(1) / 2) for mu in range(M))
        assert Xs * Q == lines[0][1] == lines[-1][1] == gs * Q

# 否定コントロール: 不定元の成分の 2×2 行列 N_μ、Q と不定元 γ_μ、ε_μ（M = 2）
names = [f"n{mu}_{j}" for mu in range(2) for j in range(4)] + [f"q{j}" for j in range(4)] + ["g0", "g1", "e0", "e1"]
P = PolynomialRing(QQ, names)
G = P.gens()
Ng = [matrix(P, 2, 2, G[0:4]), matrix(P, 2, 2, G[4:8])]
Qg = matrix(P, 2, 2, G[8:12])
failed = check(chain(Ng, Qg, [G[12], G[13]], [G[14], G[15]], body_identity(P, 2)), "generic", False)
assert len(failed) == 1 and failed[0][2], failed   # (3) を引く行だけが外れる
print(f"checked {count} steps (settings M = 2, 3, 4 with all eps, and 13 steps of the generic control); the only failing step in the control is the one citing (3)")
print("RESULT: PASS")
