# ---------------------------------------------------------
# SageMath: 証明の中間目標「結論」と主張そのもの
#   V_2 = A^{⊠M} = ((2s_2)^{1/2} exp(K_2^*σ^x))^{⊠M} = ((2s_2)^{1/2})^M exp(K_2^*σ^x)^{⊠M}
#       = (2 sinh 2K_2)^{M/2} exp(K_2^*σ^x)^{⊠M} = (2 sinh 2K_2)^{M/2} exp(K_2^* Σ_m σ_m^x)
#   ここで V_2 は <def_transfer_matrix> の成分定義（ord で指す）そのもの。
#   併せて <two_by_two_transfer_identity> A = (2s_2)^{1/2} exp(K_2^* σ^x) と、
#   <def_second_transfer_matrix_prefactor> の前係数が正であること、K_2^* > 0 を確かめる。
#   否定コントロール: exp(K_2^*λ) を exp(K_2λ) に取り違えた右辺、前係数の冪を M_col - 1 にした右辺は V_2 と一致しない。
# 対象ラベル: second_transfer_matrix_pauli_form
# 帰属: K_2 = log x（x ∈ QQ, x > 1）。V_2 の成分は x^n ∈ QQ、前係数と exp(K_2^*λ) は AA。
#       等号はすべて AA で判定する。ℝ 脱出は K_2 の選び方の一点だけ。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
ok_all = True
for x in X_VALUES:
    t = tanh_K2(x)
    ok = (0 < t < 1)                                   # K_2^* = -1/2 log t > 0
    f = exp_dual(x)
    E2 = exp_by_spectral_projectors(SIGMA_X_2, f, AA)
    c = AA(two_sinh_2K2(x)).sqrt()
    A = matrix(AA, [[x, x ** -1], [x ** -1, x]])
    ok = ok and (c > 0) and (A == c * E2)
    for M_col in range(1, 6):
        V2 = V2_by_components(M_col, lambda n: x ** n, AA)
        pref = prefactor(x, M_col)
        chain = [V2,
                 kron_by_definition([A] * M_col, AA),
                 kron_by_definition([c * E2] * M_col, AA),
                 (c ** M_col) * kron_by_definition([E2] * M_col, AA),
                 pref * kron_by_definition([E2] * M_col, AA),
                 pref * exp_by_spectral_projectors(sigma_x_sum(M_col), f, AA)]
        okM = (pref > 0) and all(Mx == chain[0] for Mx in chain)
        # 否定コントロール: K_2^* の代わりに K_2 を使う、前係数の冪を M_col - 1 にする、はどちらも偽
        wrong_dual = pref * exp_by_spectral_projectors(sigma_x_sum(M_col), lambda lam: x ** lam, AA)
        wrong_pref = prefactor(x, M_col - 1) * exp_by_spectral_projectors(sigma_x_sum(M_col), f, AA)
        okM = okM and (V2 != wrong_dual) and (V2 != wrong_pref)
        print(f"  exp(K_2)={x}, M_col={M_col}: V_2（成分定義） = (2 sinh 2K_2)^(M/2) exp(K_2^* Σσ^x) と結論の 5 段 -> {'PASS' if okM else 'FAIL'}")
        ok = ok and okM
    print(f"  exp(K_2)={x}: tanh K_2={t}（0<tanh K_2<1）、2×2 の恒等式 -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
