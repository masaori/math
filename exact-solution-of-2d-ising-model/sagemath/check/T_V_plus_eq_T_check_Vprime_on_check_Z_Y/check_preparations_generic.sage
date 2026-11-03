# 対象ラベル: T_V_plus_eq_T_check_Vprime_on_check_Z_Y
# 証明の準備 1（ψ̌ を Ž, Y̌ で書く、7 個の等号）、準備 2 の δ の鎖（2 個の等号）と準備 2 の本体の鎖（14 個の等号）を一般の点で一行ずつ確かめる。
# 一般の点: X_1, X_2 ∈ Mat(4,ℂ)（R の M_col = 2 の大きさ）の成分と P̌ の成分 p_{kl} を QQ 上の独立な不定元に取り、
#   その分数体の中で q := P̌^{-1}（Sage の inverse。P̌P̌^{-1} = P̌^{-1}P̌ = I を本文の積で確かめてから使う）を作る。
#   Ψ_1, Ψ_2 は def_check_fermi の (Ψ_1, Ψ_2) := (X_1, X_2)P̌ を def_pair_of_matrices_times_two_by_two_matrix で組んだもの。
#   各行を本文の定め方（matrix_operations_by_definition.sage の成分の式、有限和は左から順に足す）で別々に組み、隣り合う行が
#   分数体の元として等しいことを見る。成分の式は不定元に依らないので、R の他の大きさでも同じ行の組み方になる。
# 独立な経路: 準備 1 の終点を Sage の p_{1k}X_1 + p_{2k}X_2 と、準備 2 の終点を Sage の q_{1l}Ψ_1 + q_{2l}Ψ_2 と比べる。
# 対照: 準備 1 を行で読んだ p_{k1}X_1 + p_{k2}X_2、準備 2 を行で読んだ q_{l1}Ψ_1 + q_{l2}Ψ_2、P̌^{-1} の代わりに転置 P̌^T を使った
#   P̌P̌^T は I にならないこと。
load("_prelude.sage")

rep = Report("T_V_plus_eq_T_check_Vprime_on_check_Z_Y: 準備 1・準備 2（一般の不定元）")

d = 4
P0, sc, (X1p, X2p) = generic_ring([('X', d, d), ('W', d, d)], scalars=['p11', 'p12', 'p21', 'p22'])
K = P0.fraction_field()
X1, X2 = X1p.change_ring(K), X2p.change_ring(K)
Xs = [X1, X2]
Pm = matrix(K, 2, 2, [K(v) for v in sc])
Q = Pm.inverse()
I2 = body_identity(K, 2)
rep.check(body_product(Pm, Q) == I2 and body_product(Q, Pm) == I2, "P̌P̌^{-1} = P̌^{-1}P̌ = I（本文の積）")
rep.check(body_product(Pm, Pm.transpose()) != I2, "対照: P̌P̌^T ≠ I")
O = matrix(K, d, d, 0)


def chain(rows, label):
    for k in range(len(rows) - 1):
        rep.check(rows[k] == rows[k + 1], f"{label} 第 {k+1} 式 = 第 {k+2} 式")


def complex_finite_sum(terms):
    """def_finite_sum_of_complex_numbers（左から順に足す）。"""
    total = terms[0]
    for t in terms[1:]:
        total = total + t
    return total


pairP = pair_times_two_by_two((X1, X2), Pm)       # def_check_fermi の (Ψ_1, Ψ_2) := (X_1, X_2)P̌
Psi = [pr(1, pairP), pr(2, pairP)]

