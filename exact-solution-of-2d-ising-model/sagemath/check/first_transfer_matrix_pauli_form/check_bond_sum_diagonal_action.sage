# ---------------------------------------------------------
# SageMath: 証明の「D の対角成分」の中間目標
#   D = Σ_{m=1}^{M-1} σ_m^z σ_{m+1}^z + σ_M^z σ_1^z                （周期端を分ける）
#   D f_ι(μ) = Σ_{m<M} μ(m)μ(m+1) f + μ(M)μ(1) f = d(μ) f_ι(μ)      （各行）
#   D は基底 (f_I) に関して対角で、第 ord(μ) 対角成分は d(μ)
# 対象ラベル: first_transfer_matrix_pauli_form
# 対象: structured-latex/content/004_transfer_matrix.ts
#       ブロック transfer_matrix_claim_first_transfer_matrix_pauli_form の proof 前半
# 帰属: σ^z, D, f はすべて ZZ 成分。厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
ok_all = True
for M_col in range(1, 8):
    sz = [None] + [site_pauli('z', k, M_col) for k in range(1, M_col + 1)]
    D = bond_sum_D(M_col)
    split = sum([sz[m] * sz[m + 1] for m in range(1, M_col)], matrix(ZZ, 2 ** M_col, 2 ** M_col, 0)) + sz[M_col] * sz[1]
    ok = (D == split)
    for mu in row_configurations(M_col):
        f = basis_vector_of(mu)
        lines = [D * f,
                 split * f,
                 sum([sz[m] * sz[m + 1] * f for m in range(1, M_col)], vector(ZZ, [0] * 2 ** M_col)) + sz[M_col] * sz[1] * f,
                 sum([mu[m - 1] * mu[m] * f for m in range(1, M_col)], vector(ZZ, [0] * 2 ** M_col)) + mu[M_col - 1] * mu[0] * f,
                 (sum(mu[m - 1] * mu[m] for m in range(1, M_col)) + mu[M_col - 1] * mu[0]) * f,
                 bond_count(mu) * f]
        ok = ok and all(v == lines[0] for v in lines)
        ok = ok and (D[ord_number(mu) - 1, ord_number(mu) - 1] == bond_count(mu))
    ok = ok and D.is_diagonal()
    print(f"  M_col={M_col}: 周期端の分割、D f_ι(μ) の 5 段、D が対角で第 ord(μ) 成分 = d(μ) -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
