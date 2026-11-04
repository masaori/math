# 対象ラベル: epsilon_anticommutes_with_check_Z_Y の検算の共通の準備。
# 証明の各鎖の各行を、本文の定め方（_shared/matrix_operations_by_definition.sage の body_product・body_scalar・body_sum・
# body_finite_sum・body_identity と、_shared/matrix_negation_and_difference_by_definition.sage の body_negation・body_difference）で
# 行の括弧どおりに組む関数を置く。各検算はこれらの行を隣どうし比べる。成分の環は呼ぶ側が決める（どれも厳密計算）。
# 読み込む前に、呼ぶ側が body_* を定める共有の準備を読み込んでおく。


class Report:
    def __init__(self, title):
        self.title, self.n, self.fail, self.neg = title, 0, 0, 0
        print(f"=== {title} ===", flush=True)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
            print(f"FAIL: {label}", flush=True)

    def negative(self, differs, label):
        """否定コントロール: differs が真（等号が外れる）であるべきもの。"""
        self.neg += 1
        if not differs:
            self.fail += 1
            print(f"FAIL（否定コントロールが外れない）: {label}", flush=True)

    def chain(self, lines, label):
        """lines = [(行の名前, 行列), ...] の隣どうしの等号を一つずつ確かめる。"""
        for (a, A), (b, B) in zip(lines, lines[1:]):
            self.check(A == B, f"{label}: 「{a}」=「{b}」")

    def finish(self):
        print(f"等号・主張 {self.n} 件、否定コントロール {self.neg} 件、失敗 {self.fail} 件")
        print("RESULT: " + ("PASS" if self.fail == 0 else "FAIL"))
        assert self.fail == 0


def failing_steps(lines):
    """隣どうしで等しくない行の組の番号（0 始まり、k は k 行目と k+1 行目）を返す。否定コントロールで使う。"""
    return [k for k in range(len(lines) - 1) if lines[k][1] != lines[k + 1][1]]


P_ = lambda A, B: body_product(A, B)
N_ = lambda A: body_negation(A)
S_ = lambda a, A: body_scalar(a, A)


def chain_part2(G, Ws, cs, Wcheck):
    """(2) の鎖。G は ε（否定コントロールでは別の行列）、Ws[j-1] = W_{j_Z}、cs[j-1] = c_j、Wcheck = W̌_μ。"""
    J = range(len(Ws))
    return [
        ("εW̌_μ", P_(G, Wcheck)),
        ("ε Σ_j (c_j W_j)", P_(G, body_finite_sum([S_(cs[j], Ws[j]) for j in J]))),
        ("Σ_j ε(c_j W_j)", body_finite_sum([P_(G, S_(cs[j], Ws[j])) for j in J])),
        ("Σ_j c_j(εW_j)", body_finite_sum([S_(cs[j], P_(G, Ws[j])) for j in J])),
        ("Σ_j c_j(-(W_jε))", body_finite_sum([S_(cs[j], N_(P_(Ws[j], G))) for j in J])),
        ("Σ_j -(c_j(W_jε))", body_finite_sum([N_(S_(cs[j], P_(Ws[j], G))) for j in J])),
        ("Σ_j -((c_jW_j)ε)", body_finite_sum([N_(P_(S_(cs[j], Ws[j]), G)) for j in J])),
        ("-Σ_j ((c_jW_j)ε)", N_(body_finite_sum([P_(S_(cs[j], Ws[j]), G) for j in J]))),
        ("-((Σ_j c_jW_j)ε)", N_(P_(body_finite_sum([S_(cs[j], Ws[j]) for j in J]), G))),
        ("-(W̌_με)", N_(P_(Wcheck, G))),
    ]


def chain_part3(G, Zc, Yc, p, q, Psi):
    """(3) の鎖。Psi = pŽ_μ + qY̌_μ（def_check_fermi の第二の式）。"""
    return [
        ("εΨ", P_(G, Psi)),
        ("ε(pŽ + qY̌)", P_(G, body_sum(S_(p, Zc), S_(q, Yc)))),
        ("ε(pŽ) + ε(qY̌)", body_sum(P_(G, S_(p, Zc)), P_(G, S_(q, Yc)))),
        ("p(εŽ) + q(εY̌)", body_sum(S_(p, P_(G, Zc)), S_(q, P_(G, Yc)))),
        ("p(-(Žε)) + q(-(Y̌ε))", body_sum(S_(p, N_(P_(Zc, G))), S_(q, N_(P_(Yc, G))))),
        ("(-(p(Žε))) + (-(q(Y̌ε)))", body_sum(N_(S_(p, P_(Zc, G))), N_(S_(q, P_(Yc, G))))),
        ("(-((pŽ)ε)) + (-((qY̌)ε))", body_sum(N_(P_(S_(p, Zc), G)), N_(P_(S_(q, Yc), G)))),
        ("-((pŽ)ε + (qY̌)ε)", N_(body_sum(P_(S_(p, Zc), G), P_(S_(q, Yc), G)))),
        ("-((pŽ + qY̌)ε)", N_(P_(body_sum(S_(p, Zc), S_(q, Yc)), G))),
        ("-(Ψε)", N_(P_(Psi, G))),
    ]


