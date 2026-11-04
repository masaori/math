# 対象ラベル: eigenvalues_of_inverse_of_check_Vprime
# 主張 (V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_ℂ Q̌_ε そのものを、証明の行を経ずに確かめる。ň_μ・γ_μ は
# ../eigenvalues_of_check_Vprime/_vprime_settings.sage の ball_settings から取る（既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と
# 有理数 γ_μ、M_col = 2, 3, 4。check_with_check_psi.sage からは本文の ψ̌ の ň_μ と γ(θ̃_μ) の実際の値、結合定数 3 組 × M_col = 2, 3）。
#   V̌' := exp(X̌)、X̌ := Σ_μ γ_μ(ň_μ − (1/2)I)（def_check_number_operator (2)）を、Sage の球の行列の exp と、def_exp の部分和に尾の上界を
#   足した球（exp_ball_by_partial_sums）の二つの経路で作り、重なることを確かめてから使う。
#   (V̌')^{-1} は Sage の球の行列の逆行列で作り、(V̌')^{-1}V̌' と V̌'(V̌')^{-1} が I と重なることを確かめる。
#   (i)  (V̌')^{-1}Q̌_ε と (exp(−ǧ(ε)))_ℂ Q̌_ε が重なる（全ての ε。半径 < 10^{-80}）。
#   (ii) 逆行列を作らない経路: V̌'((exp(−ǧ(ε)))_ℂ Q̌_ε) が Q̌_ε と重なる（V̌' は可逆なので (i) と同値）。
# 否定コントロール: ǧ(ε) が 0 を含まない ε で、(V̌')^{-1}Q̌_ε が (exp(+ǧ(ε)))_ℂ Q̌_ε と重ならないこと。
# 帰属: Q̌_ε は QQ か本文の ψ̌ の数体 F の上の厳密な行列。γ_μ・ǧ(ε)・exp・V̌'・(V̌')^{-1} は ℝ・ℂ の値を囲む球
#   （ℝ への脱出: arccosh の実対数、実数の exp と行列の exp の値。いずれも極限で定まる）。
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")
import itertools

claim_count = 0
claim_neg = 0
tol = RBv(10) ** -80


def claim(ok, label):
    global claim_count
    assert ok, label
    claim_count += 1


for (tag, M, F, ns, gams, to_cb, g1s) in ball_settings([2, 3, 4]):
    N = 2 ^ M
    IdF = identity_matrix(F, N)
    IdC = identity_matrix(CBv, N)
    nC = [mat_to_cb(A, to_cb) for A in ns]
    X = sum(CBv(gams[mu]) * (nC[mu] - IdC / 2) for mu in range(M))
    V = X.exp()
    claim(balls_overlap_mat(V, exp_ball_by_partial_sums(X)) and max_radius(V) < tol, (tag, "V̌' の二つの経路"))
    Vinv = V.inverse()
    claim(balls_overlap_mat(Vinv * V, IdC) and balls_overlap_mat(V * Vinv, IdC) and max_radius(Vinv) < tol, (tag, "(V̌')^{-1}"))
    for eps in itertools.product([1, 0], repeat=M):
        Q = joint_projector(ns, eps, IdF)
        assert Q != 0
        QC = mat_to_cb(Q, to_cb)
        g = gcheck_ball(gams, eps)
        lhs = Vinv * QC
        rhs = CBv((-g).exp()) * QC
        claim(balls_overlap_mat(lhs, rhs) and max(max_radius(lhs), max_radius(rhs)) < tol, (tag, eps, "(i)"))
        back = V * rhs
        claim(balls_overlap_mat(back, QC) and max_radius(back) < tol, (tag, eps, "(ii)"))
        if not g.contains_zero():
            assert not balls_overlap_mat(lhs, CBv(g.exp()) * QC), (tag, eps, "否定コントロール")
            claim_neg += 1
    print(f"  {tag}: 主張 {claim_count} 件まで、否定コントロール {claim_neg} 件まで", flush=True)

print(f"checked {claim_count} claims and {claim_neg} negative controls")
print("RESULT: PASS")