# 準備 1
for k in (1, 2):
    c = k - 1
    rows = [
        Psi[c],
        pr(k, (Psi[0], Psi[1])),
        pr(k, pair_times_two_by_two((X1, X2), Pm)),
        pr(k, (pair_times_column(X1, X2, Pm[0, 0], Pm[1, 0]), pair_times_column(X1, X2, Pm[0, 1], Pm[1, 1]))),
        pair_times_column(X1, X2, Pm[0, c], Pm[1, c]),
        body_sum(body_scalar(Pm[0, c], X1), body_scalar(Pm[1, c], X2)),
        body_sum(body_finite_sum([body_scalar(Pm[0, c], X1)]), body_scalar(Pm[1, c], X2)),
        body_finite_sum([body_scalar(Pm[i, c], Xs[i]) for i in range(2)]),
    ]
    assert len(rows) == 8      # Ψ_k と 7 個の等号の右辺
    chain(rows, f"準備 1（k = {k}）")
    rep.check(rows[-1] == Pm[0, c] * X1 + Pm[1, c] * X2, f"準備 1（k = {k}）の終点 = Sage の p_{{1k}}X_1 + p_{{2k}}X_2")
    rep.check(rows[1] != Pm[c, 0] * X1 + Pm[c, 1] * X2, f"対照 準備 1（k = {k}）: 行で読んだ p_{{k1}}X_1 + p_{{k2}}X_2 とは異なる")

# 準備 2 の δ の鎖（i ≠ l）
for (i, l) in ((1, 2), (2, 1)):
    rows = [body_scalar(body_delta(K, i - 1, l - 1), Xs[i - 1]), body_scalar(K(0), Xs[i - 1]), O]
    chain(rows, f"準備 2 の δ の鎖（i = {i}, l = {l}）")

# 準備 2 の本体の鎖
for l in (1, 2):
    L = l - 1
    PQ = body_product(Pm, Q)
    rows = [
        Xs[L],
        body_scalar(K(1), Xs[L]),
        body_scalar(body_delta(K, L, L), Xs[L]),
        body_finite_sum([body_scalar(body_delta(K, i, L), Xs[i]) for i in range(2)]),
        body_finite_sum([body_scalar(I2[i, L], Xs[i]) for i in range(2)]),
        body_finite_sum([body_scalar(PQ[i, L], Xs[i]) for i in range(2)]),
        body_finite_sum([body_scalar(complex_finite_sum([Pm[i, k] * Q[k, L] for k in range(2)]), Xs[i]) for i in range(2)]),
        body_finite_sum([body_scalar(complex_finite_sum([Q[k, L] * Pm[i, k] for k in range(2)]), Xs[i]) for i in range(2)]),
        body_finite_sum([body_finite_sum([body_scalar(Q[k, L] * Pm[i, k], Xs[i]) for k in range(2)]) for i in range(2)]),
        body_finite_sum([body_finite_sum([body_scalar(Q[k, L], body_scalar(Pm[i, k], Xs[i])) for k in range(2)]) for i in range(2)]),
        body_finite_sum([body_finite_sum([body_scalar(Q[k, L], body_scalar(Pm[i, k], Xs[i])) for i in range(2)]) for k in range(2)]),
        body_finite_sum([body_scalar(Q[k, L], body_finite_sum([body_scalar(Pm[i, k], Xs[i]) for i in range(2)])) for k in range(2)]),
        body_finite_sum([body_scalar(Q[k, L], Psi[k]) for k in range(2)]),
        body_sum(body_finite_sum([body_scalar(Q[0, L], Psi[0])]), body_scalar(Q[1, L], Psi[1])),
        body_sum(body_scalar(Q[0, L], Psi[0]), body_scalar(Q[1, L], Psi[1])),
    ]
    assert len(rows) == 15     # X_l と 14 個の等号の右辺
    chain(rows, f"準備 2（l = {l}）")
    rep.check(rows[-1] == Q[0, L] * Psi[0] + Q[1, L] * Psi[1], f"準備 2（l = {l}）の終点 = Sage の q_{{1l}}Ψ_1 + q_{{2l}}Ψ_2")
    rep.check(Xs[L] != Q[L, 0] * Psi[0] + Q[L, 1] * Psi[1], f"対照 準備 2（l = {l}）: 行で読んだ q_{{l1}}Ψ_1 + q_{{l2}}Ψ_2 とは異なる")

rep.finish()
