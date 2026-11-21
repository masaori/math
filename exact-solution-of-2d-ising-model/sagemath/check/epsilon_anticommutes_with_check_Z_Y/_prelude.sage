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


def factor_R(e, n, Id):
    """def_check_R_factor の R_ν^{(e)}: R_ν^{(1)} := ň_ν、R_ν^{(0)} := I - ň_ν。e は ε(ν) ∈ {0,1} で、算術はしない（場合分けだけ）。"""
    return n if e == 1 else body_difference(Id, n)


def chain_part4_identity(G, Id):
    return [("εI", P_(G, Id)), ("ε", G), ("Iε", P_(Id, G))]


def part4_difference_equation(G, n, Id):
    """(4) の εR の鎖の前の 1 式 ε(I - ň_ν) = (I - ň_ν)ε（commuting_with_difference の適用）。"""
    D = body_difference(Id, n)
    return ("ε(I-ň_ν) = (I-ň_ν)ε", P_(G, D), P_(D, G))


def chain_part4_factor(G, e, n, Id):
    """(4) の εR_ν^{(ε(ν))} = R_ν^{(ε(ν))}ε の鎖（ε(ν) = 1 と ε(ν) = 0 の場合に分けた 6 行ずつ）。"""
    R = factor_R(e, n, Id)
    if e == 1:
        R1 = factor_R(1, n, Id)
        return [
            ("εR_ν^{(ε(ν))}", P_(G, R)),
            ("εR_ν^{(1)}", P_(G, R1)),
            ("εň_ν", P_(G, n)),
            ("ň_νε", P_(n, G)),
            ("R_ν^{(1)}ε", P_(R1, G)),
            ("R_ν^{(ε(ν))}ε", P_(R, G)),
        ]
    R0 = factor_R(0, n, Id)
    D = body_difference(Id, n)
    return [
        ("εR_ν^{(ε(ν))}", P_(G, R)),
        ("εR_ν^{(0)}", P_(G, R0)),
        ("ε(I-ň_ν)", P_(G, D)),
        ("(I-ň_ν)ε", P_(D, G)),
        ("R_ν^{(0)}ε", P_(R0, G)),
        ("R_ν^{(ε(ν))}ε", P_(R, G)),
    ]


def chain_part4_Q(G, eps, ns, Id, Q):
    """Q = Q̌_ε を def_check_Q_epsilon どおりに作ったもの。Π_{ν∈M̌} と Π_{ν=1}^{M_col} は def_product_over_check_index_set
    により同じ左から掛ける有限積なので、行列としては同じものを並べる（その 2 行は記法の行き来だけ）。"""
    Rs = [factor_R(eps[k], ns[k], Id) for k in range(len(ns))]
    PR = body_finite_product(Rs)
    return [
        ("εQ̌_ε", P_(G, Q)),
        ("ε Π_{ν∈M̌} R_ν^{(ε(ν))}", P_(G, PR)),
        ("ε Π_{ν=1}^{M_col} R_ν^{(ε(ν))}", P_(G, PR)),
        ("(Π_{ν=1}^{M_col} R_ν^{(ε(ν))})ε", P_(PR, G)),
        ("(Π_{ν∈M̌} R_ν^{(ε(ν))})ε", P_(PR, G)),
        ("Q̌_εε", P_(Q, G)),
    ]


def Q_check_by_definition(eps, ns, Id):
    """def_check_Q_epsilon の Q̌_ε := Π_{μ∈M̌} R_μ^{(ε(μ))}。
    比べる相手を独立に作るため、Sage の `*`・`-` で組む（chain_part4_Q の body_* の経路とは別）。"""
    R = Id.base_ring()
    I = identity_matrix(R, Id.nrows())
    Q = identity_matrix(R, Id.nrows())
    for e, n in zip(eps, ns):
        Q = Q * (n if e == 1 else I - n)
    return Q
