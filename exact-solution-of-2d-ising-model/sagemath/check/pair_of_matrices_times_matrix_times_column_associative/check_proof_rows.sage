# 対象ラベル: pair_of_matrices_times_matrix_times_column_associative
# 証明の成分の鎖の 18 行を、成分が独立な不定元の A, B（d × d）と不定元 p, q, r, s, a, b の QQ 上の多項式として
# 行の表記どおりに組み、隣どうしが等しいことと、始点・終点が主張の両辺（二つの定義と mat_mult で組んだもの）であることを確かめる。
# 二つの組の積の定義は本文の成分の式（_shared/matrix_operations_by_definition.sage の body_sum・body_scalar）で作り、
# 3〜7・16〜17 行目の行列の和・スカラー倍は Sage の + と *（成分ごと）で行の表記どおりに組む。厳密（浮動小数点なし）。
load("../../_shared/matrix_operations_by_definition.sage")


def report(ok, label):
    print(("PASS: " if ok else "FAIL: ") + label)
    assert ok, label


def pair_times_column(A, B, a, b):
    """def_pair_of_matrices_times_column_of_numbers の (A, B)(a; b) := aA + bB。"""
    return body_sum(body_scalar(a, A), body_scalar(b, B))


def pair_times_two_by_two(A, B, P):
    """def_pair_of_matrices_times_two_by_two_matrix の (A, B)P := ((A, B)(P_11; P_21), (A, B)(P_12; P_22))。"""
    return (pair_times_column(A, B, P[0, 0], P[1, 0]), pair_times_column(A, B, P[0, 1], P[1, 1]))


def mat_mult_by_definition(P, v):
    """mat_mult の (Pv)_{ik} := Σ_j P_{ij} v_{jk}（和は j = 1, 2 を左から足す）。"""
    return matrix(P.base_ring(), P.nrows(), v.ncols(),
                  lambda i, k: sum((P[i, j] * v[j, k] for j in range(P.ncols())), P.base_ring()(0)))


for d in [1, 2, 3]:
    names = [f"a{r}{c}" for r in range(d) for c in range(d)] + [f"b{r}{c}" for r in range(d) for c in range(d)] + ["p", "q", "r", "s", "va", "vb"]
    Rg = PolynomialRing(QQ, names)
    g = Rg.gens()
    A = matrix(Rg, d, d, g[:d * d])
    B = matrix(Rg, d, d, g[d * d:2 * d * d])
    p, q, r, s, a, b = g[2 * d * d:]
    P = matrix(Rg, 2, 2, [p, q, r, s])
    v = matrix(Rg, 2, 1, [a, b])
    Pv = mat_mult_by_definition(P, v)
    # 主張の両辺（定義どおりに組む）
    first, second = pair_times_two_by_two(A, B, P)
    lhs = pair_times_column(first, second, v[0, 0], v[1, 0])
    rhs = pair_times_column(A, B, Pv[0, 0], Pv[1, 0])
    report(lhs == rhs, f"d={d}: 主張 ((A, B)P)v = (A, B)(Pv)")
    for k in range(d):
        for l in range(d):
            rows = [
                lhs[k, l],                                                                             # 始点
                pair_times_column(pair_times_column(A, B, p, r), pair_times_column(A, B, q, s), a, b)[k, l],   # 1 行目
                pair_times_column(p * A + r * B, q * A + s * B, a, b)[k, l],                           # 2 行目
                (a * (p * A + r * B) + b * (q * A + s * B))[k, l],                                     # 3 行目
                (a * (p * A + r * B))[k, l] + (b * (q * A + s * B))[k, l],                             # 4 行目
                a * (p * A + r * B)[k, l] + b * (q * A + s * B)[k, l],                                 # 5 行目
                a * ((p * A)[k, l] + (r * B)[k, l]) + b * ((q * A)[k, l] + (s * B)[k, l]),             # 6 行目
                a * (p * A[k, l] + r * B[k, l]) + b * (q * A[k, l] + s * B[k, l]),                     # 7 行目
                (a * (p * A[k, l]) + a * (r * B[k, l])) + (b * (q * A[k, l]) + b * (s * B[k, l])),     # 8 行目
                ((a * p) * A[k, l] + (a * r) * B[k, l]) + ((b * q) * A[k, l] + (b * s) * B[k, l]),     # 9 行目
                ((a * p) * A[k, l] + (b * q) * A[k, l]) + ((a * r) * B[k, l] + (b * s) * B[k, l]),     # 10 行目
                (a * p + b * q) * A[k, l] + (a * r + b * s) * B[k, l],                                 # 11 行目
                (p * a + q * b) * A[k, l] + (r * a + s * b) * B[k, l],                                 # 12 行目
                (P[0, 0] * v[0, 0] + P[0, 1] * v[1, 0]) * A[k, l] + (P[1, 0] * v[0, 0] + P[1, 1] * v[1, 0]) * B[k, l],  # 13 行目
                sum(P[0, j] * v[j, 0] for j in range(2)) * A[k, l] + sum(P[1, j] * v[j, 0] for j in range(2)) * B[k, l],  # 14 行目
                Pv[0, 0] * A[k, l] + Pv[1, 0] * B[k, l],                                               # 15 行目
                (Pv[0, 0] * A)[k, l] + (Pv[1, 0] * B)[k, l],                                           # 16 行目
                (Pv[0, 0] * A + Pv[1, 0] * B)[k, l],                                                   # 17 行目
                rhs[k, l],                                                                             # 18 行目
            ]
            for n in range(1, len(rows)):
                report(rows[n - 1] == rows[n], f"d={d} (k,l)=({k + 1},{l + 1}): {n - 1 if n > 1 else '始点'} 行目 = {n} 行目".replace("始点 行目", "始点"))
    # 対照: P の転置、v の成分の入れ替え、(A, B) の入れ替えでは一致しない
    PT = P.transpose()
    report(lhs != pair_times_column(A, B, mat_mult_by_definition(PT, v)[0, 0], mat_mult_by_definition(PT, v)[1, 0]),
           f"d={d}: 対照 (A, B)(P^T v) とは異なる")
    report(lhs != pair_times_column(A, B, Pv[1, 0], Pv[0, 0]), f"d={d}: 対照 (Pv) の成分を入れ替えると異なる")
    report(lhs != pair_times_column(B, A, Pv[0, 0], Pv[1, 0]), f"d={d}: 対照 (B, A)(Pv) とは異なる")
print("RESULT: PASS")
