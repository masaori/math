# 対象ラベル: W_real_is_positive_semidefinite
# u = 0 の 5 行の鎖 u^⊤W_ℝu = ΣΣ(u_k(W_ℝ)_kl)u_l = ΣΣ(0·(W_ℝ)_kl)·0 = ΣΣ 0·0 = ΣΣ 0 = 0 と、
# u ≠ 0 の側の u^⊤W_ℝu > 0（W_real_is_positive_definite の当てはめ）を、具体の W（M_col = 2, 3、x, y ∈ {2, 3}）で厳密に（QQ・AA）確かめる。
load("../W_real_is_symmetric/_W_exact.sage")


def bil(x, P, y):
    """def_real_bilinear_value の x^⊤Py := Σ_kΣ_l (x_kP_kl)y_l（左から順に足す）。"""
    n = P.nrows()
    total = 0
    for k in range(n):
        for l in range(n):
            total = total + (x[k] * P[k, l]) * y[l]
    return total


count = 0
for M in [2, 3]:
    n = 2**M
    for xx in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, xx, y)
            S = range(n)
            # u = 0 の側の 5 行の鎖
            u = vector(QQ, [0] * n)
            l1 = bil(u, WR, u)
            l2 = sum((u[k] * WR[k, l]) * u[l] for k in S for l in S)
            l3 = sum((QQ(0) * WR[k, l]) * QQ(0) for k in S for l in S)
            l4 = sum(QQ(0) * QQ(0) for k in S for l in S)
            l5 = sum(QQ(0) for k in S for l in S)
            assert l1 == l2 and l2 == l3 and l3 == l4 and l4 == l5 and l5 == 0, (M, xx, y)
            # u ≠ 0 の側: 零でない u で u^⊤W_ℝu > 0
            for u in [vector(QQ, [k + 1 for k in S]), vector(QQ, [(-1)**k for k in S]),
                      vector(QQ, [1] + [0] * (n - 1)), vector(QQ, [k % 3 - 1 for k in S])]:
                assert u != 0
                assert bil(u, WR, u) > 0, (M, xx, y, u)
                assert bil(u, WR, u) >= 0
            count += 1
# 否定コントロール: 半正定値でない対称な diag(1, −1) では u = (0, 1) で u^⊤Pu < 0
P = matrix(QQ, [[1, 0], [0, -1]])
assert bil(vector(QQ, [0, 1]), P, vector(QQ, [0, 1])) < 0
print(f"{count} 組の W で u = 0 の 5 行の鎖と、零でない u 4 本の u^⊤W_ℝu > 0 を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
