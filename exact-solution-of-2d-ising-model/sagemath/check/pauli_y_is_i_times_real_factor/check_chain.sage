# 対象ラベル: pauli_y_is_i_times_real_factor
# 人手の鎖 σ^y = (0 -i; i 0) = (0 (-1)·i; i 0) = (0 i·(-1); i 0) = (0 i·(-1); i·1 0) = (i·0 i·(-1); i·1 i·0)
#   = i (0 -1; 1 0) = i R^y を 1 行ずつ QQ(i) の厳密計算で確かめる。
# 行列の成分は各行で人手の書いた式どおりに組む（積は QQ(i) の積で、行ごとに異なる式から組んだ値を比べる）。
# スカラー倍は def_matrix_scalar_multiple の成分の式 (aA)_{pq} := a A_{pq} で組む。
load("../../_shared/pauli_sites_exact.sage")
i = i_K
def scalar_def(a, A):                    # def_matrix_scalar_multiple
    return matrix(KG, A.nrows(), A.ncols(), lambda p, q: a * A[p, q])
RY = matrix(KG, [[0, -1], [1, 0]])       # def_real_factor_of_pauli_y
lines = [
    SY,
    matrix(KG, [[0, -i], [i, 0]]),                      # def_pauli_matrices の σ^y
    matrix(KG, [[0, (-1) * i], [i, 0]]),                # multiply_by_minus_one
    matrix(KG, [[0, i * (-1)], [i, 0]]),                # 積の可換律
    matrix(KG, [[0, i * (-1)], [i * 1, 0]]),            # 積の単位元
    matrix(KG, [[i * 0, i * (-1)], [i * 1, i * 0]]),    # complex_times_zero_is_zero を (1,1)・(2,2) へ
    scalar_def(i, matrix(KG, [[0, -1], [1, 0]])),       # def_matrix_scalar_multiple
    scalar_def(i, RY),                                  # def_real_factor_of_pauli_y
]
check_chain(lines, "pauli_y_is_i_times_real_factor")
# 否定コントロール: R^y の符号を逆にした (0 1; -1 0) では i 倍が σ^y にならない
assert scalar_def(i, matrix(KG, [[0, 1], [-1, 0]])) != SY
print(f"  {len(lines) - 1} 段が成り立つ（QQ(i) の厳密計算）")
print("  否定コントロール 1 件: 符号を逆にした行列の i 倍は σ^y にならない")
print("RESULT: PASS")
