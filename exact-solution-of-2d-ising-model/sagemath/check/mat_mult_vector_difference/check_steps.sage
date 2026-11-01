# 対象ラベル: mat_mult_vector_difference
# A(u - w) = Au - Aw の証明の 6 行を、A, u, w の成分を QQ 上の不定元に置いて m, n = 1..4 で確かめる。
# 積は mat_mult の成分の式（_shared/matrix_operations_by_definition.sage の body_product）で、差は
# def_matrix_difference の成分の式（下の body_difference）で組む。比べる側には Sage の行列積・ベクトルの差を使う。
# 浮動小数点は使わない。不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def body_difference(A, B):
    """def_matrix_difference の (A - B)_{ik} := A_{ik} - B_{ik}。"""
    assert A.nrows() == B.nrows() and A.ncols() == B.ncols()
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, k: A[i, k] - B[i, k])


for m in range(1, 5):
    for n in range(1, 5):
        Ring, _, (A, u, w) = generic_ring([("A", m, n), ("u", n, 1), ("w", n, 1)])
        umw = body_difference(u, w)
        Au, Aw = body_product(A, u), body_product(A, w)
        lhs = body_product(A, umw)
        rhs = body_difference(Au, Aw)
        for i in range(m):
            lines = [
                lhs[i, 0],                                                        # (A(u - w))_i
                sum(A[i, j] * umw[j, 0] for j in range(n)),                       # Σ A_ij (u - w)_j      (mat_mult)
                sum(A[i, j] * (u[j, 0] - w[j, 0]) for j in range(n)),             # Σ A_ij (u_j - w_j)    (def_matrix_difference)
                sum(A[i, j] * u[j, 0] - A[i, j] * w[j, 0] for j in range(n)),     # Σ (A_ij u_j - A_ij w_j) (分配則)
                sum(A[i, j] * u[j, 0] for j in range(n)) - sum(A[i, j] * w[j, 0] for j in range(n)),  # 有限和の差
                Au[i, 0] - Aw[i, 0],                                              # (Au)_i - (Aw)_i       (mat_mult)
                rhs[i, 0],                                                        # (Au - Aw)_i           (def_matrix_difference)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (m, n, i, t)
        # 主張の両辺を Sage の行列積・差と比べる（独立な経路）
        assert lhs == A * (u - w) and rhs == A * u - A * w and lhs == rhs
        # 否定コントロール: 和 u + w を差の代わりに使うと一致しない
        assert body_product(A, body_sum(u, w)) != rhs
    print(f"m = {m}, n = 1..4: 鎖の 6 個の等号と主張を不定元で確かめた。否定コントロール（u + w）は一致しない")

print("RESULT: PASS")
