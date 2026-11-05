# 対象ラベル: check_number_operator_is_hermitian
# 証明の (1)（Z_j^* = Z_j、Y_j^* = Y_j）を、QQ(i)（KG）の行列で厳密に確かめる。
#  - (σ^a)^* = σ^a（a ∈ {x, y, z}。pauli_matrix_products の成分）。
#  - (A_1⊠⋯⊠A_M)^* = A_1^*⊠⋯⊠A_M^*（def_kronecker (2) の成分の式。A_k は KG の成分の一般の 2 次の行列と Pauli 行列・I）。
#  - (σ_k^a)^* = σ_k^a（def_site_pauli_matrices）。
#  - Z_j の鎖 5 行と、Y_j の同じ鎖 5 行（σ_j^z を σ_j^y に替えたもの）。行ごとに括弧の形どおりに mat_mult の成分の式で組む。
# 共役転置は def_hermitian_positive_definite の成分の式（_conjugate_transpose.sage の body_star）で、比べる側に Sage の
# conjugate_transpose も置く。KG の複素共役は i ↦ -i の自己同型で、i ↦ QQbar の I の埋め込みで本物の複素共役であることを確かめる。
# 範囲: M_col = 1..5、j = 1..M_col。
# 帰属: 全て KG = QQ(i) の元（厳密計算。浮動小数点は使わない）。
load("../../_shared/pauli_sites_exact.sage")
load("_conjugate_transpose.sage")

def prod_left(Fs):
    """F_1F_2⋯F_r を左から掛ける（def_jordan_wigner_*_matrices の積の順）。積は mat_mult の成分の式。"""
    P = Fs[0]
    for F in Fs[1:]:
        P = body_product(P, F)
    return P


rep = Counter("check_number_operator_is_hermitian (1): Pauli 行列・クロネッカー積・Z_j・Y_j の共役転置（QQ(i) で厳密）")

# KG の複素共役
conjK = KG.hom([-i_K], KG)
embK = KG.hom([QQbar(I)], QQbar)
rep.eq(embK(conjK(i_K)), embK(i_K).conjugate(), "KG の i ↦ -i は本物の複素共役")
star = lambda A: body_star(A, conjK)
rep.eq(star(SY), SY.conjugate_transpose(), "body_star と Sage の conjugate_transpose（σ^y）")

# (σ^a)^* = σ^a
for a, S in PAULI.items():
    rep.eq(star(S), S, f"(σ^{a})^* = σ^{a}")
rep.eq(star(I2), I2, "I^* = I")
rep.neq(body_transpose(SY), SY, "σ^y の転置だけ（複素共役なし）は σ^y でない")

# (A_1⊠⋯⊠A_M)^* = A_1^*⊠⋯⊠A_M^*（一般の KG 成分の 2 次の行列で）
set_random_seed(20261105)
for M in range(1, 5):
    for trial in range(3):
        As = [matrix(KG, 2, 2, [KG.random_element(num_bound=5, den_bound=3) for _ in range(4)]) for _ in range(M)]
        lhs = star(kron(As))
        rhs = kron([star(A) for A in As])
        K = kron(As)
        Ks = [star(A) for A in As]
        # 証明の成分の鎖 5 行（全ての I, J ∈ 𝓘_M）。ν は def_kronecker の添字の全単射
        for Iw in index_set(M):
            for Jw in index_set(M):
                a_, b_ = nu(Iw) - 1, nu(Jw) - 1
                rep.chain([
                    ("((A_1⊠⋯⊠A_M)^*)_(ν(I),ν(J))", lhs[a_, b_]),
                    ("conj((A_1⊠⋯⊠A_M)_(ν(J),ν(I)))", conjK(K[b_, a_])),
                    ("conj(Π_k (A_k)_(j_k i_k))", conjK(prod(As[k][Jw[k] - 1, Iw[k] - 1] for k in range(M)))),
                    ("Π_k conj((A_k)_(j_k i_k))", prod(conjK(As[k][Jw[k] - 1, Iw[k] - 1]) for k in range(M))),
                    ("Π_k (A_k^*)_(i_k j_k)", prod(Ks[k][Iw[k] - 1, Jw[k] - 1] for k in range(M))),
                    ("(A_1^*⊠⋯⊠A_M^*)_(ν(I),ν(J))", rhs[a_, b_]),
                ], f"M={M} I={tuple(Iw)} J={tuple(Jw)}: クロネッカー積の共役転置の成分の鎖")
        rep.eq(lhs, rhs, f"M={M}: (A_1⊠⋯⊠A_M)^* = A_1^*⊠⋯⊠A_M^*")
        rep.eq(lhs, kron(As).conjugate_transpose(), f"M={M}: body_star と Sage の conjugate_transpose")
        # 否定コントロール: 成分を共役しない転置では成り立たない（一般の行列で）
        if M == 2 and trial == 0:
            rep.neq(body_transpose(kron(As)), rhs, f"M={M}: 転置だけでは A_1^*⊠⋯⊠A_M^* にならない")

