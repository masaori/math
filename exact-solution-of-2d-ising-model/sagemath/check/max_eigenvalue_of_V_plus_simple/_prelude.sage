# 対象ラベル: max_eigenvalue_of_V_plus_simple
# check_claim_with_actual_V_plus.sage の共通の準備。Z_m・Y_m・H_1^(+)・V_2 の成分の定義と、整数固有値の行列の exp をスペクトル射影で
# 厳密に作る関数は共有の準備 transfer_matrix_factor_inverses.sage から読み込む（複製しない）。
load("../../_shared/transfer_matrix_factor_inverses.sage")


def to_qqbar_matrix(A):
    return matrix(QQbar, A.nrows(), A.ncols(), [QQbar(z) for z in A.list()])


def body_column(F, entries):
    """数ベクトルを mat_mult の約束どおり n 行 1 列の行列として置く。"""
    return matrix(F, len(entries), 1, list(entries))


def fsum_left(xs):
    """def_finite_sum_of_real_numbers・def_sum_over_binary_words の和を左から足す。"""
    s = xs[0]
    for t in xs[1:]:
        s = s + t
    return s


def gamma_exp_independent(x, y, theta_over_pi):
    """exp(γ(θ)) を結合定数と角から直接 AA で作る（_number_operators.sage の g1_AA とは独立な経路）。
    K_1 = 2 log y、K_2 = log x。c_1 = cosh 2K_1 = (y^4 + y^{-4})/2、s_1 = sinh 2K_1 = (y^4 − y^{-4})/2（def_cosh_sinh）。
    t := tanh K_2 = exp(−2K_2^*)（def_second_dual_coupling_constant）なので c_2^* = (t^{-1} + t)/2、s_2^* = (t^{-1} − t)/2。
    γ_1(θ) = c_1c_2^* − s_1s_2^* cos θ（def_gamma1_gamma2_of_theta）、cos θ は 1 の冪根 ζ = e^{iθ} の (ζ + ζ^{-1})/2（θ/π ∈ QQ）。
    exp(γ(θ)) = γ_1 + √(γ_1^2 − 1)（def_gamma_theta・def_arccosh の実対数の中身）。"""
    x, y = QQ(x), QQ(y)
    c1 = (y**4 + y**(-4)) / 2
    s1 = (y**4 - y**(-4)) / 2
    _, t = second_coupling_exact(x)
    c2s = (1 / t + t) / 2
    s2s = (1 / t - t) / 2
    q = QQ(theta_over_pi)
    den = q.denominator()
    z = QQbar.zeta(2 * den) ** (q.numerator())      # e^{iπq}
    cos = AA(((z + 1 / z) / 2).real())
    g1 = c1 * c2s - s1 * s2s * cos
    assert g1 >= 1
    return g1 + (g1**2 - 1).sqrt()
