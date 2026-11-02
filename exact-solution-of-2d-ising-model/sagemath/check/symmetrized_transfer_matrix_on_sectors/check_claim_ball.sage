# 対象ラベル: symmetrized_transfer_matrix_on_sectors
# 主張 WP^{(+)} = V^{(+)}P^{(+)} を、本文の行列そのもので確かめる。M_col = 2..4、(K_1, K_2) ∈ {(1/4,1/2), (1/2,1/4), (1,1)}。
# B = exp((1/2)K_1D)・C = exp((i/2)K_1H_1^{(+)}) は本文の部分和と尾の上界のボール、V_2 は def_transfer_matrix の成分の式で
# exp(K_2 n) を実数のボールにしたもの、P^{(+)} は KG で厳密。W := (BV_2)B、V^{(+)} := (CV_2)C。
# 二つの積のボールが全成分で重なることを見る（重なりは等号の必要条件であって証明ではない）。
# 対照: P^{(+)} を掛けない W と V^{(+)}、および P^{(+)} を (1/2)(I - ε)（ε の固有値 -1 の側）に替えた積は、交わらない成分を持つ。
load("_prelude.sage")
for M in range(2, 5):
    n = 2 ** M
    D = bond_sum(M)
    H = H1_plus(M)
    P = to_CB(projector_plus(M))
    Pm = to_CB(body_scalar(KG(1) / 2, body_difference(body_identity(KG, n), epsilon(M))))
    for K1, K2 in [(QQ(1) / 4, QQ(1) / 2), (QQ(1) / 2, QQ(1) / 4), (QQ(1), QQ(1))]:
        B = exp_ball(KG(K1 / 2) * D)
        C = exp_ball((i_K / 2) * KG(K1) * H)
        V2 = V2_by_components(M, lambda m: (RB(K2) * m).exp(), CB)
        W = (B * V2) * B
        Vp = (C * V2) * C
        assert balls_overlap(W * P, Vp * P)
        assert balls_disjoint_somewhere(W, Vp)
        assert balls_disjoint_somewhere(W * Pm, Vp * Pm)
    print(f"  M_col={M}: WP^(+) と V^(+)P^(+) のボールが全成分で重なる。P^(+) を外す・(1/2)(I-ε) に替えると交わらない成分がある")
print("RESULT: PASS")
