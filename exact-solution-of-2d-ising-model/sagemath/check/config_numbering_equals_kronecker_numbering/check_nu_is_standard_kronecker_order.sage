# ---------------------------------------------------------
# SageMath: 検証側の土台の確認（補助）
#   (a) <def_kronecker> の成分定義で作った ⊠（kron_by_definition）が、
#       Sage の tensor_product（先頭因子が最上位の標準的なクロネッカー積）と一致する。
#   (b) f_{ι(μ)} = e_{i_1} ⊠ … ⊠ e_{i_M} は第 ord(μ) 成分だけが 1 の標準基底ベクトルである。
#       すなわち ord で成分を指した行列と、クロネッカー積で作った行列が同じ番号で並ぶ。
# 対象ラベル: config_numbering_equals_kronecker_numbering
# 帰属: ZZ。厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

set_random_seed(20260926)
ok_all = True
for M_col in range(1, 6):
    ok = True
    for trial in range(5):
        mats = [random_matrix(ZZ, 2, 2, x=-9, y=10) for _ in range(M_col)]
        tp = matrix(ZZ, [[1]])
        for A in mats:
            tp = tp.tensor_product(A)
        ok = ok and (kron_by_definition(mats, ZZ) == tp)
    for mu in row_configurations(M_col):
        f = basis_vector_of(mu)
        std = vector(ZZ, [1 if k == ord_number(mu) else 0 for k in range(1, 2 ** M_col + 1)])
        ok = ok and (f == std)
    print(f"  M_col={M_col}: ⊠ の成分定義 = tensor_product、f_ι(μ) = 第 ord(μ) 標準基底 -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
