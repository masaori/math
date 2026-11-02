# 対象ラベル: epsilon_commutes_with_V1_plus_square_root
# 鎖 ε(V_1^(+))^{1/2} = ε exp(cH_1^(+)) = exp(cH_1^(+))ε = (V_1^(+))^{1/2}ε（c = (i/2)K_1）を、K_1 ∈ {1/4, 1/2, 1}、M_col = 2..4 で、
# exp を本文の部分和と尾の上界のボール（Sage の ComplexBallField の exp とも重なる）で囲んで確かめる（ℝ への脱出: exp）。
# 対照: ε を σ_1^z に替えると、二つの積のボールはどこかの成分で交わらない（H_1^(+) の Y_M Z_1 が σ_1^z と反可換）。
load("_prelude.sage")
for M in range(2, 5):
    E = to_CB(epsilon(M))
    H = H1_plus(M)
    for K1 in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        c = (i_K / 2) * K1
        V = exp_ball(c * H)
        assert balls_overlap(E * V, V * E)
        X = to_CB(site(M, 1, 'z'))
        assert balls_disjoint_somewhere(X * V, V * X)
    print(f"  M_col={M}: ε と exp(cH) のボールの積が両順で重なり、σ_1^z では交わらない成分がある")
print("RESULT: PASS")
