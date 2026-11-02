# 対象ラベル: epsilon_projector_commutes_with_V1_plus_square_root
# 証明の 1 行 P^{(+)}(V_1^(+))^{1/2} = (V_1^(+))^{1/2}P^{(+)}（epsilon_projector_commutes_with_epsilon_commuting_matrix を X → (V_1^(+))^{1/2} で適用し、
# その仮定を epsilon_commutes_with_V1_plus_square_root から引く）を、(V_1^(+))^{1/2} = exp(cH_1^(+))（c = (i/2)K_1）として、
# K_1 ∈ {1/4, 1/2, 1}、M_col = 2..4 で確かめる。P^{(+)} は KG で厳密、exp は ℝ への脱出を含むので、本文の部分和と尾の上界のボール
# （Sage の ComplexBallField の exp とも重なる）で囲み、二つの積のボールが全成分で重なることを見る。適用の仮定（ε との可換）も同じボールで見る。
# 対照: P^{(+)} を (1/2)(I + σ_1^z) に替えると、二つの積のボールはどこかの成分で交わらない（H_1^(+) の Y_M Z_1 が σ_1^z と反可換）。
load("_prelude.sage")
for M in range(2, 5):
    E = to_CB(epsilon(M))
    P = to_CB(projector_plus(M))
    Q = to_CB(control_projector(M))
    H = H1_plus(M)
    for K1 in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        c = (i_K / 2) * K1
        V = exp_ball(c * H)
        assert balls_overlap(E * V, V * E)       # 適用の仮定
        assert balls_overlap(P * V, V * P)       # 主張
        assert balls_disjoint_somewhere(Q * V, V * Q)
    print(f"  M_col={M}: εV = Vε と P^(+)V = VP^(+) のボールが全成分で重なり、対照の射影子では交わらない成分がある")
print("RESULT: PASS")
