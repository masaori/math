# 対象ラベル: epsilon_commutes_with_V1
load("../../_shared/row_configurations.sage")   # V1_by_components・V2_by_components（def_transfer_matrix の成分の式）

# 鎖 εV_1 = ε exp(K_1 D) = exp(K_1 D)ε = V_1ε を、K_1 ∈ {1/4, 1/2, 1}、M_col = 1..3 で、exp を本文の部分和と尾の上界の
# ボール（Sage の ComplexBallField の exp とも重なることを確かめる）で囲んで確かめる（ℝ への脱出: exp）。
# 第 1・3 行が引く first_transfer_matrix_pauli_form は、def_transfer_matrix の成分の式（exp(K_1 n) を RealBallField で）
# と exp(K_1 D) のボールが重なることで照合する。
# 対照: M_col ≥ 2 で ε を σ_1^x に替えると、二つの積のボールはどこかの成分で交わらない。
load("_prelude.sage")
for M in range(1, 4):
    E = to_CB(epsilon(M))
    for K1 in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        V = exp_ball(K1 * bond_sum(M))
        Vc = V1_by_components(M, lambda n: CB(RB(K1 * n).exp()), CB)
        assert balls_overlap(V, Vc)
        assert balls_overlap(E * V, V * E)
        if M >= 2:
            X = to_CB(site(M, 1, 'x'))
            assert balls_disjoint_somewhere(X * V, V * X)
    print(f"  M_col={M}: K_1 = 1/4, 1/2, 1 で ε exp(K_1 D) と exp(K_1 D)ε のボールが重なる")
print("RESULT: PASS")
