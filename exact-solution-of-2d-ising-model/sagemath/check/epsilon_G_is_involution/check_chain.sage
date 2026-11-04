# 対象ラベル: epsilon_G_is_involution（(εG)^2 = I_{Mat(2^{M_col},ℂ)}）
# 証明の準備の鎖（各 k の 6 行）と主張の鎖（16 行）の全ての行を、各行に書かれた式のとおりに組み、
# 隣どうしを QQ(i) で厳密に比べる。M_col = 2..5、全ての k。
# 本文の定め方の経路（pauli_sites_exact.sage）:
#   σ_k^z は def_site_pauli_matrices（def_kronecker (2) の成分の式 kron_def）、ε は def_global_spin_flip_matrix の
#   σ_1^x⋯σ_M^x を左から掛けたもの、G は def_G_boundary_operator の σ_M^zσ_1^z、積は mat_mult の成分の式（body_product）、
#   単位行列は def_identity_matrix の δ_{ij}（body_identity）、X^2 := XX。
# 比べる側の独立な経路は Sage の tensor_product・`*`・`^`・identity_matrix で組んだ同じ行列である。
# 浮動小数点は使わない（全ての成分が QQ(i) にある）。
load("../../_shared/pauli_sites_exact.sage")

P_ = body_product


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


rep = Report("epsilon_G_is_involution: 準備と主張の鎖")

I2b = body_identity(KG, 2)
rep.check(I2b == I2, "def_identity_matrix の I_{Mat(2,ℂ)}")
rep.check(P_(I2, I2) == I2, "identity_matrix_is_left_unit_of_mat_mult の II = I（Mat(2,ℂ)）")
rep.check(P_(SZ, SZ) == I2, "pauli_matrix_products の σ^zσ^z = I")

for M in range(2, 6):
    Id = body_identity(KG, 2**M)
    E = epsilon(M)
    S = {k: site(M, k, 'z') for k in range(1, M + 1)}
    SM, S1 = S[M], S[1]
    G = P_(SM, S1)
    # 準備（各 k）
    for k in range(1, M + 1):
        fac = site_factors(M, k, SZ)
        lines = [
            ("σ_kσ_k", P_(S[k], S[k])),
            ("(I⊠…σ^z…⊠I)(I⊠…σ^z…⊠I)", P_(kron_def(fac), kron_def(fac))),
            ("(II)⊠…(σ^zσ^z)…⊠(II)", kron_def([P_(A, A) for A in fac])),
            ("I⊠…(σ^zσ^z)…⊠I", kron_def([P_(SZ, SZ) if j == k else I2 for j in range(1, M + 1)])),
            ("I⊠…I…⊠I", kron_def([I2] * M)),
            ("I_{2^M}", Id),
        ]
        rep.chain(lines, f"M={M}, k={k}: 準備")
    # 根拠の個々の場合
    rep.check(P_(E, G) == P_(G, E), f"M={M}: epsilon_D0_G_pairwise_commute の εG = Gε")
    rep.check(P_(E, E) == Id, f"M={M}: epsilon_square_and_eigenvalues の εε = I")
    rep.check(P_(S1, SM) == P_(SM, S1), f"M={M}: distinct_site_pauli_matrices_commute（1 ≠ M）")
    for X in [G, E, Id]:
        rep.check(P_(Id, X) == X, f"M={M}: identity_matrix_is_left_unit_of_mat_mult")
    EG = P_(E, G)
    lines = [
        ("(εG)^2", EG^2),                             # Sage の `^`（X^2 := XX を独立な経路で）
        ("(εG)(εG)", P_(P_(E, G), P_(E, G))),
        ("((εG)ε)G", P_(P_(EG, E), G)),
        ("(ε(Gε))G", P_(P_(E, P_(G, E)), G)),
        ("(ε(εG))G", P_(P_(E, P_(E, G)), G)),
        ("((εε)G)G", P_(P_(P_(E, E), G), G)),
        ("(IG)G", P_(P_(Id, G), G)),
        ("GG", P_(G, G)),
        ("(σ_Mσ_1)(σ_Mσ_1)", P_(P_(SM, S1), P_(SM, S1))),
        ("σ_M(σ_1(σ_Mσ_1))", P_(SM, P_(S1, P_(SM, S1)))),
        ("σ_M((σ_1σ_M)σ_1)", P_(SM, P_(P_(S1, SM), S1))),
        ("σ_M((σ_Mσ_1)σ_1)", P_(SM, P_(P_(SM, S1), S1))),
        ("σ_M(σ_M(σ_1σ_1))", P_(SM, P_(SM, P_(S1, S1)))),
        ("(σ_Mσ_M)(σ_1σ_1)", P_(P_(SM, SM), P_(S1, S1))),
        ("II", P_(Id, Id)),
        ("I", Id),
    ]
    rep.chain(lines, f"M={M}: 主張の鎖")
    # 否定コントロール
    Gx = P_(site(M, M, 'x'), S1)
    EGx = P_(E, Gx)
    rep.negative(P_(EGx, EGx) != Id, f"M={M}: G を σ_M^xσ_1^z に替えると (εG)^2 ≠ I（実際は −I）")
    rep.negative(P_(EG, EG) != body_negation(Id), f"M={M}: 右辺を −I にすると外れる")
    rep.negative(EG != Id, f"M={M}: εG 自身は I ではない（二乗を取らないと外れる）")

# 主張を Sage の経路だけで独立に確かめる（M_col = 2..7）
for M in range(2, 8):
    Es = identity_matrix(KG, 2**M)
    for k in range(1, M + 1):
        Es = Es * kron_sage(site_factors(M, k, SX))
    Gs = kron_sage(site_factors(M, M, SZ)) * kron_sage(site_factors(M, 1, SZ))
    rep.check((Es * Gs)^2 == identity_matrix(KG, 2**M), f"M={M}: 主張 (εG)^2 = I（Sage の経路）")

rep.finish()
