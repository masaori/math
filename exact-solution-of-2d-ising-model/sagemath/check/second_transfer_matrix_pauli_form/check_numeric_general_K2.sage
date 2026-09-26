# ---------------------------------------------------------
# SageMath: 主張 V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^* Σ_m σ_m^x) を一般の K_2 で（数値）
#   右辺の行列 exp は CDF 行列の exp（Sage の Matrix_double_dense.exp）で、級数定義の値の近似として使う。
#   左辺は成分定義を ord で書き込んだもの。
# 対象ラベル: second_transfer_matrix_pauli_form
# 帰属: K_2 ∈ ℝ_{>0} を一般に取るので exp・log・sinh・tanh の値は ℝ（指数評価による ℝ 脱出）。
#   許容誤差: 成分の最大絶対値で正規化した相対誤差 1e-12。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
TOL = 1e-12
ok_all = True
for M_col in range(1, 7):
    S = matrix(CDF, sigma_x_sum(M_col))
    for K2 in [RDF(0.05), RDF(0.3), RDF(0.4406868), RDF(0.8), RDF(1.1)]:
        K2s = -log(tanh(K2)) / 2
        V2 = V2_by_components(M_col, lambda n: exp(K2 * n), CDF)
        rhs = CDF(sqrt(2 * sinh(2 * K2)) ** M_col) * (K2s * S).exp()
        rel = max(abs(z) for z in (V2 - rhs).list()) / max(abs(z) for z in V2.list())
        ok = rel <= TOL
        print(f"  M_col={M_col}, K_2={K2}: 相対誤差 {rel:.2e} -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok_all and ok
exact_result(ok_all)
