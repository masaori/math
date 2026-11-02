# 対象ラベル: epsilon_commutes_with_V1
load("../../_shared/row_configurations.sage")   # V1_by_components・V2_by_components（def_transfer_matrix の成分の式）

# 主張 εV_1 = V_1ε を、V_1 を def_transfer_matrix の成分の式で組み、exp(K_1 n)（n = -M..M）を独立な不定元 w_n に
# 置いて厳密に確かめる（V_1 の成分がどの値であっても、ε の全スピン反転で n が変わらないので成り立つ）。M_col = 1..5。
load("_prelude.sage")
for M in range(1, 6):
    R = PolynomialRing(KG, [f"w{n + M}" for n in range(-M, M + 1)])
    w = dict(zip(range(-M, M + 1), R.gens()))
    V = V1_by_components(M, lambda n: w[n], R)
    E = epsilon(M).change_ring(R)
    assert body_product(E, V) == body_product(V, E)
    print(f"  M_col={M}: εV_1 = V_1ε（成分を不定元に置いて）")
print("RESULT: PASS")
