# 対象ラベル: Z_equals_trace_of_W
# 本文の行列そのもので、準備 1 の BB = V_1 と、主張 tr((V_1V_2)^n) = tr(W^n)（n = 1..4）、
# および Z(K_1,K_2) = tr(W^{N_row}) を確かめる。q := exp(K_1/2)、r := exp(K_2) を QQ(q,r) の不定元に置く。
# Z は def_partition_function_2d_ising を全配位の和として直接計算する（転送行列を経由しない）:
#   Z = Σ_s Π_{i,j} exp(K_1 s(i,j)s(i,j+1)) exp(K_2 s(i,j)s(i+1,j)) = Σ_s q^{2 Σ s s'} r^{Σ s s''}（周期境界）。
load("_prelude.sage")
import itertools


def Z_by_definition(N_row, M_col):
    total = QR(0)
    for bits in itertools.product([1, -1], repeat=N_row * M_col):
        s = lambda i, j: bits[(i % N_row) * M_col + (j % M_col)]
        h = sum(s(i, j) * s(i, j + 1) for i in range(N_row) for j in range(M_col))
        v = sum(s(i, j) * s(i + 1, j) for i in range(N_row) for j in range(M_col))
        total += q_ ** (2 * h) * r_ ** v
    return total


ok = True
for M_col in (1, 2, 3):
    B, V1, V2 = body_matrices(M_col)
    ok &= (B * B == V1)
    W = (B * V2) * B
    for n in range(1, 5):
        ok &= (power_by_definition(V1 * V2, n).trace() == power_by_definition(W, n).trace())
    # 対照: 平方根でない B' := V_1（B'B' = V_1^2 ≠ V_1）で W' := (B'V_2)B' と置くと、n = 1..4 のどれでも等式が崩れる
    Bp = V1
    ctrl = (Bp * Bp != V1)
    Wp = (Bp * V2) * Bp
    ctrl &= all(power_by_definition(V1 * V2, n).trace() != power_by_definition(Wp, n).trace() for n in range(1, 5))
    ok &= ctrl
    print(f"M_col={M_col}: BB=V1 と tr 等式 ok={ok}、対照={ctrl}")

for (N_row, M_col) in [(1, 1), (1, 2), (2, 1), (2, 2), (2, 3), (3, 2), (3, 3), (4, 2)]:
    B, V1, V2 = body_matrices(M_col)
    W = (B * V2) * B
    lhs = Z_by_definition(N_row, M_col)
    rhs = power_by_definition(W, N_row).trace()
    ok &= (lhs == rhs)
    print(f"(N_row, M_col)=({N_row},{M_col}): Z = tr(W^N_row) は {lhs == rhs}")
exact_result(ok)
