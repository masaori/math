# 対象ラベル: eigenvalues_of_check_Vprime の Step 1 の鎖の項を組む関数（check_step1_left_chain.sage・check_step1_right_chain.sage が読み込む）。
# 鎖の各行の式を本文の定義（mat_mult・def_matrix_scalar_multiple・def_matrix_sum・def_finite_sum_of_matrices・def_matrix_negation・
# def_matrix_difference・def_identity_matrix）で成分から組む。side が "left" なら (ň_μ − ½I)Q̌_ε と X̌Q̌_ε、"right" なら Q̌_ε(ň_μ − ½I) と Q̌_εX̌。
# h は def_half_sign_of_binary_value の h(1) := ½、h(0) := −(½)。ε(μ) は 0 か 1 で、算術には使わず h を通すか場合で分ける。
# 項は (名前, 値, その項へ移る段が仮定を引くか)。仮定は check_joint_eigenspace_decomposition (3)（ε(ν) = 1 なら ň_νQ̌_ε = Q̌_εň_ν = Q̌_ε、
# ε(ν) = 0 なら = O）で、μ ごとの等式の 2 行目と、主鎖の「μ ごとの等式を各項へ」の行がそれを引く。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def h_of(e, R):
    half = R(1) / 2
    return half if e == 1 else body_neg_scalar(half)                   # def_half_sign_of_binary_value


def per_mu_chains(side, n_mu, Q, e, Id):
    """μ ごとの等式の鎖: ε(μ) によらない 6 行と、場合 e = ε(μ) の 7 行。"""
    R = Q.base_ring()
    half = R(1) / 2
    hI = body_scalar(half, Id)
    sc, mul = body_scalar, body_product
    if side == "left":
        m = lambda A: mul(A, Q)                                          # A ↦ AQ
        common = [
            ("(n − ½I)Q", m(body_difference(n_mu, hI)), False),
            ("(n + (−(½I)))Q", m(body_sum(n_mu, body_negation(hI))), False),            # matrix_difference_is_sum_with_negation
            ("nQ + (−(½I))Q", body_sum(m(n_mu), m(body_negation(hI))), False),          # mat_mult_distributes_over_sum_in_left_factor
            ("nQ + (−((½I)Q))", body_sum(m(n_mu), body_negation(m(hI))), False),         # negation_factors_out_of_left_factor
            ("nQ − (½I)Q", body_difference(m(n_mu), m(hI)), False),                      # 右辺から左辺へ
            ("nQ − ½(IQ)", body_difference(m(n_mu), sc(half, mul(Id, Q))), False),        # scalar_multiple_factors_out_of_left_factor
            ("nQ − ½Q", body_difference(m(n_mu), sc(half, Q)), False),                   # identity_matrix_is_left_unit_of_mat_mult
        ]
        nQ = m(n_mu)
    else:
        m = lambda A: mul(Q, A)                                          # A ↦ QA
        common = [
            ("Q(n − ½I)", m(body_difference(n_mu, hI)), False),
            ("Q(n + (−(½I)))", m(body_sum(n_mu, body_negation(hI))), False),            # matrix_difference_is_sum_with_negation
            ("Qn + Q(−(½I))", body_sum(m(n_mu), m(body_negation(hI))), False),          # mat_mult_distributes_over_sum_in_right_factor
            ("Qn + (−(Q(½I)))", body_sum(m(n_mu), body_negation(m(hI))), False),         # negation_factors_out_of_right_factor
            ("Qn − Q(½I)", body_difference(m(n_mu), m(hI)), False),                      # 右辺から左辺へ
            ("Qn − ½(QI)", body_difference(m(n_mu), sc(half, mul(Q, Id))), False),        # scalar_multiple_factors_out_of_right_factor
            ("Qn − ½Q", body_difference(m(n_mu), sc(half, Q)), False),                   # identity_matrix_is_right_unit_of_mat_mult
        ]
        nQ = m(n_mu)
    O = 0 * Q
    if e == 1:
        case = [
            ("nQ − ½Q", body_difference(nQ, sc(half, Q)), False),                         # ε(μ) によらない部分の鎖
            ("Q − ½Q", body_difference(Q, sc(half, Q)), True),                             # (3) の ε(ν) = 1
            ("1Q − ½Q", body_difference(sc(R(1), Q), sc(half, Q)), False),                 # scalar_multiple_by_one を右辺から左辺へ
            ("(1 − ½)Q", sc(R(1) + body_neg_scalar(half), Q), False),                     # difference_of_scalar_multiples_of_one_matrix
            ("½Q", sc(half, Q), False),                                                    # real_one_minus_half_is_half
            ("h(1)Q", sc(h_of(1, R), Q), False),                                           # def_half_sign_of_binary_value の h(1) := ½
            ("h(ε(μ))Q", sc(h_of(e, R), Q), False),                                        # 場合の仮定
        ]
    else:
        case = [
            ("nQ − ½Q", body_difference(nQ, sc(half, Q)), False),
            ("O − ½Q", body_difference(O, sc(half, Q)), True),                             # (3) の ε(ν) = 0
            ("0Q − ½Q", body_difference(sc(R(0), Q), sc(half, Q)), False),                 # zero_scalar_multiple_is_zero_matrix を右辺から左辺へ
            ("(0 − ½)Q", sc(R(0) + body_neg_scalar(half), Q), False),                     # difference_of_scalar_multiples_of_one_matrix
            ("(−(½))Q", sc(body_neg_scalar(half), Q), False),                              # 0 − a = −a
            ("h(0)Q", sc(h_of(0, R), Q), False),                                           # def_half_sign_of_binary_value の h(0) := −(½)
            ("h(ε(μ))Q", sc(h_of(e, R), Q), False),                                        # 場合の仮定
        ]
    return common, case