def chain_part4_number(G, D, Pp, n):
    """(4) の ň_μ の鎖。D = ψ̌_μ^†、Pp = ψ̌_{M+1-μ}、n = ň_μ（def_check_number_operator）。"""
    return [
        ("εň_μ", P_(G, n)),
        ("ε(ψ̌_μ^†ψ̌_{σ(μ)})", P_(G, P_(D, Pp))),
        ("(ψ̌_μ^†ψ̌_{σ(μ)})ε", P_(P_(D, Pp), G)),
        ("ň_με", P_(n, G)),
    ]


def body_finite_product(factors):
    """def_finite_product_of_matrices の有限積を、mat_mult の積で左から順に掛けて組む。"""
    out = factors[0]
    for A in factors[1:]:
        out = body_product(out, A)
    return out


def factor_A(eps_nu, n, Id):
    """Q̌_ϵ の定義の因子 A_ν := ϵ_ν ň_ν + (1 - ϵ_ν)(I - ň_ν)。"""
    R = Id.base_ring()
    return body_sum(S_(R(eps_nu), n), S_(R(1 - eps_nu), body_difference(Id, n)))


def chain_part4_identity(G, Id):
    return [("εI", P_(G, Id)), ("ε", G), ("Iε", P_(Id, G))]


def chain_part4_factor(G, eps_nu, n, Id):
    R = Id.base_ring()
    a, b = R(eps_nu), R(1 - eps_nu)
    T1, T2 = S_(a, n), S_(b, body_difference(Id, n))
    A = factor_A(eps_nu, n, Id)
    return [
        ("εA_ν", P_(G, A)),
        ("ε(ϵ_νň_ν + (1-ϵ_ν)(I-ň_ν))", P_(G, body_sum(T1, T2))),
        ("ε(ϵ_νň_ν) + ε((1-ϵ_ν)(I-ň_ν))", body_sum(P_(G, T1), P_(G, T2))),
        ("(ϵ_νň_ν)ε + ((1-ϵ_ν)(I-ň_ν))ε", body_sum(P_(T1, G), P_(T2, G))),
        ("(ϵ_νň_ν + (1-ϵ_ν)(I-ň_ν))ε", P_(body_sum(T1, T2), G)),
        ("A_νε", P_(A, G)),
    ]


def chain_part4_Q(G, eps, ns, Id, Q):
    """Q = Q̌_ϵ を check_joint_eigenspace_decomposition の定義どおりに作ったもの。"""
    As = [factor_A(eps[k], ns[k], Id) for k in range(len(ns))]
    return [
        ("εQ̌_ϵ", P_(G, Q)),
        ("ε Π_ν A_ν", P_(G, body_finite_product(As))),
        ("(Π_ν A_ν)ε", P_(body_finite_product(As), G)),
        ("Q̌_ϵε", P_(Q, G)),
    ]


def Q_check_by_definition(eps, ns, Id):
    """check_joint_eigenspace_decomposition の Q̌_ϵ := Π_μ (ϵ_μň_μ + (1-ϵ_μ)(I-ň_μ))。
    比べる相手を独立に作るため、Sage の `*`・`+`・`-` で組む（chain_part4_Q の body_* の経路とは別）。"""
    R = Id.base_ring()
    Q = identity_matrix(R, Id.nrows())
    for e, n in zip(eps, ns):
        Q = Q * (R(e) * n + R(1 - e) * (identity_matrix(R, Id.nrows()) - n))
    return Q


def part4_three_equations(G, eps_nu, n, Id):
    """(4) の A_ν の鎖の前の 3 式（左辺, 右辺）。差との可換・スカラー倍との可換の 2 回の適用。"""
    R = Id.base_ring()
    D = body_difference(Id, n)
    T1, T2 = S_(R(eps_nu), n), S_(R(1 - eps_nu), D)
    return [
        ("ε(I-ň_ν) = (I-ň_ν)ε", P_(G, D), P_(D, G)),
        ("ε(ϵ_νň_ν) = (ϵ_νň_ν)ε", P_(G, T1), P_(T1, G)),
        ("ε((1-ϵ_ν)(I-ň_ν)) = ((1-ϵ_ν)(I-ň_ν))ε", P_(G, T2), P_(T2, G)),
    ]
