# ---------------------------------------------------------
# SageMath: 主張 V_1 = exp(K_1 Σ_m σ_m^z σ_{m+1}^z) を一般の K_1 で（数値）
#   右辺は CDF 行列の exp（Sage の Matrix_double_dense.exp）で計算し、級数定義の値の近似として使う。
#   左辺は成分定義を ord で書き込んだもの。
# 対象ラベル: first_transfer_matrix_pauli_form
# 帰属: K_1 ∈ ℝ_{>0} を一般に取るので exp の値は ℝ（指数評価による ℝ 脱出）。
#   許容誤差: 成分の最大絶対値で正規化した相対誤差 1e-12。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
TOL = 1e-12
ok_all = True
for M_col in range(1, 7):
    D = matrix(CDF, bond_sum_D(M_col))
    for K1 in [RDF(0.05), RDF(0.4), RDF(0.4406868), RDF(0.7), RDF(1.3)]:
        V1 = V1_by_components(M_col, lambda n: exp(K1 * n), CDF)
        E = (K1 * D).exp()
        rel = max(abs(z) for z in (V1 - E).list()) / max(abs(z) for z in V1.list())
        ok = rel <= TOL
        print(f"  M_col={M_col}, K_1={K1}: 相対誤差 {rel:.2e} -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok_all and ok
exact_result(ok_all)
