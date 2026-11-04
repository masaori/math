# 対象ラベル: epsilon_D0_G_pairwise_commute（εD_0 = D_0ε、εG = Gε、D_0G = GD_0）
# 証明の準備「ε と σ^z の対の可換」（各 j, k の 9 行）、準備「σ^z どうしの可換」（各 j, k）、準備「σ^z の対と G の可換」（各 m の 15 行）、εD_0 の鎖（6 行）、
# εG の鎖（4 行）、D_0G の鎖（6 行）の全ての行を、各行に書かれた式のとおりに組み、隣どうしを QQ(i) で厳密に比べる。
# 本文の定め方の経路（pauli_sites_exact.sage）:
#   σ_k^z は def_site_pauli_matrices（def_kronecker (2) の成分の式）、ε は def_global_spin_flip_matrix の σ_1^x⋯σ_M^x を
#   左から掛けたもの、積は mat_mult の成分の式（body_product）、符号反転は def_matrix_negation の成分の式（body_negation）、
#   行列の有限和は def_finite_sum_of_matrices の左からの和（body_finite_sum）。
# 比べる側の独立な経路は Sage の tensor_product・`*`・`sum` で組んだ同じ行列である。
# 浮動小数点は使わない（全ての成分が QQ(i) にある）。
load("../../_shared/pauli_sites_exact.sage")

P_ = body_product
N_ = body_negation
F_ = body_finite_sum


class Report:
    def __init__(self, title):
        self.title, self.n, self.neg, self.fail = title, 0, 0, 0
        print(f"=== {title} ===", flush=True)

    def chain(self, lines, label):
        for (a, A), (b, B) in zip(lines, lines[1:]):
            self.n += 1
            if A != B:
                self.fail += 1
                print(f"FAIL: {label}: 「{a}」≠「{b}」", flush=True)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
            print(f"FAIL: {label}", flush=True)

    def negative(self, differs, label):
        self.neg += 1
        if not differs:
            self.fail += 1
            print(f"FAIL（否定コントロールが外れない）: {label}", flush=True)

    def finish(self):
        print(f"等号・主張 {self.n} 件、否定コントロール {self.neg} 件、失敗 {self.fail} 件")
        print("RESULT: " + ("PASS" if self.fail == 0 else "FAIL"))
        assert self.fail == 0


rep = Report("epsilon_D0_G_pairwise_commute: 三つの準備 と三つの鎖")