def main_chain(side, n, Q, gam, eps, Id):
    """X̌Q̌_ε（side = "left"）または Q̌_εX̌（"right"）から ǧ(ε)Q̌_ε までの 8 行の鎖の 9 項。"""
    R = Q.base_ring()
    M = len(n)
    half = R(1) / 2
    hI = body_scalar(half, Id)
    sc, mul, fs = body_scalar, body_product, body_finite_sum
    terms = lambda f: fs([f(mu) for mu in range(M)])
    h = [h_of(eps[mu], R) for mu in range(M)]
    X = terms(lambda mu: sc(gam[mu], body_difference(n[mu], hI)))
    g = sum(gam[mu] * h[mu] for mu in range(M))                        # ǧ の定義（Σ_{μ∈M̌} は def_sum_over_check_index_set で左から足す）
    if side == "left":
        m = lambda A: mul(A, Q)
        first = ("X Q", mul(X, Q), False)
        second = ("(Σ γ(n − ½I)) Q", mul(terms(lambda mu: sc(gam[mu], body_difference(n[mu], hI))), Q), False)
    else:
        m = lambda A: mul(Q, A)
        first = ("Q X", mul(Q, X), False)
        second = ("Q (Σ γ(n − ½I))", mul(Q, terms(lambda mu: sc(gam[mu], body_difference(n[mu], hI)))), False)
    return [
        first,
        second,                                                                                    # def_check_number_operator (2)
        ("Σ (γ(n − ½I))·Q", terms(lambda mu: m(sc(gam[mu], body_difference(n[mu], hI)))), False),  # finite_sum_of_matrices_distributes_in_*_factor
        ("Σ γ((n − ½I)·Q)", terms(lambda mu: sc(gam[mu], m(body_difference(n[mu], hI)))), False), # scalar_multiple_factors_out_of_*_factor
        ("Σ γ(h(ε(μ))Q)", terms(lambda mu: sc(gam[mu], sc(h[mu], Q))), True),                     # μ ごとの等式を各項へ
        ("Σ (γh(ε(μ)))Q", terms(lambda mu: sc(gam[mu] * h[mu], Q)), False),                        # scalar_multiple_is_associative
        ("(Σ_{μ=1}^{M} γh(ε(μ)))Q", sc(sum(gam[mu] * h[mu] for mu in range(M)), Q), False),       # finite_sum_of_scalar_multiples_of_one_matrix
        ("(Σ_{μ∈M̌} γh(ε(μ)))Q", sc(sum(gam[mu] * h[mu] for mu in range(M)), Q), False),          # def_sum_over_check_index_set を右辺から左辺へ（作り方で自明）
        ("ǧ Q", sc(g, Q), False),                                                                  # ǧ の定義
    ]


def check_lines(lines, label, expect_all):
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


def run_step1(side):
    global count
    count = 0
    for (tag, M, R, n, gammas) in chain_settings([2, 3, 4], symbolic_gamma=True):
        Id = body_identity(R, 2 ** M)
        for eps in cartesian_product([[0, 1]] * M):
            eps = [int(e) for e in eps]
            Q = joint_projector(n, eps, Id)
            O = 0 * Q
            for mu in range(M):                                          # 鎖の仮定 (3) が ň_μ の供給元で成り立つ
                target = Q if eps[mu] == 1 else O
                assert n[mu] * Q == target and Q * n[mu] == target
            for mu in range(M):
                common, case = per_mu_chains(side, n[mu], Q, eps[mu], Id)
                check_lines(common, (tag, eps, mu, "common"), True)
                check_lines(case, (tag, eps, mu, "case"), True)
            lines = main_chain(side, n, Q, gammas, eps, Id)
            check_lines(lines, (tag, eps, "main"), True)
            # 主張の左辺を Sage の演算（独立な経路）で組んだ X̌Q̌・Q̌X̌ と、右辺 ǧQ̌ と比べる
            Xs = sum(gammas[mu] * (n[mu] - Id / 2) for mu in range(M))
            gs = sum(gammas[mu] * (R(1) / 2 if eps[mu] == 1 else -(R(1) / 2)) for mu in range(M))
            lhs = Xs * Q if side == "left" else Q * Xs
            assert lhs == lines[0][1] == lines[-1][1] == gs * Q
    # 否定コントロール: 不定元の成分の 2×2 行列 N_μ、Q と不定元 γ_μ（M = 2、ε = (1, 0)）では、仮定 (3) を引く行だけが外れる
    names = [f"n{mu}_{j}" for mu in range(2) for j in range(4)] + [f"q{j}" for j in range(4)] + ["g0", "g1"]
    P = PolynomialRing(QQ, names)
    G = P.gens()
    Ng = [matrix(P, 2, 2, G[0:4]), matrix(P, 2, 2, G[4:8])]
    Qg = matrix(P, 2, 2, G[8:12])
    Idg = body_identity(P, 2)
    neg = 0
    for mu, e in ((0, 1), (1, 0)):
        common, case = per_mu_chains(side, Ng[mu], Qg, e, Idg)
        assert not check_lines(common, "generic-common", False)
        failed = check_lines(case, "generic-case", False)
        assert len(failed) == 1 and failed[0][2], failed
        neg += 1
    failed = check_lines(main_chain(side, Ng, Qg, [G[12], G[13]], [1, 0], Idg), "generic-main", False)
    assert len(failed) == 1 and failed[0][2], failed
    neg += 1
    return count, neg
