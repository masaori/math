# ---------------------------------------------------------
# SageMath: ord(μ) = ν(ι(μ))（主張の式変形を一行ずつ）
#   各 m で i_m - 1 = (1-μ(m))/2
#   ν(ι(μ)) = 1 + Σ (i_m-1) 2^{M-m} = 1 + Σ (1-μ(m))/2 · 2^{M-m} = ord(μ)
# 対象ラベル: config_numbering_equals_kronecker_numbering
# 対象: structured-latex/content/004_transfer_matrix.ts
#       ブロック transfer_matrix_claim_config_numbering_equals_kronecker_numbering
# 帰属: ZZ / QQ（(1-μ(m))/2 を QQ で計算）。全 μ について厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

ok_all = True
for M_col in range(1, 13):
    ok = True
    for mu in row_configurations(M_col):
        I = iota(mu)
        ok = ok and all(QQ(I[m - 1]) - 1 == (QQ(1) - QQ(mu[m - 1])) / 2 for m in range(1, M_col + 1))
        chain = [nu_number(I),
                 1 + sum((QQ(I[m - 1]) - 1) * 2 ** (M_col - m) for m in range(1, M_col + 1)),
                 1 + sum((QQ(1) - QQ(mu[m - 1])) / 2 * 2 ** (M_col - m) for m in range(1, M_col + 1)),
                 ord_number(mu)]
        ok = ok and all(x == chain[0] for x in chain)
    print(f"  M_col={M_col}: 全 {2**M_col} 個の μ で i_m-1=(1-μ(m))/2 と ν(ι(μ)) = ord(μ) -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
