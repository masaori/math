# ---------------------------------------------------------
# SageMath: 主張 Z(K_1,K_2) = tr((V_1V_2)^{N_row}) を厳密に
#   x_1 := exp(K_1), x_2 := exp(K_2) を不定元とする Laurent 多項式環 ZZ[x_1^{±1}, x_2^{±1}] で、
#   左辺（全配位の和）と右辺（成分を ord で指した V_1, V_2 のトレース）を多項式として比べる。
#   exp(K n) = exp(K)^n（n ∈ ZZ）なので、多項式としての一致は任意の K_1, K_2 ∈ ℝ_{>0} での一致と同値。
#   否定コントロール: N_row ≠ M_col のとき x_1 と x_2 を入れ替えた転送行列のトレースは Z と一致しない。
# 対象ラベル: partition_function_via_transfer_matrix
# 対象: structured-latex/content/001_partition_function_2d_ising.ts
#       ブロック partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix
# 帰属: ZZ 係数の Laurent 多項式。ℝ 脱出なし。
# ---------------------------------------------------------
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))
L = LaurentPolynomialRing(ZZ, 'x1,x2')
x1, x2 = L.gens()


def Z_exact(N_row, M_col):
    tot = L(0)
    for bits in itertools.product([1, -1], repeat=N_row * M_col):
        s = lambda i, j: bits[((i - 1) % N_row) * M_col + ((j - 1) % M_col)]   # 周期的な延長
        e1 = sum(s(i, j) * s(i, j + 1) for i in range(1, N_row + 1) for j in range(1, M_col + 1))
        e2 = sum(s(i, j) * s(i + 1, j) for i in range(1, N_row + 1) for j in range(1, M_col + 1))
        tot += x1 ** e1 * x2 ** e2
    return tot


ok_all = True
cases = [(1,1),(1,3),(3,1),(2,2),(3,2),(2,3),(4,2),(2,4),(3,3),(4,3),(3,4),(2,5),(5,2),(2,6),(6,2)]
for (N_row, M_col) in cases:
    Z = Z_exact(N_row, M_col)
    V1 = V1_by_components(M_col, lambda n: x1 ** n, L)
    V2 = V2_by_components(M_col, lambda n: x2 ** n, L)
    tr = ((V1 * V2) ** N_row).trace()
    ok = (tr == Z) and (Z(1, 1) == 2 ** (N_row * M_col))
    msg = ""
    if N_row != M_col:
        W1 = V1_by_components(M_col, lambda n: x2 ** n, L)
        W2 = V2_by_components(M_col, lambda n: x1 ** n, L)
        wrong = ((W1 * W2) ** N_row).trace()
        ok = ok and (wrong != Z)
        msg = "、K_1 と K_2 の入れ替えは不一致"
    print(f"  N_row={N_row}, M_col={M_col}: Z = tr((V_1V_2)^N_row) が Laurent 多項式として一致（項数 {len(Z.monomials())}）{msg} -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
