# 対象ラベル: epsilon_commutes_with_V2
load("../../_shared/row_configurations.sage")   # V1_by_components・V2_by_components（def_transfer_matrix の成分の式）

# 鎖 εV_2 = ε(c exp(R)) = (c exp(R))ε = V_2ε（ℝ への脱出: exp・log・平方根）。
# (a) R = t Σσ_m^x（t ∈ {1/3, 1, 2} は有理数）で exp を本文の部分和と尾の上界のボールで囲み、ε exp(R) と exp(R)ε が重なること。
# (b) K_2 ∈ {1/2, 1} で K_2^* = -(1/2)log tanh K_2、c = (√(2 sinh 2K_2))^{M_col} を RealBallField で作り、Sage の行列の exp で
#     c exp(K_2^* Σσ^x) を囲んで、εV_2 と V_2ε が重なること、および def_transfer_matrix の成分の式の V_2（exp(K_2 n)）と重なること
#     （second_transfer_matrix_pauli_form の照合）。M_col = 1..3。
# 対照: (a) で ε を σ_1^z に替えると、二つの積のボールはどこかの成分で交わらない。
load("_prelude.sage")
for M in range(1, 4):
    E = to_CB(epsilon(M))
    S = body_finite_sum([site(M, m, 'x') for m in range(1, M + 1)])
    for t in [QQ(1)/3, QQ(1), QQ(2)]:
        X = exp_ball(t * S)
        assert balls_overlap(E * X, X * E)
        Zc = to_CB(site(M, 1, 'z'))
        assert balls_disjoint_somewhere(Zc * X, X * Zc)
    for K2 in [QQ(1)/2, QQ(1)]:
        k = RB(K2)
        K2s = -(k.tanh().log()) / 2
        c = ((2 * (2 * k).sinh()).sqrt())**M
        V = CB(c) * (CB(K2s) * to_CB(S)).exp()
        Vc = V2_by_components(M, lambda n: CB((k * n).exp()), CB)
        assert balls_overlap(V, Vc)
        assert balls_overlap(E * V, V * E)
    print(f"  M_col={M}: ε と exp(tΣσ^x)・V_2 のボールの積が両順で重なり、V_2 は成分の式と重なる")
print("RESULT: PASS")
