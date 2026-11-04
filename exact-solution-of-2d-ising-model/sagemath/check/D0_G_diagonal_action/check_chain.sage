# 対象ラベル: D0_G_diagonal_action（D_0f_{ι(s)} = (Σ_{m=1}^{M_col-1} s(m)s(m+1))_ℂ f_{ι(s)}、
#                                 Gf_{ι(s)} = (s(M_col)s(1))_ℂ f_{ι(s)}）
# 証明の準備の鎖（各 m）、開鎖項の鎖、周期境界項の鎖の全ての行を、各行に書かれた式のとおりに組み、
# 隣どうしを QQ(i) で厳密に比べる。M_col = 2..6、全ての s ∈ 𝔐。
# 本文の定め方の経路:
#   σ_m^z は def_site_pauli_matrices（def_kronecker (2) の成分の式、pauli_sites_exact.sage の site）、
#   f_{ι(s)} は def_config_basis_iso の ι と def_end_iso の f_I = e_{i_1}⊠⋯⊠e_{i_M}（成分の式 Π_k (e_{i_k})_{j_k}）、
#   積は mat_mult の成分の式（body_product、数ベクトルは 2^M 行 1 列）、スカラー倍は def_matrix_scalar_multiple（body_scalar）、
#   行列の有限和は def_finite_sum_of_matrices（body_finite_sum）、複素数の有限和は def_finite_sum_of_complex_numbers の
#   左からの和（cc_finite_sum）、ℂ の積は definition_of_cc の積を QQ の対で計算したもの（cc_mul）、
#   ℝ→ℂ の包含 r_ℂ は inclusion_rr_to_cc の r ↦ (r, 0)（incl）。s(m) ∈ {−1, 1} は QQ ⊂ ℝ の元として持つ。
# 比べる側の独立な経路は Sage の tensor_product・`*`・スカラー倍・`sum` で組んだ同じ量である。
# 浮動小数点は使わない（全ての量が QQ(i) にある）。
load("../../_shared/pauli_sites_exact.sage")

P_ = body_product
S_ = body_scalar
F_ = body_finite_sum
E_BASIS = {1: matrix(KG, 2, 1, [1, 0]), 2: matrix(KG, 2, 1, [0, 1])}   # def_end_iso の e_1, e_2


def incl(r):
    """inclusion_rr_to_cc: r ↦ (r, 0)。"""
    r = QQ(r)
    return KG([r, 0])


def cc_mul(z, w):
    """definition_of_cc の積 (a,b)(c,d) = (ac − bd, ad + bc)。"""
    a, b = z.list()
    c, d = w.list()
    return KG([a*c - b*d, a*d + b*c])


def cc_finite_sum(zs):
    """def_finite_sum_of_complex_numbers: 左から順に (a,b)+(c,d) = (a+c, b+d) で足す。"""
    a, b = zs[0].list()
    for z in zs[1:]:
        c, d = z.list()
        a, b = a + c, b + d
    return KG([a, b])


def real_finite_sum(rs):
    """def_finite_sum_of_real_numbers: 左から順に足す（QQ ⊂ ℝ）。"""
    t = QQ(rs[0])
    for r in rs[1:]:
        t = t + QQ(r)
    return t


def iota(s):
    """def_config_basis_iso: i_m = 1（s(m) = +1）、2（s(m) = −1）。"""
    return tuple(1 if x == 1 else 2 for x in s)


def f_basis(I):
    """def_end_iso の f_I（def_kronecker (2) の成分の式 (f_I)_{ν(J)} = Π_k (e_{i_k})_{j_k}）。"""
    M = len(I)
    v = matrix(KG, 2**M, 1)
    for J in index_set(M):
        v[nu(J) - 1, 0] = prod(E_BASIS[I[k]][J[k] - 1, 0] for k in range(M))
    w = E_BASIS[I[0]]
    for k in range(1, M):
        w = w.tensor_product(E_BASIS[I[k]])
    assert v == w
    return v


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


rep = Report("D0_G_diagonal_action: 準備・開鎖項・周期境界項の鎖と主張")

