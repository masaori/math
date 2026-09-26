# ---------------------------------------------------------
# SageMath: 証明の中間目標「1 因子の exp をサイト演算子の exp にする」「積にまとめる」
#   (σ_m^x)^p = I⊠…⊠(σ^x)^p⊠…⊠I                     （p = 0..4）
#   exp(K_2^* σ_m^x) = I⊠…⊠exp(K_2^* σ^x)⊠…⊠I
#   σ_m^x σ_{m'}^x = σ_{m'}^x σ_m^x
#   exp(K_2^* Σ_m σ_m^x) = Π_m exp(K_2^* σ_m^x) = exp(K_2^*σ^x)^{⊠M}
# 対象ラベル: second_transfer_matrix_pauli_form
# 帰属: K_2 = log x（x ∈ QQ, x > 1）と選ぶ。exp(K_2^* λ) = (√tanh K_2)^{-λ} ∈ AA。
#       行列の exp はスペクトル射影（_shared/row_configurations.sage の説明）で厳密に計算する。
#       等号はすべて AA（実代数的数、等号は決定可能）で判定する。
#       ℝ 脱出は K_2 の選び方の一点だけ（見かけだけの ℝ 脱出）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
ok_all = True
for M_col in range(1, 6):
    sx = [None] + [site_pauli('x', m, M_col) for m in range(1, M_col + 1)]
    ok = True
    for m in range(1, M_col + 1):
        for p in range(0, 5):
            ok = ok and (sx[m] ** p == kron_by_definition([SIGMA_X_2 ** p if j == m else ID_2 for j in range(1, M_col + 1)], ZZ))
        for mp in range(1, M_col + 1):
            ok = ok and (sx[m] * sx[mp] == sx[mp] * sx[m])
    for x in X_VALUES[:3]:
        f = exp_dual(x)
        E2 = exp_by_spectral_projectors(SIGMA_X_2, f, AA)
        prod_site = identity_matrix(AA, 2 ** M_col)
        for m in range(1, M_col + 1):
            Em = exp_by_spectral_projectors(sx[m], f, AA)
            ok = ok and (Em == kron_by_definition([E2 if j == m else ID_2 for j in range(1, M_col + 1)], AA))
            prod_site = prod_site * Em
        E_sum = exp_by_spectral_projectors(sigma_x_sum(M_col), f, AA)
        ok = ok and (E_sum == prod_site) and (prod_site == kron_by_definition([E2] * M_col, AA))
        print(f"  M_col={M_col}, exp(K_2)={x}: 冪・サイトごとの exp・可換性・積へのまとめ -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