for M in range(2, 6):
    E = epsilon(M)
    S = {k: site(M, k, 'z') for k in range(1, M + 1)}
    PAIR = {m: P_(S[m], S[m + 1]) for m in range(1, M)}
    D0 = F_([PAIR[m] for m in range(1, M)])          # def_D0_open_chain_operator
    G = P_(S[M], S[1])                                # def_G_boundary_operator
    SM, S1 = S[M], S[1]
    # 準備「ε と σ^z の対の可換」 の根拠 epsilon_anticommutes_with_site_sigma_z の個々の場合
    for k in range(1, M + 1):
        rep.check(P_(E, S[k]) == N_(P_(S[k], E)), f"M={M}, k={k}: εσ_k^z = −(σ_k^zε)")
    # 準備「ε と σ^z の対の可換」（各 j, k）
    for j in range(1, M + 1):
        for k in range(1, M + 1):
            Sj, Sk = S[j], S[k]
            lines = [
                ("ε(σ_jσ_k)", P_(E, P_(Sj, Sk))),
                ("(εσ_j)σ_k", P_(P_(E, Sj), Sk)),
                ("(−(σ_jε))σ_k", P_(N_(P_(Sj, E)), Sk)),
                ("−((σ_jε)σ_k)", N_(P_(P_(Sj, E), Sk))),
                ("−(σ_j(εσ_k))", N_(P_(Sj, P_(E, Sk)))),
                ("−(σ_j(−(σ_kε)))", N_(P_(Sj, N_(P_(Sk, E))))),
                ("−(−(σ_j(σ_kε)))", N_(N_(P_(Sj, P_(Sk, E))))),
                ("σ_j(σ_kε)", P_(Sj, P_(Sk, E))),
                ("(σ_jσ_k)ε", P_(P_(Sj, Sk), E)),
            ]
            rep.chain(lines, f"M={M}, j={j}, k={k}: 準備「ε と σ^z の対の可換」")
            # 準備「σ^z どうしの可換」
            rep.check(P_(Sj, Sk) == P_(Sk, Sj), f"M={M}, j={j}, k={k}: 準備「σ^z どうしの可換」")
    # 準備「σ^z の対と G の可換」（各 m）
    for m in range(1, M):
        Sm, Sn = S[m], S[m + 1]
        lines = [
            ("(σ_mσ_{m+1})G", P_(PAIR[m], G)),
            ("(σ_mσ_{m+1})(σ_Mσ_1)", P_(PAIR[m], P_(SM, S1))),
            ("σ_m(σ_{m+1}(σ_Mσ_1))", P_(Sm, P_(Sn, P_(SM, S1)))),
            ("σ_m((σ_{m+1}σ_M)σ_1)", P_(Sm, P_(P_(Sn, SM), S1))),
            ("σ_m((σ_Mσ_{m+1})σ_1)", P_(Sm, P_(P_(SM, Sn), S1))),
            ("σ_m(σ_M(σ_{m+1}σ_1))", P_(Sm, P_(SM, P_(Sn, S1)))),
            ("σ_m(σ_M(σ_1σ_{m+1}))", P_(Sm, P_(SM, P_(S1, Sn)))),
            ("(σ_mσ_M)(σ_1σ_{m+1})", P_(P_(Sm, SM), P_(S1, Sn))),
            ("(σ_Mσ_m)(σ_1σ_{m+1})", P_(P_(SM, Sm), P_(S1, Sn))),
            ("σ_M(σ_m(σ_1σ_{m+1}))", P_(SM, P_(Sm, P_(S1, Sn)))),
            ("σ_M((σ_mσ_1)σ_{m+1})", P_(SM, P_(P_(Sm, S1), Sn))),
            ("σ_M((σ_1σ_m)σ_{m+1})", P_(SM, P_(P_(S1, Sm), Sn))),
            ("σ_M(σ_1(σ_mσ_{m+1}))", P_(SM, P_(S1, P_(Sm, Sn)))),
            ("(σ_Mσ_1)(σ_mσ_{m+1})", P_(P_(SM, S1), P_(Sm, Sn))),
            ("G(σ_mσ_{m+1})", P_(G, PAIR[m])),
        ]
        rep.chain(lines, f"M={M}, m={m}: 準備「σ^z の対と G の可換」")
    # εD_0 の鎖
    lines = [
        ("εD_0", P_(E, D0)),
        ("ε(Σσ_mσ_{m+1})", P_(E, F_([PAIR[m] for m in range(1, M)]))),
        ("Σε(σ_mσ_{m+1})", F_([P_(E, PAIR[m]) for m in range(1, M)])),
        ("Σ(σ_mσ_{m+1})ε", F_([P_(PAIR[m], E) for m in range(1, M)])),
        ("(Σσ_mσ_{m+1})ε", P_(F_([PAIR[m] for m in range(1, M)]), E)),
        ("D_0ε", P_(D0, E)),
    ]
    rep.chain(lines, f"M={M}: εD_0")
    # εG の鎖
    lines = [
        ("εG", P_(E, G)),
        ("ε(σ_Mσ_1)", P_(E, P_(SM, S1))),
        ("(σ_Mσ_1)ε", P_(P_(SM, S1), E)),
        ("Gε", P_(G, E)),
    ]
    rep.chain(lines, f"M={M}: εG")
    # D_0G の鎖
    lines = [
        ("D_0G", P_(D0, G)),
        ("(Σσ_mσ_{m+1})G", P_(F_([PAIR[m] for m in range(1, M)]), G)),
        ("Σ(σ_mσ_{m+1})G", F_([P_(PAIR[m], G) for m in range(1, M)])),
        ("ΣG(σ_mσ_{m+1})", F_([P_(G, PAIR[m]) for m in range(1, M)])),
        ("G(Σσ_mσ_{m+1})", P_(G, F_([PAIR[m] for m in range(1, M)]))),
        ("GD_0", P_(G, D0)),
    ]
    rep.chain(lines, f"M={M}: D_0G")
    # 否定コントロール
    SX1 = site(M, 1, 'x')
    rep.negative(P_(SX1, D0) != P_(D0, SX1), f"M={M}: ε を σ_1^x に替えると D_0 と可換でない")
    rep.negative(P_(E, PAIR[1]) != N_(P_(PAIR[1], E)), f"M={M}: 準備「ε と σ^z の対の可換」 の右辺の符号を変えると外れる")
    Gy = P_(site(M, M, 'y'), S1)
    rep.negative(P_(D0, Gy) != P_(Gy, D0), f"M={M}: G を σ_M^yσ_1^z に替えると D_0 と可換でない")
    Gx = P_(site(M, M, 'x'), S1)
    rep.negative(P_(E, Gx) != P_(Gx, E), f"M={M}: G を σ_M^xσ_1^z に替えると ε と可換でない")

# 主張を Sage の経路だけで独立に確かめる（M_col = 2..7）
for M in range(2, 8):
    Es = identity_matrix(KG, 2**M)
    for k in range(1, M + 1):
        Es = Es * kron_sage(site_factors(M, k, SX))
    Zs = {k: kron_sage(site_factors(M, k, SZ)) for k in range(1, M + 1)}
    D0s = sum(Zs[m] * Zs[m + 1] for m in range(1, M))
    Gs = Zs[M] * Zs[1]
    rep.check(Es * D0s == D0s * Es, f"M={M}: 主張 εD_0 = D_0ε（Sage の経路）")
    rep.check(Es * Gs == Gs * Es, f"M={M}: 主張 εG = Gε（Sage の経路）")
    rep.check(D0s * Gs == Gs * D0s, f"M={M}: 主張 D_0G = GD_0（Sage の経路）")

rep.finish()
