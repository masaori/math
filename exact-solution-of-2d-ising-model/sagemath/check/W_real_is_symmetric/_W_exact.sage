# 対象ラベル: W_real_is_symmetric・W_real_is_positive_definite の共通の準備
# W := (BV_2)B を W_is_real_symmetric_positive_definite の検算と同じ厳密な経路で作る
# （K_1 := 2 log y、K_2 := log x と選ぶ。ℝ への脱出はこの選び方の一点だけ）。
# 複素行列としての W は QQbar の成分、W_ℝ := ϱ(W)（def_W_real）は AA の成分で持つ。
load("../W_is_real_symmetric_positive_definite/_prelude.sage")


def W_exact(M, x, y):
    """W = (BV_2)B を、√t・√(2s_2) を含む実の数体 F で作る。"""
    n = 2**M
    DQ = matrix(QQ, n, n, [QQ(z) for z in bond_sum(M).list()])
    F, rt, rs = real_field_for(x)
    V2 = V2_by_components(M, lambda m: QQ(x)**m, F)
    B = exp_by_spectral_projectors(DQ, lambda lam: y**lam, QQ).change_ring(F)
    return body_product(body_product(B, V2), B)


def iota(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ（AA → QQbar）。"""
    return QQbar(r)


def W_complex_and_real(M, x, y):
    """W ∈ Mat(2^M, ℂ)（QQbar）と W_ℝ := ϱ(W) ∈ Mat(2^M, ℝ)（AA）。"""
    WF = W_exact(M, x, y)
    n = WF.nrows()
    WC = matrix(QQbar, n, n, [QQbar(AA(z)) for z in WF.list()])
    assert all(z.imag() == 0 for z in WC.list())                       # def_matrix_with_real_entries
    WR = matrix(AA, n, n, [AA(z.real()) for z in WC.list()])          # def_real_matrix_of_real_entry_matrix の w_kl(W)
    for k in range(n):
        for l in range(n):
            assert iota(WR[k, l]) == WC[k, l]                          # ((W_ℝ)_kl)_ℂ = W_kl（def_W_real）
    return WC, WR
