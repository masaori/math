# 対象ラベル: constant_c_value_even_sector
# 共通の準備。Z_m・Y_m・H_1^(+)・H_2・V_2 の成分の定義と、整数固有値の行列の exp をスペクトル射影で厳密に作る関数は
# 共有の準備 transfer_matrix_factor_inverses.sage から読み込む（複製しない）。
# K_1 := 2 log y、K_2 := log x（x, y ∈ QQ_{>1}）と選ぶ。このとき
#   H = (1/2)_C S_1 = (log y)·iH_1^(+)、S_1 = (log y)·(2 iH_1^(+))、S_2 = K_2^*·iH_2、exp(K_2^* λ) = (√t)^{-λ}（t = tanh K_2）
# で、iH_1^(+)・iH_2 は整数の固有値をもつ実対称な整数行列なので、exp(±H)・exp(±S_1)・exp(±S_2) は射影に y^λ・(√t)^{-λ} を掛けて
# QQ・AA で厳密に作れる。ℝ への脱出は K_1・K_2 の選び方の一点だけである。
load("../../_shared/transfer_matrix_factor_inverses.sage")


def trace_body(A):
    """def_trace の tr(A) := Σ_k A_kk（左から足す）。"""
    s = A.base_ring()(0)
    for k in range(A.nrows()):
        s = s + A[k, k]
    return s


def exp_of_log_multiple(N, base, R):
    """exp((log base)·N) = Σ_λ base^λ P_λ（N は整数固有値の対角化可能な QQ の行列）。"""
    return exp_by_spectral_projectors(N, lambda lam: base ** lam, R)


def sign_flip_U(M):
    """sign_flip_conjugation の U := EF（E := E_1⊠⋯⊠E_M、E_m = σ^x（m 奇数）・I（m 偶数）、F := σ^z⊠⋯⊠σ^z）。
    クロネッカー積は def_kronecker の成分の式、積は mat_mult の成分の式。"""
    Em = [SX if m % 2 == 1 else I2 for m in range(1, M + 1)]
    E = kron_def(Em)
    F = kron_def([SZ] * M)
    return body_product(E, F)


def T_body(B, A, Binv):
    """mat_conj の T_B(A) := (BA)B^{-1}。"""
    return body_product(body_product(B, A), Binv)


def to_qqbar_matrix(A):
    return matrix(QQbar, A.nrows(), A.ncols(), [QQbar(z) for z in A.list()])
