# 対象ラベル: real_exp_strictly_increasing
# Step 1 の準備の二つの事実を確かめる。
#   ‖[u]_R‖ = √(Σ_{i=1}^{1}Σ_{j=1}^{1}|([u]_R)_ij|^2) = √(|([u]_R)_11|^2) = √(|u|^2) = |u|
#   [u]_R - [v]_R = [u - v]_R
# 帰属: 第一の鎖は具体の u ∈ QQ で、平方根を AA（実代数的数）の中で厳密に取る。def_matrix_norm の n = 1 のノルム
# （成分の絶対値の平方和の非負平方根）を本文どおりに書き、Sage の行列のノルムは使わない。
# 第二の事実は QQ[u, v] の不定元で確かめる。
load("../../_shared/one_by_one_matrix.sage")


def body_norm(A):
    """def_matrix_norm の ‖A‖ = √(Σ_i Σ_j |a_ij|^2)（非負の平方根）。A の成分は QQ。AA の中で厳密に取る。"""
    total = sum(abs(entry(A, i, j))^2 for i in range(1, A.nrows() + 1) for j in range(1, A.ncols() + 1))
    r = AA(total).sqrt()
    assert r >= 0 and r^2 == total
    return r


for u in [QQ(0), QQ(1), QQ(-1), QQ(3) / 7, QQ(-22) / 5, QQ(10)^30, -QQ(10)^30]:
    U = one_by_one(QQ, u)
    chain = [body_norm(U), AA(abs(entry11(U))^2).sqrt(), AA(abs(u)^2).sqrt(), AA(abs(u))]
    assert all(c == chain[0] for c in chain), u
    # √(|u|^2) が |u| であるのは、|u| が |u|^2 の非負の平方根であり、それがただ一つだから。
    # 対照として、もう一つの平方根 -|u| は u ≠ 0 のとき非負でない。
    assert AA(abs(u))^2 == abs(u)^2 and (u == 0 or -abs(u) < 0)
print("7 点で ‖[u]_R‖ = √(Σ_i Σ_j |([u]_R)_ij|^2) = √(|([u]_R)_11|^2) = √(|u|^2) = |u| が AA で厳密に成り立つ")

R = PolynomialRing(QQ, 'u,v')
u, v = R.gens()
# 本文の鎖 [u]-[v] = [([u]-[v])_11] = [([u])_11 - ([v])_11] = [u - v]。差の成分は本文どおり成分の差として書く。
U, V = one_by_one(R, u), one_by_one(R, v)
diff = U - V
chain = [diff, one_by_one(R, entry11(diff)), one_by_one(R, entry11(U) - entry11(V)), one_by_one(R, u - v)]
assert all(c == chain[0] for c in chain)
assert entry11(diff) == u - v
print("[u]_R - [v]_R = [([u]-[v])_11] = [([u])_11 - ([v])_11] = [u - v]_R が QQ[u,v] で成り立つ")
print("RESULT: PASS")
