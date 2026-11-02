# 対象ラベル: epsilon_projector_commutes_with_V2
# 証明の 1 行 P^{(+)}V_2 = V_2P^{(+)}（epsilon_projector_commutes_with_epsilon_commuting_matrix を X → V_2 で適用し、
# その仮定 εV_2 = V_2ε を epsilon_commutes_with_V2 から引く）を、V_2 を def_transfer_matrix の成分の式で組み、
# exp(K_2 n)（n = -M..M）を独立な不定元 w_n に置いて厳密に確かめる。適用の仮定 εV_2 = V_2ε も同じ行列で確かめる。
# 対照: P^{(+)} を (1/2)(I + σ_1^z) に替えると、成り立たない（ε を経ない射影子では従わない）。M_col = 1..5。
load("_prelude.sage")
for M in range(1, 6):
    R = PolynomialRing(KG, [f"w{n + M}" for n in range(-M, M + 1)])
    w = dict(zip(range(-M, M + 1), R.gens()))
    V = V2_by_components(M, lambda n: w[n], R)
    E = epsilon(M).change_ring(R)
    P = projector_plus(M).change_ring(R)
    assert body_product(E, V) == body_product(V, E)          # 適用の仮定
    assert body_product(P, V) == body_product(V, P)          # 主張
    Q = control_projector(M).change_ring(R)
    
    assert body_product(Q, V) != body_product(V, Q)
    print(f"  M_col={M}: εV_2 = V_2ε と P^(+)V_2 = V_2P^(+)（成分を不定元に置いて）。対照の射影子では成り立たない")
print("RESULT: PASS")
