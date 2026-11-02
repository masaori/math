# 対象ラベル: epsilon_projector_commutes_with_V1
# 証明の 1 行 P^{(+)}V_1 = V_1P^{(+)}（epsilon_projector_commutes_with_epsilon_commuting_matrix を X → V_1 で適用し、
# その仮定 εV_1 = V_1ε を epsilon_commutes_with_V1 から引く）を、V_1 を def_transfer_matrix の成分の式で組み、
# exp(K_1 n)（n = -M..M）を独立な不定元 w_n に置いて厳密に確かめる。適用の仮定 εV_1 = V_1ε も同じ行列で確かめる。
# 対照: P^{(+)} を (1/2)(I + σ_1^x) に替えると成り立たない（M_col ≥ 2。M_col = 1 の V_1 はスカラー行列）。M_col = 1..5。
load("_prelude.sage")
for M in range(1, 6):
    R = PolynomialRing(KG, [f"w{n + M}" for n in range(-M, M + 1)])
    w = dict(zip(range(-M, M + 1), R.gens()))
    V = V1_by_components(M, lambda n: w[n], R)
    E = epsilon(M).change_ring(R)
    P = projector_plus(M).change_ring(R)
    assert body_product(E, V) == body_product(V, E)          # 適用の仮定
    assert body_product(P, V) == body_product(V, P)          # 主張
    # V_1 は対角なので σ^z の射影子とは可換。対照には (1/2)(I + σ_1^x) を使う。
    # M_col = 1 では σ_1^zσ_{2}^z = σ_1^zσ_1^z = I（周期の延長）で V_1 = w_1 I がスカラー行列なので、対照は M_col ≥ 2 で見る。
    Q = body_scalar(KG(1) / 2, body_sum(body_identity(KG, 2**M), site(M, 1, 'x'))).change_ring(R)
    if M == 1:
        assert V == w[1] * identity_matrix(R, 2)
    else:
        assert body_product(Q, V) != body_product(V, Q)
    note = "V_1 はスカラー行列" if M == 1 else "対照の射影子では成り立たない"
    print(f"  M_col={M}: εV_1 = V_1ε と P^(+)V_1 = V_1P^(+)（成分を不定元に置いて）。{note}")
print("RESULT: PASS")