for M in range(2, 7):
    SZs = {m: site(M, m, 'z') for m in range(1, M + 1)}
    SXs = {m: site(M, m, 'x') for m in range(1, M + 1)}
    # 配置 s に依らない行列の積 σ_m^zσ_{m+1}^z・σ_M^zσ_1^z は、本文の成分の式で M ごとに一度だけ組む
    PAIR = {m: P_(SZs[m], SZs[m + 1]) for m in range(1, M)}
    D0 = F_([PAIR[m] for m in range(1, M)])                          # def_D0_open_chain_operator
    G = P_(SZs[M], SZs[1])                                            # def_G_boundary_operator
    D0_sage = sum(kron_sage(site_factors(M, m, SZ)) * kron_sage(site_factors(M, m + 1, SZ)) for m in range(1, M))
    G_sage = kron_sage(site_factors(M, M, SZ)) * kron_sage(site_factors(M, 1, SZ))
    rep.check(D0 == D0_sage and G == G_sage, f"M={M}: D_0・G の本文の経路と Sage の経路")
    # 否定コントロールの材料: σ^x で組んだ開鎖項、周期境界で閉じた和
    D0_x = F_([P_(SXs[m], SXs[m + 1]) for m in range(1, M)])
    for s in cartesian_product([[1, -1]] * M):
        s = tuple(QQ(x) for x in s)
        sv = lambda m: s[m - 1]
        f = f_basis(iota(s))
        # sigma_z_diagonal_action の個々の場合（準備の 2・4 行目の根拠）
        for m in range(1, M + 1):
            rep.check(P_(SZs[m], f) == S_(incl(sv(m)), f), f"M={M}, s={s}, m={m}: sigma_z_diagonal_action")
        # 準備の鎖（各 m）
        for m in range(1, M):
            a, b = incl(sv(m + 1)), incl(sv(m))
            rep.check(cc_mul(a, b) == incl(sv(m + 1) * sv(m)), f"M={M}, s={s}, m={m}: real_inclusion_preserves_product")
            lines = [
                ("(σ_m^zσ_{m+1}^z)f", P_(PAIR[m], f)),
                ("σ_m^z(σ_{m+1}^zf)", P_(SZs[m], P_(SZs[m + 1], f))),
                ("σ_m^z(s(m+1)_ℂf)", P_(SZs[m], S_(incl(sv(m + 1)), f))),
                ("s(m+1)_ℂ(σ_m^zf)", S_(incl(sv(m + 1)), P_(SZs[m], f))),
                ("s(m+1)_ℂ(s(m)_ℂf)", S_(incl(sv(m + 1)), S_(incl(sv(m)), f))),
                ("(s(m+1)_ℂs(m)_ℂ)f", S_(cc_mul(incl(sv(m + 1)), incl(sv(m))), f)),
                ("(s(m+1)s(m))_ℂf", S_(incl(sv(m + 1) * sv(m)), f)),
                ("(s(m)s(m+1))_ℂf", S_(incl(sv(m) * sv(m + 1)), f)),
            ]
            rep.chain(lines, f"M={M}, s={s}, m={m}: 準備")
        # 開鎖項の鎖
        coeffs = [sv(m) * sv(m + 1) for m in range(1, M)]
        rep.check(cc_finite_sum([incl(c) for c in coeffs]) == incl(real_finite_sum(coeffs)),
                  f"M={M}, s={s}: real_inclusion_preserves_finite_sum")
        lines = [
            ("D_0f", P_(D0, f)),
            ("(Σσ_m^zσ_{m+1}^z)f", P_(F_([PAIR[m] for m in range(1, M)]), f)),
            ("Σ((σ_m^zσ_{m+1}^z)f)", F_([P_(PAIR[m], f) for m in range(1, M)])),
            ("Σ((s(m)s(m+1))_ℂf)", F_([S_(incl(c), f) for c in coeffs])),
            ("(Σ(s(m)s(m+1))_ℂ)f", S_(cc_finite_sum([incl(c) for c in coeffs]), f)),
            ("(Σs(m)s(m+1))_ℂf", S_(incl(real_finite_sum(coeffs)), f)),
        ]
        rep.chain(lines, f"M={M}, s={s}: 開鎖項")
        # 周期境界項の鎖
        lines = [
            ("Gf", P_(G, f)),
            ("(σ_M^zσ_1^z)f", P_(G, f)),
            ("σ_M^z(σ_1^zf)", P_(SZs[M], P_(SZs[1], f))),
            ("σ_M^z(s(1)_ℂf)", P_(SZs[M], S_(incl(sv(1)), f))),
            ("s(1)_ℂ(σ_M^zf)", S_(incl(sv(1)), P_(SZs[M], f))),
            ("s(1)_ℂ(s(M)_ℂf)", S_(incl(sv(1)), S_(incl(sv(M)), f))),
            ("(s(1)_ℂs(M)_ℂ)f", S_(cc_mul(incl(sv(1)), incl(sv(M))), f)),
            ("(s(1)s(M))_ℂf", S_(incl(sv(1) * sv(M)), f)),
            ("(s(M)s(1))_ℂf", S_(incl(sv(M) * sv(1)), f)),
        ]
        rep.chain(lines, f"M={M}, s={s}: 周期境界項")
        # 主張を Sage の経路で独立に確かめる
        rep.check(D0_sage * f == KG(sum(coeffs)) * f, f"M={M}, s={s}: 主張 D_0（Sage の経路）")
        rep.check(G_sage * f == KG(sv(M) * sv(1)) * f, f"M={M}, s={s}: 主張 G（Sage の経路）")
    # 否定コントロール（M ごとに、全ての s のどれかで外れること）
    configs = [tuple(QQ(x) for x in s) for s in cartesian_product([[1, -1]] * M)]
    rep.negative(any(P_(D0, f_basis(iota(s))) != S_(incl(sum(s[m - 1] + s[m] for m in range(1, M))), f_basis(iota(s)))
                     for s in configs), f"M={M}: 係数を s(m)+s(m+1) の和にすると外れる")
    rep.negative(any(P_(D0, f_basis(iota(s))) != S_(incl(sum(s[m - 1] * s[m % M] for m in range(1, M + 1))), f_basis(iota(s)))
                     for s in configs), f"M={M}: 係数を周期境界で閉じた和にすると外れる")
    rep.negative(any(P_(D0_x, f_basis(iota(s))) != S_(incl(sum(s[m - 1] * s[m] for m in range(1, M))), f_basis(iota(s)))
                     for s in configs), f"M={M}: σ^x で組んだ開鎖項は f_ι(s) を係数倍しない")
    rep.negative(any(P_(G, f_basis(iota(s))) != S_(incl(-s[M - 1] * s[0]), f_basis(iota(s))) for s in configs),
                 f"M={M}: G の係数の符号を変えると外れる")

rep.finish()
