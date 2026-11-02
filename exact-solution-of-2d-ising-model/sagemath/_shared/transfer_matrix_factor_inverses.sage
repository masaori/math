# 可逆性の三つの主張（V1_plus_half_invertible・V2_invertible・V_plus_factors_invertible）の検算で共有する準備。
# pauli_sites_exact.sage（Z_m・Y_m・H_1^(+)・ボールの exp）と row_configurations.sage（V_2 の成分の定義と
# 整数固有値の行列の exp のスペクトル射影による厳密計算）を読み込んで使う。
#
# V_2 を厳密に扱うため K_2 := log x（x ∈ QQ, x > 1）と選ぶ。このとき
#   exp(K_2 n) = x^n ∈ QQ、
#   s_2 = sinh 2K_2 = (x^2 - x^{-2})/2 ∈ QQ（def_cosh_sinh の (exp(z) - exp(-z))/2）、
#   tanh K_2 = sinh K_2 / cosh K_2 = (x - x^{-1})/(x + x^{-1}) =: t ∈ QQ（def_positive_coupling_tanh）、
#   exp(-2K_2^*) = exp(log t) = t（def_second_dual_coupling_constant の K_2^* = -(1/2)log t）、
#   a = (2s_2)^{M/2} = (√(2s_2))^M ∈ AA（def_second_transfer_matrix_prefactor）
# であり、ℝ への脱出は「K_2 の選び方」の一点に閉じる。iH_2 は整数の固有値をもつ実対称行列なので、
# exp(±K_2^* · iH_2) は固有値 λ ごとに exp(±K_2^* λ) = (√t)^{∓λ} ∈ AA を射影に掛けて厳密に作る。
load("../../_shared/pauli_sites_exact.sage")
load("../../_shared/row_configurations.sage")


def H2(M):
    """def_H2: H_2 := Σ_{m=1}^{M} Z_m Y_m（有限和は左から、積は mat_mult の成分の式）。"""
    return body_finite_sum([body_product(jw(M, m, 'z'), jw(M, m, 'y')) for m in range(1, M + 1)])


def V1_half_exponent(M, K1):
    """def_V1_plus_square_root の指数の肩 X := (i/2)K_1 H_1^(+)（KG で厳密）。"""
    return body_scalar((i_K / 2) * K1, H1_plus(M))


def second_coupling_exact(x):
    """K_2 = log x のときの s_2・t = tanh K_2 を QQ で返す。"""
    x = QQ(x)
    assert x > 1
    s2 = (x**2 - x**(-2)) / 2
    t = (x - x**(-1)) / (x + x**(-1))
    return s2, t


def prefactor_exact(M, x):
    """a = (2s_2)^{M/2} := (√(2s_2))^M ∈ AA（def_second_transfer_matrix_prefactor）。"""
    s2, _ = second_coupling_exact(x)
    return AA(2 * s2).sqrt() ** M


def iH2_integer_matrix(M):
    """S := iH_2。KG で作り、虚部が 0 で成分が整数であることを確かめてから QQ の行列にする。"""
    S = body_scalar(i_K, H2(M))
    assert all(z.imag() == 0 and QQ(z.real()) in ZZ for z in S.list())
    return matrix(QQ, S.nrows(), S.ncols(), [QQ(z.real()) for z in S.list()])


def exp_iK2star_H2_exact(M, x, sign):
    """exp(sign · iK_2^* H_2) = exp(sign · K_2^* S)（S = iH_2）を AA で厳密に返す。
    固有値 λ の射影に exp(sign K_2^* λ) = (√t)^{-sign λ} を掛ける。"""
    _, t = second_coupling_exact(x)
    rt = AA(t).sqrt()
    S = iH2_integer_matrix(M)
    return exp_by_spectral_projectors(S, lambda lam: rt ** (-sign * lam), AA)


def V2_components_exact(M, x):
    """def_transfer_matrix の V_2 を成分 exp(K_2 n) = x^n で作る（AA）。"""
    return V2_by_components(M, lambda n: QQ(x) ** n, AA)


RB_ = RealBallField(256)


def AA_to_CB(A):
    """AA の行列を 256 ビットの複素数のボールの行列にする（丸めは半径に入る）。"""
    return matrix(CB, A.nrows(), A.ncols(), lambda r, c: CB(RB_(A[r, c])))


def identity_CB(n):
    return identity_matrix(CB, n)


# (V_1^(+))^{1/2} = exp(X)（X := (i/2)(K_1)_C H_1^(+)）を厳密に扱うため K_1 := 2 log y（y ∈ QQ, y > 1）と選ぶ。
# X = (log y)·(iH_1^(+)) で、iH_1^(+) は整数の固有値をもつ整数行列なので、exp(±X) は固有値 λ の射影に y^{±λ} を掛けて
# QQ で厳密に作れる（ℝ への脱出は K_1 の選び方の一点）。
def iH1_plus_integer_matrix(M):
    """S_1 := iH_1^(+)。KG で作り、虚部が 0 で成分が整数であることを確かめてから QQ の行列にする。"""
    S = body_scalar(i_K, H1_plus(M))
    assert all(z.imag() == 0 and QQ(z.real()) in ZZ for z in S.list())
    return matrix(QQ, S.nrows(), S.ncols(), [QQ(z.real()) for z in S.list()])


def exp_V1_half_exact(M, y, sign):
    """exp(sign·X)（K_1 = 2 log y）= Σ_λ y^{sign λ} P_λ を QQ で厳密に返す。"""
    y = QQ(y)
    assert y > 1
    return exp_by_spectral_projectors(iH1_plus_integer_matrix(M), lambda lam: y ** (sign * lam), QQ)
