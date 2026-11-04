# 対象ラベル: check_number_operators_commute の検算が共有する、証明の鎖の組み立て。
# 証明の記号: D_μ := ψ̌_μ^†、P_μ := ψ̌_{M_col+1-μ}、n_μ := D_μP_μ（def_check_number_operator の ň_μ）。μ ≠ ν。
# 各鎖は (名前, 値, 仮定の行か) の並びで、隣り合う行の値が等しいことが証明の一つの等号に当たる。
# 「仮定の行」は、その行への等号が反交換関係（anticommutator_of_check_psi）か、それから出した Step 1・(1) を引く行である。
# 由来: 2026-11-04 まで 050_claim_even_sector_eigenvalues/ の check_29（Step 1 の鎖）と check_23（Step 2・Step 3 の鎖）が
#       それぞれのファイルの中で定めていたもの。中身は変えていない（符号反転は両者で同じ成分の式 (-1)·a_{rc} = -a_{rc}）。

def kron_tensor(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def anticomm(X, W):
    # def_matrix_anticommutator
    return X * W + W * X


def neg(A):
    # def_matrix_negation（成分ごとの符号反転）
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: -A[r, c])


def kronecker_delta(i, j):
    # def_kronecker_delta
    return 1 if i == j else 0


# Step 1 の 4 式
def chain_first(D_mu, D_nu, Id):
    return [("[D_mu,D_nu]_+", anticomm(D_mu, D_nu), False), ("O", 0 * Id, True)]


def chain_second(D_mu, P_nu, Id, M, mu, nu):
    d = kronecker_delta(M + 1 - nu, M + 1 - mu)
    return [
        ("[D_mu,P_nu]_+", anticomm(D_mu, P_nu), False),
        ("delta I", d * Id, True),                       # 第 2 式（ν → M+1-ν）
        ("0_C I", 0 * Id, False),                        # 直前の δ の計算（δ = 0 を代入。d == 0 を別に確かめる）
        ("O", Id.parent().zero(), False),                # zero_scalar_multiple_is_zero_matrix
    ]


def chain_third(P_mu, D_nu, Id, M, mu, nu):
    d1 = kronecker_delta(M + 1 - mu, M + 1 - nu)
    d2 = kronecker_delta(M + 1 - nu, M + 1 - mu)
    return [
        ("[P_mu,D_nu]_+", anticomm(P_mu, D_nu), False),
        ("P_mu D_nu + D_nu P_mu", P_mu * D_nu + D_nu * P_mu, False),   # def_matrix_anticommutator
        ("D_nu P_mu + P_mu D_nu", D_nu * P_mu + P_mu * D_nu, False),   # matrix_sum_is_commutative
        ("[D_nu,P_mu]_+", anticomm(D_nu, P_mu), False),                # def_matrix_anticommutator を右辺から左辺へ
        ("delta1 I", d1 * Id, True),                                   # 第 2 式（μ → ν, ν → M+1-μ）
        ("delta2 I", d2 * Id, False),                                  # def_kronecker_delta の対称性
        ("0_C I", 0 * Id, False),                                      # 直前の δ の計算
        ("O", Id.parent().zero(), False),                              # zero_scalar_multiple_is_zero_matrix
    ]


def chain_fourth(P_mu, P_nu, Id):
    return [("[P_mu,P_nu]_+", anticomm(P_mu, P_nu), False), ("O", 0 * Id, True)]


def chain_conclusion(X, W, Id):
    """Step 1 の結び: XW + WX = [X, W]_+ = O。"""
    return [
        ("XW+WX", X * W + W * X, False),
        ("[X,W]_+", anticomm(X, W), False),       # def_matrix_anticommutator を右辺から左辺へ
        ("O", 0 * Id, True),                      # 上の 4 式のうち [X, W]_+ を左辺に持つ式
    ]


def commute_step2_chain(A, Dn, Pn):
    """Step 2 の 10 個の等号: X ň_ν = … = ň_ν X（A が証明の X）。"""
    nn = Dn * Pn
    return [
        ("A n_ν", A * nn, False),
        ("A(D_νP_ν)", A * (Dn * Pn), False),
        ("(AD_ν)P_ν", (A * Dn) * Pn, False),
        ("(-(D_νA))P_ν", neg(Dn * A) * Pn, True),          # Step 1
        ("-((D_νA)P_ν)", neg((Dn * A) * Pn), False),
        ("-(D_ν(AP_ν))", neg(Dn * (A * Pn)), False),
        ("-(D_ν(-(P_νA)))", neg(Dn * neg(Pn * A)), True),  # Step 1
        ("-(-(D_ν(P_νA)))", neg(neg(Dn * (Pn * A))), False),
        ("D_ν(P_νA)", Dn * (Pn * A), False),
        ("(D_νP_ν)A", (Dn * Pn) * A, False),
        ("n_ν A", nn * A, False),
    ]


def commute_step3_chain(Dm, Pm, Dn, Pn):
    """Step 3 の 7 個の等号: ň_μ ň_ν = … = ň_ν ň_μ。"""
    nm = Dm * Pm
    nn = Dn * Pn
    return [
        ("n_μ n_ν", nm * nn, False),
        ("(D_μP_μ)n_ν", (Dm * Pm) * nn, False),
        ("D_μ(P_μ n_ν)", Dm * (Pm * nn), False),
        ("D_μ(n_ν P_μ)", Dm * (nn * Pm), True),            # (1)
        ("(D_μ n_ν)P_μ", (Dm * nn) * Pm, False),
        ("(n_ν D_μ)P_μ", (nn * Dm) * Pm, True),            # (1)
        ("n_ν(D_μP_μ)", nn * (Dm * Pm), False),
        ("n_ν n_μ", nn * nm, False),
    ]


chain_count = 0


def check_chain_lines(lines, label, expect_all=True):
    """隣り合う行の等号を確かめる。expect_all が偽なら仮定の行への等号は飛ばす（否定コントロール用）。"""
    global chain_count
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, a, b)
            chain_count += 1


def jordan_wigner_model(M):
    """D_μ := c_μ^T、P_μ := c_μ（c_μ は Jordan–Wigner のフェルミ演算子。QQ の 2^M 次の行列）。"""
    sz = matrix(QQ, [[1, 0], [0, -1]])
    lower = matrix(QQ, [[0, 1], [0, 0]])
    id2 = identity_matrix(QQ, 2)
    Id = kron_tensor([id2] * M)
    c = [kron_tensor([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    return Id, [ck.transpose() for ck in c], c