for M in range(1, 6):
    n = 2**M
    sig = {(k, a): site(M, k, a) for k in range(1, M + 1) for a in 'xyz'}
    for (k, a), S in sig.items():
        # (σ_k^a)^* = (I⊠⋯⊠σ^a⊠⋯⊠I)^* = I^*⊠⋯⊠(σ^a)^*⊠⋯⊠I^* = I⊠⋯⊠σ^a⊠⋯⊠I = σ_k^a
        facs = site_factors(M, k, PAULI[a])
        rep.chain([
            ("(σ_k^a)^*", star(S)),
            ("(I⊠⋯⊠σ^a⊠⋯⊠I)^*", star(kron(facs))),
            ("I^*⊠⋯⊠(σ^a)^*⊠⋯⊠I^*", kron([star(F) for F in facs])),
            ("I⊠⋯⊠σ^a⊠⋯⊠I", kron(facs)),
            ("σ_k^a", S),
        ], f"M={M} k={k} a={a}")
    for j in range(1, M + 1):
        for b, name in (('z', 'Z'), ('y', 'Y')):
            X = jw(M, j, b)                        # def_jordan_wigner_Z_matrices / def_jordan_wigner_Y_matrices
            fac = [sig[(k, 'x')] for k in range(1, j)] + [sig[(j, b)]]   # σ_1^x, …, σ_{j-1}^x, σ_j^b
            lines = [
                (f"{name}_j^*", star(X)),
                ("(σ_1^x⋯σ_{j-1}^xσ_j^b)^*", star(prod_left(fac))),
                ("(σ_j^b)^*(σ_{j-1}^x)^*⋯(σ_1^x)^*", prod_left([star(F) for F in reversed(fac)])),
                ("σ_j^bσ_{j-1}^x⋯σ_1^x", prod_left(list(reversed(fac)))),
                ("σ_1^x⋯σ_{j-1}^xσ_j^b", prod_left(fac)),
                (f"{name}_j", X),
            ]
            rep.chain(lines, f"M={M} j={j} {name}_j の鎖")
            rep.eq(star(X), X.conjugate_transpose(), f"M={M} j={j}: body_star と Sage の conjugate_transpose（{name}_j）")
            if b == 'y':
                rep.neq(body_transpose(X), X, f"M={M} j={j}: Y_j の転置だけ（複素共役なし）は Y_j でない")
    # 否定コントロール: 同じサイトの可換でない因子では、(XW)^* を X^*W^* と書くと崩れる（W^*X^* の順が要る）
    X, W = sig[(1, 'x')], sig[(1, 'z')]
    rep.eq(star(body_product(X, W)), body_product(star(W), star(X)), f"M={M}: (σ_1^xσ_1^z)^* = (σ_1^z)^*(σ_1^x)^*")
    rep.neq(star(body_product(X, W)), body_product(star(X), star(W)), f"M={M}: (σ_1^xσ_1^z)^* ≠ (σ_1^x)^*(σ_1^z)^*")
    if M >= 2:
        # 否定コントロール: 「相異なるサイトの因子は可換」の行は、同じサイトに置くと崩れる
        rep.neq(body_product(sig[(1, 'z')], sig[(1, 'x')]), body_product(sig[(1, 'x')], sig[(1, 'z')]), f"M={M}: σ_1^zσ_1^x ≠ σ_1^xσ_1^z")
    print(f"  M={M}: 済（累計 等号 {rep.n_eq} 件）", flush=True)

rep.finish()
